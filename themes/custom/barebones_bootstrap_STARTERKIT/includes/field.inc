<?php

/**
 * @file
 * Preprocess fields functions.
 */

use \Drupal\Component\Utility\Html;

function barebones_bootstrap_STARTERKIT_preprocess_field(array &$variables) {
  $field_name = $variables['element']['#field_name'];

  if ($field_name == 'field_accordion_items') {
    $variables['accordion_id'] = Html::getUniqueID('accordion');
  }
}
