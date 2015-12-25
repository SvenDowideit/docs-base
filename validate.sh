#!/bin/bash

JUNITFILE="/validate.junit.xml"

# run(jobname, command)
function run() {
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "running $1"
	"$@"
	ERRORS=$?
	echo "ERRORS = $ERRORS"
	if [ $ERRORS -ne 0 ]; then
		echo "<testsuite><testcase classname='$1' name='Tests'><failure>$ERRORS errors</failure></testcase></testsuite>" >> "$JUNITFILE"
		echo "</testsuites>" >> "$JUNITFILE"
		exit $ERRORS
	fi

	echo "<testsuite><testcase classname='$1' name='Tests'></testcase></testsuite>" >> "$JUNITFILE"
}


echo "<testsuites>" > "$JUNITFILE"
run "markdownlint" "/docs/content/" "$PROJECT"
run "hugo" --config=config.toml --log=true --stepAnalysis=true
echo "</testsuites>" >> "$JUNITFILE"

echo "$0 output written to $JUNITFILE"
cat "$JUNITFILE"
