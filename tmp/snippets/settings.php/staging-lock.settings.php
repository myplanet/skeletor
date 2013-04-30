/**
 * Allows authorization to take place in settings.php with logic to specify environment
 * Ref: https://library.acquia.com/articles/password-protect-your-non-production-environments-acquia-hosting
 */

// Make sure drush keeps working. 
// Modified from function drush_verify_cli()

$cli = (php_sapi_name() == 'cli');

// PASSWORD PROTECT NON-PRODUCTION SITES (i.e. staging/dev)

if (!$cli && isset($_ENV['AH_NON_PRODUCTION'])) {
  $username = 'admin';
  $password = 'sekret';

  // PHP-cgi fix
  $a = base64_decode( substr($_SERVER["REMOTE_USER"],6)) ;
  if ( (strlen($a) == 0) || ( strcasecmp($a, ":" ) == 0 )) {
    header( 'WWW-Authenticate: Basic realm="Private"' );
    header( 'HTTP/1.0 401 Unauthorized' );
  } else {
    list($name, $pass) = explode(':', $a);
    $_SERVER['PHP_AUTH_USER'] = $name;
    $_SERVER['PHP_AUTH_PW'] = $pass;
  }
  if (!(isset($_SERVER['PHP_AUTH_USER']) && ($_SERVER['PHP_AUTH_USER']==$username && $_SERVER['PHP_AUTH_PW']==$password))) {
    header('WWW-Authenticate: Basic realm="This site is protected"');
    header('HTTP/1.0 401 Unauthorized');
    // Fallback message when the user presses cancel / escape
    echo 'Access denied';
    exit;
  }
}
