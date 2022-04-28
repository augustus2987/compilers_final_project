#!/bin/bash

set -e 

# assuming you have the lab4 code at ../lab4-*, this
# should compare the # of lines of the assembly from 
# HW4 (dynamically typed) to the new statically typed 
# implementation
target=`realpath $1`

echo "Comparing for ${1}..."
echo -n "-> Compiling statically typed... "
pushd `dirname $0` > /dev/null
./pyyc ${target} 2>&1 > /dev/null
dir_base=`dirname $target`
basename=`basename -s .py $target`
out=${dir_base}/${basename}.s
num_static=`cat ${out} | wc -l`
echo "$num_static lines."

echo -n "-> Compiling dynamically typed... "
pushd ../lab4* > /dev/null
temp=`mktemp -d`
base=`basename $target`
cp $target $temp
sed -i 's/^int //' $temp/$base
sed -i 's/^bool //' $temp/$base
sed -i 's/^dict //' $temp/$base
sed -i 's/^list //' $temp/$base
./pyyc ${temp}/${base} 2>&1 > /dev/null
basename=`basename -s .py $target`
out=/tmp/tmp.s
num_static=`cat ${out} | wc -l`
echo "$num_static lines."
