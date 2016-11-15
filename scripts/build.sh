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
PRODUCTION="$2"
MAKE_OPTS=""

# Configure options for production or development build.
if [[ -n "$PRODUCTION" ]]; then
  echo "::Building production environment"
  MAKE_OPTS=" --prefer-dist ${MAKE_OPTS}"
fi

# Drush make the site structure
echo "::Running composer install"
composer install $MAKE_OPTS
composer drupal-scaffold

if [[ -n "$PRODUCTION" ]]; then
  # Overwrite the dev .gitignore with our acquia specific one.
  echo "::Placing prod gitignore"
  mv $PROJECT_ROOT/scripts/travis/assets/prod.gitignore .gitignore

  # Remove any git repos contained in contrib folders
  rm -rf docroot/modules/contrib/*/.git
  rm -rf docroot/themes/contrib/*/.git
  rm -rf docroot/profiles/contrib/*/.git
  rm -rf docroot/profiles/${PROJECT}/modules/contrib/*/.git
  rm -rf docroot/profiles/${PROJECT}/libraries/contrib/*/.git
fi

# Compile CSS
echo "::Finding custom themes"
for THEME in docroot/profiles/${PROJECT}/themes/custom/*/;
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
