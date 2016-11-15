#!/bin/sh

# USAGE
# This is a quick rebuild script that doesn't do all the things that
# the full build script does.
#
# $ bash tmp/scripts/rebuild.sh
#
# ## README ##
#
# This file is only meant to be used after switching branches.
#
# It backs up all the projects that were previously downloaded from the make
# file and then downloads again, in case something is new, removed or updated.
#
# The purpose of the backup is to make sure that we don't kill the user's dev
# environment in cases of a failed drush_make build or accidental running
# of the script.

PROFILE_DIR="$(echo "$PWD/$0" | sed -e "s#tmp/scripts/rebuild.sh# #")"

echo "::Go to the profile directory: $PROFILE_DIR"
cd $PROFILE_DIR

DIRS="modules/contrib themes/contrib libraries/contrib"
for d in $DIRS; do
  if [ -e "$d.bak.tar.gz" ]
  then
    rm -f "$d.bak.tar.gz"
    echo "Old $d.bak.tar.gz deleted"
  fi
  if [ -e "$d" ]
  then
    mv "$d" "$d.bak"
    tar czf "$d.bak.tar.gz" "$d.bak"
    rm -Rf "$d.bak"
    echo "Archived $d to $d.bak.tar.gz"
  fi
done

PROJECT="${PWD##*/}"
drush make ${PROJECT}.make.yml --yes --working-copy --force-complete --no-core --contrib-destination=. -y

# Copy default.settings.php and append snippets again.
chmod u+w ../../sites/default
rm -f ../../sites/default/settings.bak.php
mv ../../sites/default/settings.php ../../sites/default/settings.bak.php
cp ../../sites/default/default.settings.php ../../sites/default/settings.php
chmod 666 ../../sites/default/settings.php

echo "::Appending settings.php snippets..."
for f in tmp/snippets/settings.php/*.settings.php
do
  # Concatenate newline and snippet, then append to settings.php
  echo "" | cat - $f | tee -a ../../sites/default/settings.php > /dev/null
done
# Seal settings.php
chmod 444 ../../sites/default/settings.php

echo "::Prepending .htaccess snippets at the start of file."
for f in tmp/snippets/htaccess/*.before.htaccess
do
  # Prepend a snippet and a new line to the existing .htaccess file
  echo "" | cat $f - | cat - ../../.htaccess > htaccess.tmp
  mv htaccess.tmp ../../.htaccess
done

echo "::Appending .htaccess snippets at the end of file..."
for f in tmp/snippets/htaccess/*.after.htaccess
do
  # Concatenate newline and snippet, then append to the existing .htaccess file
  echo "" | cat - $f | tee -a ../../.htaccess > /dev/null
done

echo "::Appending robots.txt snippets at the end of file..."
for f in tmp/snippets/robots.txt/*.robots.txt
do
  # Concatenate newline and snippet, then append to the existing .htaccess file
  echo "" | cat - $f | tee -a ../../robots.txt > /dev/null
done

echo "::Copying files into docroot..."
if [ -d tmp/copy_to_docroot ]; then
  # Copy files into docroot
  cp -r tmp/copy_to_docroot/. ../../
fi

echo "::Copying files into sites/default..."
if [ -d tmp/copy_to_sites_default ]; then
  # Copy files into sites/default
  cp -r tmp/copy_to_sites_default/. ../../sites/default/
fi

# Compile CSS
echo "::Finding custom themes"
for THEME in themes/custom/*/;
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

# Finish by flushing caches.
drush cache-rebuild
