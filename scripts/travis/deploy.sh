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

mkdir $DEPLOY_DEST
git clone $DEPLOY_REPO $DEPLOY_DEST
cd $DEPLOY_DEST
git checkout $DEPLOY_BRANCH

# Create a travis-build branch off of our test commit since we're in a detached state.
cd $PROJECT_ROOT
PULL_REQUEST_MESSAGE=$(git log -n 1 --pretty=format:%s $TRAVIS_COMMIT)
rm -rf .git
cp -a $PROJECT_ROOT/. $DEPLOY_DEST

cd $DEPLOY_DEST
echo "::Adding new files."
git add --all .

git commit -m "${PULL_REQUEST_MESSAGE}
Commit ${TRAVIS_COMMIT}"
git push origin $DEPLOY_BRANCH
