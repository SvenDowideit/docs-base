#!/bin/bash

set -e

# Some defaults so we can run outside Jenkins
echo "target branch: ${ghprbTargetBranch:=master}"
echo "head commit: ${ghprbActualCommit:=$(git rev-parse --verify HEAD)}"

# Clear out old results
rm -f *junit.xml

export PR_BRANCH_BASE=$(git show-branch --sha1-name --current --merge-base origin/$ghprbTargetBranch)
echo "$PR_BRANCH_BASE..$ghprbActualCommit"

if git diff --name-only "$PR_BRANCH_BASE..$ghprbActualCommit" | grep "^docs/" ;then 
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

git log --format=oneline "$PR_BRANCH_BASE..$ghprbActualCommit"
set -x # echo on
docker pull $(grep FROM docs/Dockerfile | sed s/FROM//)
docker build -t "$JOBIMAGE" docs
# lots more Dockerfile changes needed to improve this.
docker run --name "$JOBCONTAINER" "$JOBIMAGE" || true

# some older branches may not have the xml output yet, so fornow we'll skip them
docker cp "$JOBCONTAINER:/validate.junit.xml" . \
	|| echo '<testsuite tests="1"><testcase classname="validate" name="NoJunitFile"><skipped /></testcase></testsuite>' > junit.xml

docker cp "$JOBCONTAINER:/docs/markdownlint.summary.txt" . \
	|| echo "No "markdownlint.summary.txt" file found"

docker rm -vf "$JOBCONTAINER"  || true
docker rmi "$JOBIMAGE" || true

# Show what we're sending to Jenkins/GH in the console log
more *junit.xml | cat
