#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
wp core download --allow-root --path=/var/www/html
cp /scripts/wp-config.php /var/www/html/wp-config.php

sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASS/g" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_NAME/g" /var/www/html/wp-config.php
wp core install --allow-root --path=/var/www/html \
	--url=$DOMAIN_NAME --title=inception \
	--admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS \
	--admin_email=$WP_ADMIN_MAIL
wp user create $DB_USER $WP_USER_MAIL --user_pass=$DB_PASS --allow-root --role=author --path=/var/www/html

fi

chown -R wp_user:wp_group /var/www/html && chmod -R 775 /var/www/html
php-fpm7.4 -y /etc/php/7.4/fpm/php-fpm.conf -F