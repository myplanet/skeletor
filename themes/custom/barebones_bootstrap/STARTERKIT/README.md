# Skeletor Bootstrap Starterkit

<small>Skull icon in Drupal Screenshot by [Chanut is Industries](https://www.iconfinder.com/Chanut-is)</small>

## Instructions for creating a new theme
1. Copy entire STARTERKIT directory somewhere in your Drupal installation. For the purposes of this documentation, let's call our new theme "example".
2. Rename the theme directory to "example".
3. In all the theme's files with "STARTERKIT" in the name, replace it with "example".
4. Do a search and replace in all the theme's files and replace the word "STARTERKIT" with "example".
5. In the `webpack.config.js` (in the theme's root folder)
  - Change the path to your `dist` in the `setPublicPath()` function (approx. line 15).
  - Change the relative path to the Barebones Bootstrap theme in the `addAliases()` function (approx. line 57).
6. In the theme's `info.yml` file:
  - Remove the `hidden: true` parameter
  - Change the name parameter
  - Change the description parameter
7. In the terminal, at the root of your theme, run `yarn install`
8. To compile the JS/CSS, run `yarn build`, or to watch the folder for any changes in your JS/CSS, run `yarn dev --watch`
9. Enable the theme.

## Development suggestions
- Add add a `settings.local.yml` file in your `sites/default` directory with the following code:
```yaml
parameters:
  http.response.debug_cacheability_headers: true
  twig.config:
    debug: true
    auto_reload: true
    cache: false
services:
  cache.backend.null:
    class: Drupal\Core\Cache\NullBackendFactory
```
- Add the following code in your settings.local.php
```php
$settings['container_yamls'][] = DRUPAL_ROOT . '/sites/default/services.local.yml';
$config['system.performance']['css']['preprocess'] = FALSE;
$config['system.performance']['js']['preprocess'] = FALSE;
$settings['cache']['bins']['render'] = 'cache.backend.null';
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';
$settings['cache']['bins']['page'] = 'cache.backend.null';
$GLOBALS['_kint_settings']['maxLevels'] = 3;
```
