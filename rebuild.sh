#!/bin/sh
# This is a quick rebuild script that doesn't do all the things that
# the full build script does.
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

DIRS="modules/contrib themes/contrib libraries/contrib"
for d in $DIRS; do
  rm -Rf "$d.bak.tar.gz"
  mv $d "$d.bak"
  tar cvzf "$d.bak.tar.gz" "$d.bak"
  rm -Rf "$d.bak"
done
drush make --yes --working-copy --no-core --contrib-destination=. drupal-org.make

# TODO: Copy default.settings.php and append snippets again.
