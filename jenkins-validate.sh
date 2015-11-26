#!/bin/bash

set -e 

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
	exit 0
fi

JOBIMAGE="$BUILD_TAG:$ghprbActualCommit"
JOBCONTAINER="$BUILD_TAG-$ghprbActualCommit"

git log --format=oneline "$PR_BRANCH_BASE..$ghprbActualCommit"
cd docs
docker pull $(grep FROM Dockerfile | sed s/FROM//)
docker build -t "$JOBIMAGE" .
# lots more Dockerfile changes needed to improve this.
docker run --name "$JOBCONTAINER" "$JOBIMAGE"
docker cp "$JOBCONTAINER:/docs/validate.junit.xml" .


docker rm -vf "$JOBCONTAINER"  || true
docker rmi "$JOBIMAGE" || true

# Show what we're sending to Jenkins/GH in the console log
more *junit.xml | cat
