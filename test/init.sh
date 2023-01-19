#!/bin/bash

WORKING_DIR="$PWD"

cd "$(dirname $0)"

TEST_DIR="$PWD/test-environment"

if command -v fish >>/dev/null 2>&1; then
    HOME="$TEST_DIR" ../init.sh --no-config-root
    fish -c "alias --save nvim_test=\"HOME='$TEST_DIR' nvim\""
else
    echo -e "\033[0mTest environment initialization failed, reason: fish not found.\033[0m"
fi
