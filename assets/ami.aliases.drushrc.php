<?php

if (!isset($drush_major_version)) {
  $drush_version_components = explode('.', DRUSH_VERSION);
  $drush_major_version = $drush_version_components[0];
}

// Site ami, environment dev
$aliases['dev'] = array(
  'root' => '/var/www/html/ami1.dev/docroot',
  'ac-site' => 'ami1',
  'ac-env' => 'dev',
  'ac-realm' => 'devcloud',
  'uri' => 'dev.ami.ca',
  'remote-host' => 'srv-4939.devcloud.hosting.acquia.com',
  'remote-user' => 'ami1.dev',
  'path-aliases' => array(
    '%drush-script' => 'drush' . $drush_major_version,
  )
);

$aliases['test'] = array(
  'root' => '/var/www/html/ami1.test/docroot',
  'ac-site' => 'ami1',
  'ac-env' => 'test',
  'ac-realm' => 'devcloud',
  'uri' => 'stage.ami.ca',
  'remote-host' => 'srv-4939.devcloud.hosting.acquia.com',
  'remote-user' => 'ami1.test',
  'path-aliases' => array(
    '%drush-script' => 'drush' . $drush_major_version,
  )
);
