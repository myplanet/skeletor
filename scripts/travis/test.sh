#!/usr/bin/env bash

set -e

# Insert smoke tests here!
cd ${PROJECT_ROOT}/docroot
drush cache-rebuild
drush core-cron

# Exit with true value
true
