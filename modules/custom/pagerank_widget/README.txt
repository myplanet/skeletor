Name: PageRank Widget (pr_widget)
Author: Martin Postma ('lolandese', http://drupal.org/user/210402)
Drupal: 7.x


-- SUMMARY --

A block showing the Google pagerank of the site (e.g. PageRank 3).

It is based on http://www.fusionswift.com/2010/04/google-pagerank-script-in-php/

Two versions are available:
- A visualy appealing widget, by default enabled in the footer.
- A simple text version, by default disabled.


-- INSTALL --

Extract the package in your modules directory, '/sites/all/modules'.

Enable the module at '/admin/modules'.


-- CONFIGURE --
Configuration at 
'/admin/structure/block/manage/pr_widget/pr_widget_widget/configure' 
(widget) or at 
'/admin/structure/block/manage/pr_widget/pr_widget_text/configure' 
(text).

To use only a simple text, disable the 'PageRank Widget' block and enable 
'PageRank text only'.


-- CUSTOMIZE --

To change the content in the widget (e.g. to put the ranking first):
1. Copy the pr_widget.tpl.php file to your theme's template folder.
2. Make your changes.
3. Clear the site cache at '/admin/config/development/performance'.

To change the style of the widget (e.g. colors):
1. Copy & paste the code in the pr_widget.css into your theme's custom CSS file.
2. Make your changes.
3. Clear both your browser and site cache.

To override the string "PageRank" use 
http://drupal.org/project/stringoverrides which provides an easy way to replace 
any text on your site that's wrapped in the t() function.
