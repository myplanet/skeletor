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

# Pass a commit if we're building a pull-request
if [[ $TRAVIS_PULL_REQUEST == 'false' ]]; then
  BUILD_COMMIT=${TRAVIS_PULL_REQUEST}
  echo "::Using production settings."
  BUILD_ENV="prod";
else
  BUILD_COMMIT=$(git rev-list HEAD --max-count=1 --skip=1)
  echo "::Using commit ${BUILD_COMMIT}"
  BUILD_ENV="";
fi

bash ${PROJECT_ROOT}/scripts/build.sh $PROFILE $BUILD_ENV $BUILD_COMMIT

# Copy local settings file for Travis env to the test folder.
cp scripts/travis/assets/settings.local.php docroot/sites/default/settings.local.php

echo  "::Importing development database"
cd ${PROJECT_ROOT}/docroot
drush core-status

# Install profile to dev DB.
echo  "::Install profile ${PROFILE}"
drush --debug si $PROFILE -y

echo  "::Updating DB"
drush -y updatedb

echo  "::Import configs if they exist"
export DIR=../config/sync
if [[ ls ${DIR}/*.yml &>/dev/null ]]; then
  drush -y config-import
else
    echo "Config sync directory is empty."
fi
drush cache-rebuild
