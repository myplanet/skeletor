<?php

$site = 'skeletor';
$host_prefix = 'skel-123';

$environments = array(
  'dev',
  'test',
  'prod',
);

foreach ($environments as $env) {
  $aliases[$env] = array(
    'parent' => '@parent',
    'site' => $site,
    'env' => $env,
    'root' => "/var/www/html/${site}.${env}/docroot",
    'remote-host' => "$host_prefix.devcloud.hosting.acquia.com",
    'remote-user' => $site,
  );
}
