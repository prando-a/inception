#!/bin/bash

# Espera a que MariaDB esté listo
until mysql -h"${DB_NAME}" -u"${DB_USER}" -p"${DB_PASS}" -e 'show databases;' > /dev/null 2>&1; do
    echo "Esperando a que MariaDB esté listo..."
    sleep 5
done

# Crea el archivo wp-config.php si no existe
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creando wp-config.php..."
    wp config create --path=/var/www/html --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=${DB_NAME} --allow-root
fi

# Inicia PHP-FPM
echo "Iniciando PHP-FPM..."
php-fpm7.4 -F

