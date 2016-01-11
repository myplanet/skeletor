#!/usr/bin/env bash

set -e

# If this is pull request, exit.
if [[ ! $TRAVIS_PULL_REQUEST == 'false' ]];
then
  echo "::Testing pull request complete."
  exit;
fi

echo "::Deploying"

# Note that you should have exported the Travis Repo SSH pub key, and
# added it into the deploy server keys list.

# Git config user/email
git config --global user.email "travis@myplanet.com"
git config --global user.name  "Travis CI - $PROJECT"

# Checkout existing deployment repo.
cd $HOME
git clone $DEPLOY_REPO $DEPLOY_DEST

# Deploy to deployment environment.
cd $DEPLOY_DEST
git checkout $DEPLOY_BRANCH
git rm -rf docroot -q
rm -rf docroot
mkdir docroot
cd $BUILD_DEPLOY
cp -a * $DEPLOY_DEST/docroot
cd $DEPLOY_DEST


# If tmp/hooks exists, then copy all files to a folder outside docroot.
if [ -d $INSTALL_PROFILE/tmp/hooks ]; then
  echo "::Adding Acquia Cloud hooks."
  cp -a $INSTALL_PROFILE/tmp/hooks $DEPLOY_DEST
fi

echo "::Adding new files."
git add .

# Copy our pull request over.
cd $INSTALL_PROFILE
PULL_REQUEST_MESSAGE=$(git log -n 1 --pretty=format:%s $TRAVIS_COMMIT)
cd $DEPLOY_DEST
git commit -m "$PULL_REQUEST_MESSAGE"
git push origin $DEPLOY_BRANCH

# Pause so that the build process can run.
sleep 10

# Exporting project custom configurations run updb etc.
echo "::Installing the site"
drush @${PROJECT}.dev si $PROJECT -y
drush @${PROJECT}.dev user-password admin --password=$ADMIN_PASS -y
drush @${PROJECT}.dev cim sync --partial -y
drush @${PROJECT}.dev updb -y
