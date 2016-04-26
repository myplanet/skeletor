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

bash tmp/scripts/build.sh $PROFILE $BUILD_TEST $BUILD_COMMIT

# Install Drush integration
echo "::Installing Drush integration"
cp $INSTALL_PROFILE/tmp/travis_scripts/assets/${ACQUIA_PROJECT}.aliases.drushrc.php $HOME/.drush/${ACQUIA_PROJECT}.aliases.drushrc.php
cp $INSTALL_PROFILE/tmp/travis_scripts/assets/drushrc.php $HOME/.drush/drushrc.php

# Copy the built site over to the deploy folder.
cp -R $BUILD_TEST $BUILD_DEPLOY

# Copy local settings file for Travis env to the test folder.
cp $INSTALL_PROFILE/tmp/travis_scripts/assets/settings.local.php $BUILD_TEST/sites/default/settings.local.php

cd $BUILD_TEST
# Sync or install the database depending on your needs.
echo  "::Installing development database"
drush si skeletor -y

#echo  "::Importing development database"
#drush sql-sync @${ACQUIA_PROJECT}.dev default -y
#drush -y updatedb
#drush -y config-import
#drush cache-rebuild
