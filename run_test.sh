#!/bin/bash

echo "Running test $1.py"
./pyyc tests/mytests/$1.py --pprint
gcc -m32 -g tests/mytests/$1.s runtime/libpyyruntime.a -lm -o tests/mytests/$1
./tests/mytests/$1
