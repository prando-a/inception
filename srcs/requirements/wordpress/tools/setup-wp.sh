#!/bin/sh

mkdir -p /run/php

chown -R www-data.www-data /var/www/html/wordpress

chmod -R 755 /var/www/html/wordpress

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

if [ ! -f /var/www/html/wordpress/wp-load.php ]; then
    wp core download --allow-root --path=/var/www/html/wordpress
fi

mv ./wp-config.php /var/www/html/wordpress/wp-config.php

echo "$DB_NAME\t$DB_USER\t$DB_ROOT_PASS\t$WP_ADMIN_MAIL FINISH"

sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/$DB_USER/" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/$DB_ROOT_PASS/" /var/www/html/wordpress/wp-config.php
sed -i "s/put your unique phrase here/trying/" /var/www/html/wordpress/wp-config.php
sed -i "s/localhost/mariadb:3306/" /var/www/html/wordpress/wp-config.php

wp core install --allow-root --url=$DB_NAME --title=inception --admin_user=$DB_USER --admin_password=$DB_ROOT_PASS --admin_email=$WP_ADMIN_MAIL --skip-email --path=/var/www/html/wordpress

php-fpm7.4 -y /etc/php/7.4/fpm/php-fpm.conf -F