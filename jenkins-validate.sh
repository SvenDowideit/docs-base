#!/bin/bash

set -e 

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

git log --format=oneline "$PR_BRANCH_BASE..$ghprbActualCommit"
cd docs
docker pull $(grep FROM Dockerfile | sed s/FROM//)
docker build -t "$BUILD_TAG:$ghprbActualCommit" .
# lots more Dockerfile changes needed to improve this.
docker run --name "$BUILD_TAG-$ghprbActualCommit" "$BUILD_TAG:$ghprbActualCommit"
docker cp "$BUILD_TAG$ghprbActualCommit:/docs/*junit.xml" .


docker rm -vf "$BUILD_TAG$ghprbActualCommit"  || true
docker rmi "$BUILD_TAG:$ghprbActualCommit" || true
