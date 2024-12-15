#!/bin/bash
# ffmpeg video merger
# By: github.com/carrotflowerr
# Written: 2024-12-15
# Using: Neovim

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <output> <input1 [input2 ...]>"
  exit 1
fi

outputFile="$1"
# shift arguments
shift

# temporary file for list input files
listFile=$(mktemp) #mktemp is my new fav command

# write input file 
for input in "$@"; do
  absPath=$(realpath "$input")
  if [ ! -f "$absPath" ]; then
    echo "Error: File $input does not exist."
    rm -f "$listFile"
    exit 1
  fi
  echo "file '$absPath'" >> "$listFile" # >> to append
done

# concatenate files
ffmpeg -f concat -safe 0 -i "$listFile" -c copy "$outputFile"

if [ $? -eq 0 ]; then
  echo "Files combined successfully into $outputFile"
else
  echo "Error combining files."
fi

rm -f "$listFile"
