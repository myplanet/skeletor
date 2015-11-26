// Drupal 8 required trusted hosts settings.
// See: https://www.drupal.org/node/2410395
if (isset($_ENV['AH_SITE_ENVIRONMENT'])) {
  $trusted_hosts = array();
  switch ($_ENV['AH_SITE_ENVIRONMENT']) {
    case 'dev':
      array_push($trusted_hosts, '^skeletor\.devcloud\.acquia-sites\.com$');
      break;

    case 'test':
      array_push($trusted_hosts, '^skeletor\.testcloud\.acquia-sites\.com$');
      break;

    case 'prod':
      array_push($trusted_hosts, '^skeletor\.prodcloud\.acquia-sites\.com$');
      break;
  }

  $settings['trusted_host_patterns'] = $trusted_hosts;
}
