#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
cp /scripts/wp-config.php /var/www/html/wp-config.php

sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASS/g" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_NAME/g" /var/www/html/wp-config.php

chown -R wp_user:wp_group /var/www/html && chmod -R 775 /var/www/html
php-fpm7.4 -y /etc/php/7.4/fpm/php-fpm.conf -F

cat /scripts/title.txt
