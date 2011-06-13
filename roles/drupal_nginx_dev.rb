name "drupal_nginx_dev"
description "Nginx + PHP-FPM + Memcached stack for Drupal."
run_list(
  "role[memcached]",
  "recipe[drupal::minimal]",
  "recipe[drupal::nginx]",
  "role[drupal_dev]"
)
# TODO Add recipe to create dev sites via Drush make.
