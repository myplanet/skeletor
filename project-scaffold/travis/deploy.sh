#!/usr/bin/env bash

set -e

# If this is pull request, exit.
if [[ ! $TRAVIS_PULL_REQUEST == 'false' ]]; then
  echo "::Testing pull request complete."
  exit;
fi

echo "::Deploying"

# Note that you should have exported the Travis Repo SSH pub key, and
# added it into the deploy server keys list.

# Git config user/email
git config --global user.email "travis@myplanet.com"
git config --global user.name  "Travis CI - $ACQUIA_PROJECT"

echo "::Creating dir ${DEPLOY_DEST}"
mkdir $DEPLOY_DEST
echo "::Cloning out ${DEPLOY_REPO} into ${DEPLOY_DEST}"
git clone $DEPLOY_REPO $DEPLOY_DEST
cd $DEPLOY_DEST
git checkout build-${TRAVIS_BRANCH}

# Create a travis-build branch off of our test commit since we're in a detached state.
cd $PROJECT_ROOT
PULL_REQUEST_MESSAGE=$(git log -n 1 --pretty=format:%s $TRAVIS_COMMIT)
echo "::Latest message ${PULL_REQUEST_MESSAGE}"
rsync -a $PROJECT_ROOT/ $DEPLOY_DEST --exclude .git --delete

cd $DEPLOY_DEST

# Change webroot from web/ to docroot/ for Acquia if necessary.
if [[ -d "web" && ! -L "web" ]]; then
  mv ${DEPLOY_DEST}/web/ ${DEPLOY_DEST}/docroot/
  # Composer autoloader files still reference web/, so use symlink to avoid
  # needing to change composer.json and rebuilding.
  ln -s docroot web
fi

echo "::Adding new files."
git config --global core.safecrlf false # Suppress warning for differing line endings.
git add --all .

git commit -m "${PULL_REQUEST_MESSAGE}

Commit ${TRAVIS_COMMIT}"
git push origin build-${TRAVIS_BRANCH}
