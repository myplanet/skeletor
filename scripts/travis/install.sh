#!/usr/bin/env bash

set -e
# Increase max_allowed_packet so it's easier to revert features.
mysql -e "SET GLOBAL max_allowed_packet=128*1024*1024;"

# Install Compass
gem update --system
gem install sass --version "=3.4.12"
gem install compass --version "=1.0.3"

# Run the make script.
echo "::Running build"
BUILD_ENV="";
#if [[ $TRAVIS_PULL_REQUEST == 'false' ]]; then
  echo "::Using production settings."
  BUILD_ENV="prod";
#fi

bash $PROJECT_ROOT/scripts/build.sh $PROFILE $BUILD_ENV

# Copy local settings file for Travis env to the test folder.
cp scripts/travis/assets/settings.local.php docroot/sites/default/settings.local.php

echo  "::Importing development database"
cd ${PROJECT_ROOT}/docroot

# Install profile to dev DB.
drush si $PROFILE -y

echo  "::Updating Drupal environment"
drush -y updatedb

echo  "::Import configs if they exist"
export DIR=/config/sync
if ls ${DIR}/*.yml &>/dev/null
then
  drush -y config-import
else
    echo "Config sync directory is empty."
fi
drush cache-rebuild
