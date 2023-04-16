#!/usr/bin/env bash

if [[ -z "$(command -v 'hyperfine')" ]]; then
	>&2 echo "hyperfine not found, please install it! Aborting..."
	exit 1;
fi
timestamp="$(date +%Y-%m-%d_%H-%M)"

# Get into file cache
hyperfine --prepare 'cat random-doublequote.gen.sh random-singlequote.gen.sh random-noquote.gen.sh > /dev/null' \
	--parameter-list shell bash,zsh,ksh \
	'{shell} random-singlequote.gen.sh' \
	'{shell} random-doublequote.gen.sh' \
	'{shell} random-noquote.gen.sh' \
	--export-csv "results-${timestamp}.csv" \
	--export-json "results-${timestamp}.json" \
	--export-markdown "results-${timestamp}.md"

