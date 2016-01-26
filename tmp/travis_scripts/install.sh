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
else
  BUILD_COMMIT=$(git rev-list HEAD --max-count=1 --skip=1)
  echo "::Using commit ${BUILD_COMMIT}"
fi

bash tmp/scripts/build.sh $PROJECT $BUILD_TEST $BUILD_COMMIT

# Install Drush integration
echo "::Installing Drush integration"
cp $INSTALL_PROFILE/tmp/travis_scripts/$PROJECT.aliases.drushrc.php $HOME/.drush/$PROJECT.aliases.drushrc.php

# Copy the built site over to the deploy folder.
cp -R $BUILD_TEST $BUILD_DEPLOY

# Copy local settings file for Travis env to the test folder.
cp $INSTALL_PROFILE/tmp/travis_scripts/settings.local.php $BUILD_TEST/sites/default/settings.local.php

echo  "::Installing $PROJECT"
cd $BUILD_TEST
drush si $PROJECT --db-url=mysql://root:@localhost:3306/${PROJECT} --site-name="$PROJECT" --account-pass="admin" -y
drush config-import sync --partial -y
