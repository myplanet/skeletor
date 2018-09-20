<?php

/**
 * @file
 * Preprocess fields functions.
 */

use \Drupal\Component\Utility\Html;

function barebones_bootstrap_preprocess_field(array &$variables) {
  $field_name = $variables['element']['#field_name'];

  // Add unique ID in case a page has multiple accordion components.
  if ($field_name == 'field_component_slideshow_slides') {
    $variables['slideshow_id'] = Html::getUniqueID('slideshow');
  }

  // Add unique ID in case a page has multiple accordion components.
  if ($field_name == 'field_accordion_items') {
    $variables['accordion_id'] = Html::getUniqueID('accordion');
  }

  // Add unique ID in case a page has multiple tab components..
  if ($field_name == 'field_component_tab') {
    $variables['tab_id'] = Html::getUniqueID('tab-accordion');

    // Use different mode for the tab/accordion title.
    foreach ($variables['items'] as &$item) {
      $item['tab_nav_link'] = $item['content'];
      $item['tab_nav_link']['#view_mode'] = 'tab_nav_link';
    }
  }
}
