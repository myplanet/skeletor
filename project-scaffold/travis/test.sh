#!/usr/bin/env bash

set -e

# Insert smoke tests here!
cd ${TRAVIS_BUILD_DIR}/docroot
drush cache-rebuild
drush core-cron

# Exit with true value
true
