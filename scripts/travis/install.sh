#!/usr/bin/env bash

set -e

mysql -e "CREATE DATABASE IF NOT EXISTS ${PROFILE};"

# Run the make script.
echo "::Running build"
COMPOSER_COMMAND="install --no-suggest";

# If this isn't a pull request, pass the production flag.
if [[ $TRAVIS_PULL_REQUEST == 'false' ]]; then
  echo "::Using production settings."
  COMPOSER_COMMAND="deploy";
fi

composer $COMPOSER_COMMAND

# Copy local settings file for Travis env to the site folder.
echo  "::Copying local settings file to the site folder"
cp ${PROJECT_ROOT}/scripts/travis/assets/settings.local.php ${PROJECT_ROOT}/docroot/sites/default/settings.local.php

cd ${PROJECT_ROOT}/docroot

# Install profile to dev DB.
echo  "::Installing profile ${PROFILE}"
drush si $PROFILE -y

export DIR=../config/sync
if [[ -e ${DIR}/*.yml ]]; then
  echo  "::Importing configuration"
  drush -y config-import
fi
drush cache-rebuild
