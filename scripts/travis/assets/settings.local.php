<?php
/**
  * Local settings configuration.
  */
$settings['hash_salt'] = 'put-here-skeletor-hash-salt';
$databases['default']['default'] = array (
  'database' => 'skeletor-db',
  'username' => 'root',
  'password' => '',
  'prefix' => '',
  'host' => '127.0.0.1',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);
