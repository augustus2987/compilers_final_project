#!/bin/bash

BASE_DIR=`dirname $(realpath $0)`
pushd $BASE_DIR
make -C runtime > /dev/null && make > /dev/null
pushd $BASE_DIR/tests

echo "Running mytests Tests:"
pytest --pyyctests mytests/ 

echo "Running additional-tests/P0 Tests:"
pytest --pyyctests additional-tests/P0/ 

echo "Running additional-tests/P1 Tests:"
pytest --pyyctests additional-tests/P1/ 