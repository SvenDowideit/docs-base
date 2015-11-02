#!/bin/bash  
set -e

echo "running markdownlint"
/usr/local/bin/markdownlint /docs/content/

echo "running a Hugo build"
hugo --config=config.toml --log=true --stepAnalysis=true
