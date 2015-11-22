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
git config --global user.email "travis-skeletor@myplanet.com"
git config --global user.name  "Travis CI - skeletor"

# Checkout existing Acquia repo.
cd $HOME
git clone $DEPLOY_REPO $DEPLOY_DEST

## Deployin to Acquia.
cd $DEPLOY_DEST
git checkout develop
git rm -rf docroot -q
rm -rf docroot
mkdir docroot
cd $BUILD_DEPLOY
shopt -s dotglob
mv * $DEPLOY_DEST/docroot
cd $DEPLOY_DEST

# If tmp/hooks exists, then copy all files to a folder outside docroot.
if [ -d $INSTALL_PROFILE/tmp/hooks ]; then
    echo "::Add Acquia Cloud hooks."
    cp -ar $INSTALL_PROFILE/tmp/hooks $DEPLOY_DEST
fi

git add .

# Copy our pull request over.
cd $INSTALL_PROFILE
PULL_REQUEST_MESSAGE=$(git log -n 1 --pretty=format:%s $TRAVIS_COMMIT)
cd $DEPLOY_DEST
git commit -m "$PULL_REQUEST_MESSAGE"
git push origin develop

# Pause so that the build process can run.
sleep 10

# Exporting project custom configurations run updb etc.
echo "::Exporting config"
drush @${PROJECT}.dev cim $PROJECT -y
drush @${PROJECT}.dev updb -y
