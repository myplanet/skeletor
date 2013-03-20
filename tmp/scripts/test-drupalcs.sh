#!/bin/bash

# Runs PHP_CodeSniffer on install profile.

phpcs -p \
  --ignore=tmp \
  --standard=Drupal \
  --report-checkstyle=checkstyle.xml \
  --extensions=php,module,inc,install,test,profile,theme \
  . && true
