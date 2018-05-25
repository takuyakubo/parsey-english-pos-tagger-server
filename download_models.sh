#!/usr/bin/env bash
languages=(
  "English"
)
for lang in "${languages[@]}"
do
  curl http://download.tensorflow.org/models/parsey_universal/$lang.zip -o $lang.zip
  unzip $lang.zip
  rm $lang.zip
done
