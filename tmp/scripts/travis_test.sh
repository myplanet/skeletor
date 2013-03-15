#!/usr/bin/env bash

# Start serving the site
php \
  --server 127.0.0.1:8080 \
  --docroot $TRAVIS_BUILD_DIR/build &

# Default to failing if incomplete
export PASS_STATE=false

# Running selenium tests.
cd $TRAVIS_BUILD_DIR/tmp/tests
TEST_CMD='se-interpreter selenium/interpreter_config.json'

if $TEST_CMD; then
  PASS_STATE=true
  exit 0
else
  exit 1
fi
