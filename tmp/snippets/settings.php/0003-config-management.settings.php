// Put in action custom config settings only after drupal installation is completed
if (!drupal_installation_attempted()) {
  // Acquia config management settings
  if (isset($_ENV['AH_SITE_ENVIRONMENT'])) {
    $config_directories['skeletor'] = '../library/skeletor/config/custom/sync';
  }
  // Local config management settings
  else {
    $config_directories['skeletor'] = 'profiles/skeletor/config/custom/sync';
  }
}
