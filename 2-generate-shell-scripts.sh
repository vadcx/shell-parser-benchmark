#!/usr/bin/env sh
set -e

./gen-shell-file.lua

cp -f random-strings.gen.sh random-doublequote.gen.sh

sed -e 's/"/'\'"/g" random-strings.gen.sh > random-singlequote.gen.sh
sed -e 's/"//g' random-strings.gen.sh > random-noquote.gen.sh

>&2 echo "Files generated! Now run the benchmark with ./run-benchmark.sh"
