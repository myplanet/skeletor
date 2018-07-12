<?php

/**
 * @file
 * Preprocess page functions.
 */

 /**
  * Implements hook_theme_suggestions_HOOK_alter().
  */
 function barebones_theme_suggestions_page_alter(&$suggestions, $variables, $hook) {
   /**
    * Create template suggestions 404 & 403 pages. 
    */
   if (!is_null(Drupal::requestStack()->getCurrentRequest()->attributes->get('exception'))) {
     $status_code = Drupal::requestStack()->getCurrentRequest()->attributes->get('exception')->getStatusCode();
     switch ($status_code) {
       case 404: {
         $suggestions[] = 'page__' . (string) $status_code;
         break;
       }
       case 403: {
         $suggestions[] = 'page__' . (string) $status_code;
         break;
       }
       default:
         break;
     }
   }
 }
