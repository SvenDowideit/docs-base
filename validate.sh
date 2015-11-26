#!/bin/bash  

# run(jobname, command)
function run() {
	echo "running $1"
	"$2"
	ERRORS=$?
	echo "ERRORS = $ERRORS"
	if [ $ERRORS -ne 0 ]; then
		echo "<testsuite><testcase classname='$1' name='Tests'><failure>$ERRORS errors</failure></testcase></testsuite>" >> validate.junit.xml
		echo "</testsuites>" >> validate.junit.xml
		exit $ERRORS
	fi

	echo '<testsuite><testcase classname="$1" name="Tests"></testcase></testsuite>' >> validate.junit.xml
}


echo "<testsuites>" > validate.junit.xml
run "markdownlint" "/usr/local/bin/markdownlint /docs/content/ $PROJECT"
run "hugo" "hugo --config=config.toml --log=true --stepAnalysis=true"
echo "</testsuites>" >> validate.junit.xml



