#!/bin/sh

mkdir -p /run/php

chown -R www-data.www-data /var/www/html/wordpress

chmod -R 755 /var/www/html/wordpress

sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = wordpress:9000#g' /etc/php/7.4/fpm/pool.d/www.conf

mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

sed -i "s/database_name_here/$MARIA_DATABASE/" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/$MARIA_USER/" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/$MARIA_PASS/" /var/www/html/wordpress/wp-config.php
sed -i "s/put your unique phrase here/$PHRASE/" /var/www/html/wordpress/wp-config.php
sed -i "s/localhost/mariadb:3306/" /var/www/html/wordpress/wp-config.php

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

wp core install --allow-root --url=$DB_NAME --title=NekaWeb --admin_user=$DB_USER --admin_password=$DB_ROOT_PASS --admin_email=$WP_ADMIN_MAIL --skip-email --path=/var/www/html/wordpress

/usr/sbin/php-fpm7.4 -F