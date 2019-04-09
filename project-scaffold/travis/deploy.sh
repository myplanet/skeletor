#!/usr/bin/env bash

set -e

# If this is pull request, exit.
if [[ ! $TRAVIS_PULL_REQUEST == 'false' ]]; then
  echo "::Testing pull request complete."
  exit;
fi

echo "::Deploying"

DEPLOY_DEST=${HOME}/skeletor-build

# Note that you should have exported the Travis Repo SSH pub key, and
# added it into the deploy server keys list.

# Git config user/email
git config --global user.email "travis@myplanet.com"
git config --global user.name  "Travis CI - $ACQUIA_PROJECT"

# Create a travis-build branch off of our test commit since we're in a detached state.
cd ${TRAVIS_BUILD_DIR}
PULL_REQUEST_MESSAGE=$(git log -n 1 --pretty=format:%s $TRAVIS_COMMIT)
echo "::Latest message ${PULL_REQUEST_MESSAGE}"

echo "::Cloning deploy repo ${DEPLOY_REPO}"
git clone ${DEPLOY_REPO} ${DEPLOY_DEST}
cd ${DEPLOY_DEST}
git checkout ${DEPLOY_BRANCH}

rsync -a ${TRAVIS_BUILD_DIR}/ ${DEPLOY_DEST} --exclude .git --delete

echo "::Adding new files."
git add --all .

git commit -m "${PULL_REQUEST_MESSAGE}
Commit ${TRAVIS_COMMIT}"
git push origin $DEPLOY_BRANCH
