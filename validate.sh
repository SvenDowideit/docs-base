#!/bin/bash  
echo "running markdownlint"
/usr/local/bin/markdownlint /docs/content/ "$PROJECT"
ERRORS=$?
echo "ERRORS = $ERRORS"
if [ $ERRORS -ne 0 ]; then
	echo "<testsuite tests='1'><testcase classname='markdownlint' name='DocChanges'><failure>$ERRORS markdownlint errors</failure></testcase></testsuite>" > markdownlint.junit.xml
	exit $ERRORS
fi

# until markdownlint can output a junit.xml
echo '<testsuite tests="1"><testcase classname="markdownlint" name="DocChanges"></testcase></testsuite>' > markdownlint.junit.xml

echo "running a Hugo build"
hugo --config=config.toml --log=true --stepAnalysis=true
echo '<testsuite tests="1"><testcase classname="hugo" name="Build"></testcase></testsuite>' > hugo.junit.xml

