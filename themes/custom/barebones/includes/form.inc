<?php

/**
 * @file
 * Preprocess form functions.
 */

use Drupal\Core\Form\FormStateInterface;

/**
 * Implements hook_form_FORM_ID_alter().
 */
function barebones_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  barebones_twig_recursive_suggestion_walk($form, $form['#id']);
}

/**
 * Walk through a form adding #data-twig-suggestion to all elements with #type.
 *
 * @param array $form
 *   The Drupal form to walk through.
 * @param string $suggestion
 *   The suggestion being added to valid elements.
 */
function barebones_twig_recursive_suggestion_walk(&$form, $suggestion) {
  $suggestion = barebones_suggestion_safe($suggestion);

  foreach ($form as &$value) {
    if (is_array($value) && isset($value['#type'])) {

      // If #data-twig-suggestion' is present for some reason it's been
      // processed so exit the loop.
      if (isset($value['#data-twig-suggestion'])) {
        break;
      }

      $value['#data-twig-suggestion'] = $suggestion;

      // Recursively walk through embedded form elements.
      if ($value['#type'] === 'actions') {
        barebones_twig_recursive_suggestion_walk($value, $suggestion);
      }
    }
  }
}

/**
 * Implements hook_theme_suggestions_HOOK_alter() for form templates.
 */
function barebones_theme_suggestions_form_alter(array &$suggestions, array $variables) {
  $element = $variables['element'];

  // Add per form theme hook suggestion.
  $suggestions[] = 'form__' . $element['#form_id'];
  $suggestions[] = 'form__' . barebones_suggestion_safe($element['#id']);
}

/**
 * Implements hook_theme_suggestions_HOOK_alter() for container templates.
 */
function barebones_theme_suggestions_container_alter(array &$suggestions, array $variables) {
  $element = $variables['element'];

  if (isset($element['#type'])) {
    // Add per type theme hook suggestion.
    $suggestions[] = 'container__' . $element['#type'];

    // Add per form theme hook suggestion.
    if (isset($element['#data-twig-suggestion'])) {
      $suggestions[] = 'container__' . $element['#type'] . '__' . $element['#data-twig-suggestion'];
    }
  }
}

/**
 * Implements hook_theme_suggestions_HOOK_alter() for form element templates.
 */
function barebones_theme_suggestions_form_element_alter(array &$suggestions, array $variables) {
  $element = $variables['element'];

  // Add per type theme hook suggestion.
  $suggestions[] = 'form_element__' . $element['#type'];

  if (isset($element['#name'])) {
    $suggestions[] = 'form_element__' . $element['#type'] . '__' . $element['#name'];
  }

  // Add per form theme hook suggestion.
  if (isset($element['#data-twig-suggestion'])) {
    $suggestions[] = 'form_element__' . $element['#type'] . '__' . $element['#data-twig-suggestion'];

    if (isset($element['#name'])) {
      $suggestions[] = 'form_element__' . $element['#type'] . '__' . $element['#name'] . '__' . $element['#data-twig-suggestion'];
    }
  }
}

/**
 * Implements hook_theme_suggestions_HOOK_alter() for form input templates.
 */
function barebones_theme_suggestions_input_alter(array &$suggestions, array $variables) {
  $element = $variables['element'];

  if (isset($element['#name'])) {
    $suggestions[] = 'input__' . $element['#type'] . '__' . $element['#name'];
  }

  // Add per form theme hook suggestion.
  if (isset($element['#data-twig-suggestion'])) {
    $suggestions[] = 'input__' . $element['#type'] . '__' . $element['#data-twig-suggestion'];

    $name = $element['#name'] ?: strtolower($element['#value']);
    if ($name) {
      $suggestions[] = 'input__' . $element['#type'] . '__' . $name . '__' . $element['#data-twig-suggestion'];
    }
  }
}

/**
 * Implements hook_theme_suggestions_HOOK_alter().
 */
function barebones_theme_suggestions_select_alter(array &$suggestions, array $variables) {
  $element = $variables['element'];

  if (isset($element["#name"])) {
    $suggestions[] = $element['#type'] . '__' . $element["#name"];

    if (isset($element["#data-twig-suggestion"])) {
      $suggestions[] = $element['#type'] . '__' . $element["#name"] . '__' . $element['#data-twig-suggestion'];
    }
  }
}
