# Usa Ubuntu como imagen base
FROM debian:bullseye

# Actualiza el sistema e instala dependencias necesarias
RUN apt-get update && apt-get install -y \
	php7.4-fpm \
	php7.4-mysql \
	php7.4-curl \
	php7.4-gd \
	php7.4-mbstring \
    curl \
    unzip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Instala WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Configura PHP
COPY config/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

RUN mkdir -p /var/www/html

# Descarga e instala WordPress
RUN curl -O https://wordpress.org/latest.zip
RUN unzip latest.zip -d /var/www/html
RUN rm latest.zip
RUN chown -R www-data:www-data /var/www/html/wordpress
RUN mv /var/www/html/wordpress/* /var/www/html/
RUN rmdir /var/www/html/wordpress
RUN wp config create --path=var/www/html --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASSWORD --dbhost=$WP_DB_HOST  --allow-root

# Copia el script de configuración
COPY ./config/setup-wp.sh /setup-wp.sh
RUN chmod +x /setup-wp.sh

# Expone el puerto 80
EXPOSE 80

RUN useradd prando-a && groupadd wp_group && usermod -aG wp_group prando-a

# Inicia Nginx y PHP-FPM
CMD /setup-wp.sh
