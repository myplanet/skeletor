<?php

if (!isset($drush_major_version)) {
  $drush_version_components = explode('.', DRUSH_VERSION);
  $drush_major_version = $drush_version_components[0];
}

// Site Drupal-skeletor, environment dev
$aliases['dev'] = array(
  'root' => '/var/www/html/skeletor.dev/docroot',
  'ac-site' => 'skeletor',
  'ac-env' => 'dev',
  'ac-realm' => 'devcloud',
  'uri' => 'dev.skeletor.ca',
  'remote-host' => 'srv-4939.devcloud.hosting.acquia.com',
  'remote-user' => 'skeletor.dev',
  'path-aliases' => array(
    '%drush-script' => 'drush' . $drush_major_version,
  )
);

$aliases['test'] = array(
  'root' => '/var/www/html/skeletor.test/docroot',
  'ac-site' => 'skeletor',
  'ac-env' => 'test',
  'ac-realm' => 'devcloud',
  'uri' => 'stage.skeletor.ca',
  'remote-host' => 'srv-4939.devcloud.hosting.acquia.com',
  'remote-user' => 'skeletor.test',
  'path-aliases' => array(
    '%drush-script' => 'drush' . $drush_major_version,
  )
);
