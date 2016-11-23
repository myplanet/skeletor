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

drush_alias=$site'.'$target_env

drush @$drush_alias -y updatedb
#drush @$drush_alias -y entity-updates
drush @$drush_alias -y config-import sync
#drush @$drush_alias twig-compile
