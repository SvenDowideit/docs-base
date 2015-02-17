#!/usr/bin/env bash
set -e

set -o pipefail

usage() {
	exit 1
}

if [[ -e MAINTAINERS ]]; then
	cp  MAINTAINERS /docs/sources/humans.txt
fi

VERSION=$(cat VERSION) \
    && MAJOR_MINOR="${VERSION%.*}" \
    && for i in $(seq $MAJOR_MINOR -0.1 1.0); do \
            echo "<li><a class='version' href='/v$i'>Version v$i</a></li>"; \
    done > sources/versions.html_fragment \
    && GIT_BRANCH=$(cat GIT_BRANCH) \
    && GITCOMMIT=$(cat GITCOMMIT) \
    && AWS_S3_BUCKET=$(cat AWS_S3_BUCKET) \
    && BUILD_DATE=$(date) \
    && sed -i "s/\$VERSION/$VERSION/g" theme/mkdocs/base.html \
    && sed -i "s/\$MAJOR_MINOR/v$MAJOR_MINOR/g" theme/mkdocs/base.html \
    && sed -i "s/\$GITCOMMIT/$GITCOMMIT/g" theme/mkdocs/base.html \
    && sed -i "s/\$GIT_BRANCH/$GIT_BRANCH/g" theme/mkdocs/base.html \
    && sed -i "s/\$BUILD_DATE/$BUILD_DATE/g" theme/mkdocs/base.html \
    && sed -i "s/\$AWS_S3_BUCKET/$AWS_S3_BUCKET/g" theme/mkdocs/base.html

exit 0
# fails when there are none!
cd sources
files=$(rgrep --files-with-matches '{{ include ".*" }}')
if [[ "$files" != "" ]]; then
	rgrep --files-with-matches '{{ include ".*" }}' | xargs sed -i~ 's/{{ include "\(.*\)" }}/cat include\/\1/ge'
fi
cd ..

#Stop here for now
exit 0

extrafiles=($(find . -name "mkdocs-*.yml"))
extralines=()

for file in "${extrafiles[@]}"
do
	#echo "LOADING $file"
	while read line
	do
		if [[ "$line" != "" ]]
		then
			extralines+=("$line")

			#echo "LINE (${#extralines[@]}):  $line"
		fi
	done < <(cat "$file")
done

#echo "extra count (${#extralines[@]})"
mv mkdocs.yml mkdocs.yml.bak
echo "# Generated mkdocs.yml from ${extrafiles[@]}"
echo "# Generated mkdocs.yml from ${extrafiles[@]}" > mkdocs.yml

while read line
do
	menu=$(echo $line | sed "s/^- \['\([^']*\)', '\([^']*\)'.*/\2/")
	if [[ "$menu" != "**HIDDEN**" ]]
		# or starts with a '#'?
	then
		if [[ "$lastmenu" != "" && "$lastmenu" != "$menu" ]]
		then
			# insert extra elements here
			for extra in "${extralines[@]}"
			do
				#echo "EXTRA $extra"
				extramenu=$(echo $extra | sed "s/^- \['\([^']*\)', '\([^']*\)'.*/\2/")
				if [[ "$extramenu" == "$lastmenu" ]]
				then
					echo "$extra" >> mkdocs.yml
				fi
			done
			#echo "# JUST FINISHED $lastmenu"
		fi
		lastmenu="$menu"
	fi
	echo "$line" >> mkdocs.yml

done < <(cat "mkdocs.yml.bak")


# remove `^---*` lines from md's
find . -name "*.md" | xargs sed -i~ -n '/^---*/!p'

