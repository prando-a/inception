#!/bin/sh

mkdir -p /run/php

chown -R www-data.www-data /var/www/html

chmod -R 755 /var/www/html/wordpress

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

if [ ! -f /var/www/html/wp-load.php ]; then
    wp core download --allow-root --path=/var/www/html
fi

mv ./wp-config.php /var/www/html/wp-config.php

echo "$DB_NAME\t$DB_USER\t$DB_PASS\t$WP_ADMIN_MAIL FINISH"

sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASS/" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_NAME/" /var/www/html/wp-config.php

wp core install --allow-root --url=$DOMAIN_NAME --title=inception --admin_user=$DB_USER --admin_password=$DB_ROOT_PASS --admin_email=$WP_ADMIN_MAIL --path=/var/www/html

chown -R prando-a:wp_group /var/www/html && chmod -R 775 /var/www/html

php-fpm7.4 -y /etc/php/7.4/fpm/php-fpm.conf -F