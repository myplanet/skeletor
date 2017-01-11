#!/usr/bin/env bash

set -e

echo ":: Running code sniffer."
phpcs --config-set installed_paths ${PROJECT_ROOT}/vendor/drupal/coder/coder_sniffer
phpcs -i

phpcs --standard=Drupal \
  --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md \
  --ignore=contrib \
 ${PROJECT_ROOT}/docroot/profiles/${PROFILE}

phpcs --standard=DrupalPractice \
  --extensions=php,module,inc,install,test,profile,theme,css,info,txt,md \
  --ignore=contrib \
 ${PROJECT_ROOT}/docroot/profiles/${PROFILE}

echo ":: Testing cache-rebuild and cron"
cd ${PROJECT_ROOT}/docroot
drush cache-rebuild
drush core-cron

# Exit with true value
true
