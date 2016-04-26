/**
 * Put in action custom config settings only after drupal installation is completed
 */
$install_profile = 'skeletor';
$settings['install_profile'] = $install_profile;

if (drupal_installation_attempted()) {
  // Installer seems to require a writable directory.
  $config_directories[CONFIG_SYNC_DIRECTORY] = 'sites/default/files';
}
elseif (isset($_ENV['AH_SITE_ENVIRONMENT'])) {
  // Acquia config management settings.
  // The config folder is moved by the build script to above the docroot.
  $config_directories[CONFIG_SYNC_DIRECTORY] = './../config/sync';
}
else {
  // Local config management settings.
  $config_directories[CONFIG_SYNC_DIRECTORY] = 'profiles/' . $install_profile . '/tmp/config/sync';
}
