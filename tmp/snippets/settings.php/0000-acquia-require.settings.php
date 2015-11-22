/**
 * If on Acquia environment, include file with DB credentials.
 */

$subscription = 'skeletor';

if (file_exists('/var/www/site-php')) {
  require("/var/www/site-php/${subscription}/${subscription}-settings.inc");
}
