#!/bin/bash

# Espera a que MariaDB esté listo

# Crea el archivo wp-config.php si no existe
echo "Creando wp-config.php..."
wp config create --path=/var/www/html --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=${DB_NAME} --allow-root


echo "Instalando WordPress..."
wp core install --path=/var/www/html --url=${DOMAIN_NAME} --title=${hola} --admin_user=${DB_USER} --admin_password=${DB_PASS} --admin_email=${prando-a@student.42malaga.com} --allow-root

# Inicia PHP-FPM
echo "Iniciando PHP-FPM..."
php-fpm7.4 -y /etc/php/7.4/fpm/php-fpm.conf -F 

