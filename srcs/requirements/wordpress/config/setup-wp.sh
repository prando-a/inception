#!/bin/bash

# Espera a que MariaDB esté listo

# Crea el archivo wp-config.php si no existe
echo "Creando wp-config.php..."
wp config create --path=/var/www/html --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=${DB_NAME} --allow-root


# Inicia PHP-FPM
echo "Iniciando PHP-FPM..."
php-fpm7.4 -F

