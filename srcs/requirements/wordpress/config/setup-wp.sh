#!/bin/bash


export $(grep -v '^#' /root/.env | xargs)



wp core config --dbname=$WORDPRESS_DB_HOST --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --allow-root

wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

echo "WordPress installation and configuration complete!"

