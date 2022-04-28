#!/bin/bash

CONTAINER_PATH=/compilers/lab5-peskin-augustus/

if [ ! -f runtime/libpyyruntime.a ]; then
	make 
	make -C runtime
fi
echo "Running test $1.py"
./pyyc tests/mytests/$1.py --pprint
echo "GCC Compilation"
gcc -m32 -g tests/mytests/$1.s runtime/libpyyruntime.a -lm -o tests/mytests/$1
echo "Running Executable"
./tests/mytests/$1
