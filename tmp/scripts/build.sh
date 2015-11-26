#!/bin/bash

# USAGE
# Run this script as given.
#
# $ bash build.sh [ project ] [ /fullpath/to/project.make.yml ] [ /fullpath/to/build/project ] [ build_dev ]

# Bail if non-zero exit code
set -e

# Set from args
PROJECT="$1"
BUILD_FILE="$2"
BUILD_DEST="$3"
BUILD_DEV="$4"
MAKE_OPTS="--contrib-destination=profiles/${PROJECT} --prepare-install --yes --no-gitinfofile"

# Prepending option for development building
if [ -n "${BUILD_DEV}" ]; then
  MAKE_OPTS="--working-copy ${MAKE_OPTS}"
fi

# Drush make the site structure
echo "::Running drush make"
drush make --force-complete ${BUILD_FILE} ${BUILD_DEST} ${MAKE_OPTS}

# Copy the settings.yml.
cp ${BUILD_DEST}/sites/default/default.services.yml ${BUILD_DEST}/sites/default/services.yml

chmod 777 ${BUILD_DEST}/sites/default/settings.php
chmod 777 ${BUILD_DEST}/sites/default/services.yml

echo "::Appending settings.php snippets"
for f in ${BUILD_DEST}/profiles/${PROJECT}/tmp/snippets/*.settings.php
do
  # Concatenate newline and snippet, then append to settings.php
  echo "" | cat - $f | tee -a ${BUILD_DEST}/sites/default/settings.php > /dev/null
done


echo "Prepending .htaccess snippets at the start of file."
for f in tmp/snippets/htaccess/*.before.htaccess
do
  # Prepend a snippet and a new line to the existing .htaccess file
  echo "" | cat $f - | cat - ${BUILD_DEST}/.htaccess > htaccess.tmp
  mv htaccess.tmp ${BUILD_DEST}/.htaccess
done

echo "Appending .htaccess snippets at the end of file..."
for f in tmp/snippets/htaccess/*.after.htaccess
do
  # Concatenate newline and snippet, then append to the existing .htaccess file
  echo "" | cat - $f | tee -a ${BUILD_DEST}/.htaccess > /dev/null
done

echo "Appending robots.txt snippets at the end of file..."
for f in tmp/snippets/robots.txt/*.robots.txt
do
  # Concatenate newline and snippet, then append to the existing .htaccess file
  echo "" | cat - $f | tee -a ${BUILD_DEST}/robots.txt > /dev/null
done

echo "Copy files into docroot..."
if [ -d tmp/copy_to_docroot ]; then
  # Copy files into docroot
  cp -r tmp/copy_to_docroot/. ${BUILD_DEST}/
fi

echo "Copy files into sites/default..."
if [ -d tmp/copy_to_sites_default ]; then
  # Copy files into sites/default
  cp -r tmp/copy_to_sites_default/. ${BUILD_DEST}/sites/default/
fi

# Compile CSS
echo "::Compiling stylesheets"
for THEME in ${BUILD_DEST}/profiles/${PROJECT}/themes/*; do
  cd $THEME
  if [ -a config.rb ]; then
    compass compile
  fi
done