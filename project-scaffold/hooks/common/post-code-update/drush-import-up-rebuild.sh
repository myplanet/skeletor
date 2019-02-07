#!/bin/sh
#
# Run drush commands to update site after code deploy.

# Map the script inputs to convenient names.
site=$1
target_env=$2
source_branch=$3
deployed_tag=$4
repo_url=$5
repo_type=$6

drush_alias=${site}'.'${site}'.'${target_env}

# Show commands being executed in the log.
set -x

/var/www/html/${site}.${target_env}/vendor/bin/drush @${drush_alias} updb -y
/var/www/html/${site}.${target_env}/vendor/bin/drush @${drush_alias} cim vcs -y
/var/www/html/${site}.${target_env}/vendor/bin/drush @${drush_alias} cr
