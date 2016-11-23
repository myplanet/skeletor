#!/bin/bash

# USAGE
# Run this script as given from the root of your project
# To build a production environment set the TRUE flag for production.
#
# $ bash build.sh [ project ] [ production ]

# Bail if non-zero exit code
set -e

# Set from args
PROJECT="$1"
ENVIRONMENT="$2"
MAKE_OPTS=""

# Configure options for production or development build.
if [[ -n "$ENVIRONMENT" ]]; then
  echo "::Building environment: ${ENVIRONMENT}"
  MAKE_OPTS=" --prefer-dist --no-dev ${MAKE_OPTS}"
fi

# Drush make the site structure
echo "::Running composer install"
composer install $MAKE_OPTS
composer drupal-scaffold

if [[ -n "$ENVIRONMENT" ]]; then
  # Overwrite the dev .gitignore with our acquia specific one.
  echo "::Placing prod gitignore"
  mv ${PROJECT_ROOT}/scripts/travis/assets/prod.gitignore .gitignore

  # Remove any git repos contained in contrib folders
  rm -rf ${PROJECT_ROOT}/docroot/modules/contrib/*/.git
  rm -rf ${PROJECT_ROOT}/docroot/themes/contrib/*/.git
  rm -rf ${PROJECT_ROOT}/docroot/profiles/contrib/*/.git
  rm -rf ${PROJECT_ROOT}/docroot/profiles/${PROJECT}/modules/contrib/*/.git
  rm -rf ${PROJECT_ROOT}/docroot/profiles/${PROJECT}/libraries/contrib/*/.git
fi

# Compile CSS
echo "::Finding custom themes"
for THEME in ${PROJECT_ROOT}/docroot/profiles/${PROJECT}/themes/custom/*/;
do
  if [ -d "$THEME" ]; then
    cd $THEME
    if [ -f config.rb ]; then
      DIR_NAME=${PWD##*/}
      echo "::Compiling stylesheets for '$DIR_NAME' theme"
      compass compile
    fi
  fi
done
