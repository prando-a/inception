#!/bin/bash

# Espera a que MariaDB esté listo
until mysql -h"${WP_DB_HOST}" -u"${WP_DB_USER}" -p"${WP_DB_PASS}" -e 'show databases;' > /dev/null 2>&1; do
    echo "Esperando a que MariaDB esté listo..."
    sleep 5
done

# Crea el archivo wp-config.php si no existe
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creando wp-config.php..."
    wp config create --path=/var/www/html --dbname=${WP_DB_NAME} --dbuser=${WP_DB_USER} --dbpass=${WP_DB_PASS} --dbhost=${WP_DB_HOST} --allow-root
fi

# Inicia PHP-FPM
echo "Iniciando PHP-FPM..."
php-fpm7.4 -F

