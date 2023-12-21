#!/bin/bash

# Check if at least one argument is supplied
if [ "$#" -lt 1 ]; then
    echo "Usage: ./script.sh <file1> [<file2> ...]"
    exit 1
fi

# Loop over all arguments
for file in "$@"; do
    # Run nasm on each input file
    nasm -fobj "${file}"
done

# Run alink on all the output .obj files
alink *.obj -oPE -subsys console -entry start -o main.exe
