#!/usr/bin/env bash

set -e

if [[ -d "${TRAVIS_BUILD_DIR}/web" ]]; then
  cd ${TRAVIS_BUILD_DIR}/web
elif [[ -d "${TRAVIS_BUILD_DIR}/docroot" ]]; then
  cd ${TRAVIS_BUILD_DIR}/docroot
else
  echo "ERROR: Unable to find webroot directory"
  exit 1
fi
# Insert smoke tests here!
drush cache-rebuild
drush core-cron

# Exit with true value
true
