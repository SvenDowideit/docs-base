#!/bin/bash  
set -e

echo "test to check the markdown files start with the Hugo metadata preamble"
shopt -s globstar

for f in /docs/content/**/*.md ; do
  echo "$f"
  sed '/+++/,/+++/!d' "$f" | grep 'title ='
done

# make sure Hugo is happy
hugo --config=config.toml --log=true --stepAnalysis=true
