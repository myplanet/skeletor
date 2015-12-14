<?php

if (!isset($drush_major_version)) {
  $drush_version_components = explode('.', DRUSH_VERSION);
  $drush_major_version = $drush_version_components[0];
}

// Site ami, environment dev
// Site amitemp, environment dev
$aliases['dev'] = array(
  'root' => '/var/www/html/amitemp.dev/docroot',
  'ac-site' => 'amitemp',
  'ac-env' => 'dev',
  'ac-realm' => 'devcloud',
  'uri' => 'amitempca3yhd6i88.devcloud.acquia-sites.com',
  'remote-host' => 'free-4583.devcloud.hosting.acquia.com',
  'remote-user' => 'amitemp.dev',
  'path-aliases' => array(
    '%drush-script' => 'drush' . $drush_major_version,
  )
);
