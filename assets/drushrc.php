<?php

$command_specific['dl'] = [
  'cache' => TRUE,
];

$command_specific['rsync'] = [
  'exclude-paths' => implode(
      PATH_SEPARATOR,
      [
        'styles',
      ]
  ),
];

$command_specific['sql-sync'] = [
  // Only transfer structure of these tables.
  'structure-tables-list' => implode(',', [
    'cache_bootstrap',
    'cache_config',
    'cache_container',
    'cache_data',
    'cache_default',
    'cache_discovery',
    'cache_entity',
    'cache_menu',
    'cache_render',
    'cache_toolbar',
    'cache_tvmproxy',
    'sessions',
    'watchdog',
  ]),
];
