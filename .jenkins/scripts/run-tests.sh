#!/bin/bash

# Get test report filename
TEST_REPORT_FILE=$1

# Run the tests
echo "Running the tests"
npx vitest run > $TEST_REPORT_FILE