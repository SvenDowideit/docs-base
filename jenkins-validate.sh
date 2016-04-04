#!/bin/bash

# This script is used by the documenation pull request jenkins GitHub PR Builder jobs to
# determine if the PR contains any documenation changes (files in $DOCSDIR)
# and if not, to exit quickly.
# If changes are detected, it will run the docs image with the default CMD (validate.sh)
# and run hugo, and collate the errors in the xml format that can be sent back to GitHub.

# You can run it locally, setting DOCSDIR, ghprbTargetBranch and CHECK_PROJECT if the
# defaults are not what you need to test.
# for example:
# ~/registry# ./jenkins-validate.sh
# the pinata project needs special settings because its documentation files are not in a standard location.
# ~/pinata# DOCSDIR=v1/docs/ CHECK_PROJECT="" ./jenkins-validate.sh

set -e

: ${DOCSDIR:=docs/}
: ${ghprbTargetBranch:=master}
: ${ghprbActualCommit:=$(git rev-parse --verify HEAD)}

# not running as a Jenkins job
if [ -v ${BUILD_TAG+x} ]; then
	echo "Not running as a Jenkins job"
	BUILD_TAG="localjenkinstest"
fi

# set CHECK_PROJECT="" if you want to check all markdown files
# leave unset to default to the $PROJECT - set in each Dockerfile
if [ -z ${CHECK_PROJECT+x} ]; then
	echo "CHECK_PROJECT unset"
else
	echo "CHECK_PROJECT set to '$CHECK_PROJECT'"
fi

echo "Checking for documentation changes in ${DOCSDIR}"
echo "target branch: ${ghprbTargetBranch}"
echo "head commit: ${ghprbActualCommit}"

# Clear out old results
rm -f *junit.xml

export PR_BRANCH_BASE=$(git show-branch --sha1-name --current --merge-base origin/$ghprbTargetBranch)
echo "$PR_BRANCH_BASE..$ghprbActualCommit"

if git diff --name-only "$PR_BRANCH_BASE..$ghprbActualCommit" | grep "^${DOCSDIR}" ;then
	echo "testing docs changes"
	echo "===================="
else
	echo "no docs changes"
	echo '<testsuite tests="1"><testcase classname="markdownlint" name="NoDocChanges"><skipped /></testcase></testsuite>' > junit.xml
	if [ -z ${FORCE} ]; then
		exit 0
	fi
fi

JOBIMAGE="$BUILD_TAG:$ghprbActualCommit"
JOBCONTAINER="$BUILD_TAG-$ghprbActualCommit"

git --no-pager log --format=oneline "$PR_BRANCH_BASE..$ghprbActualCommit"
set -x # echo on
BASE_IMAGE=$(grep "^FROM" ${DOCSDIR}Dockerfile | sed s/FROM//)
if [[ $BASE_IMAGE == *"docs/base"* ]]; then
	docker pull $BASE_IMAGE
else
	echo "not re-pulling $BASE_IMAGE as its not 'docs/base'"
fi
docker build -t "$JOBIMAGE" ${DOCSDIR}
# lots more Dockerfile changes needed to improve this.
docker run --name "$JOBCONTAINER" -e CHECK_PROJECT "$JOBIMAGE" || true

# some older branches may not have the xml output yet, so fornow we'll skip them
docker cp "$JOBCONTAINER:/validate.junit.xml" . \
	|| echo '<testsuite tests="1"><testcase classname="validate" name="NoJunitFile"><skipped /></testcase></testsuite>' > junit.xml

docker cp "$JOBCONTAINER:/docs/markdownlint.summary.txt" . \
	|| echo "No "markdownlint.summary.txt" file found"

docker rm -vf "$JOBCONTAINER"  || true
docker rmi "$JOBIMAGE" || true

# Show what we're sending to Jenkins/GH in the console log
more *junit.xml | cat
