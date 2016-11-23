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

# If this isn't a pull request, pass the production flag.
if [[ $TRAVIS_PULL_REQUEST == 'false' ]]; then
  echo "::Using production settings."
  BUILD_ENV="prod";
fi

bash ${PROJECT_ROOT}/scripts/build.sh $PROFILE $BUILD_ENV

# Copy local settings file for Travis env to the site folder.
echo  "::Copying local settings file to the site folder"
cp ${PROJECT_ROOT}/scripts/travis/assets/settings.local.php ${PROJECT_ROOT}/docroot/sites/default/settings.local.php

cd ${PROJECT_ROOT}/docroot

# Install profile to dev DB.
echo  "::Installing profile ${PROFILE}"
drush --debug si $PROFILE -y

export DIR=../config/sync
if [[ -e ${DIR}/*.yml ]]; then
  echo  "::Importing configuration"
  drush -y config-import
fi
drush cache-rebuild
