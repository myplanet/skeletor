/**
 * Set translation files directory.
 */

if (isset($_ENV['AH_SITE_ENVIRONMENT'])) {
  // Acquia config management settings.
  // The config folder is moved by the build script to above the docroot.
  $config['locale.settings']['translation']['path'] = './../config/translations';
}
else {
  // Local config management settings.
  $config['locale.settings']['translation']['path'] = 'profiles/' . $settings['install_profile'] . '/tmp/config/translations';
}
