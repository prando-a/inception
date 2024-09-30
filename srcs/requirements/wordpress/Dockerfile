FROM debian:bullseye

RUN mkdir -p /var/www/html
RUN apt-get update -y && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    unzip \
    wget \
    curl

RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
RUN tar -xzf /tmp/wordpress.tar.gz -C /var/www/html

RUN useradd wp_user && groupadd wp_group && usermod -aG wp_group wp_user

RUN mkdir -p /var/www/html && chown wp_user:wp_group /var/www/html

COPY /tools/setup-wp.sh .
COPY config/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
COPY /config/wp-config.php .

RUN chmod +x setup-wp.sh

EXPOSE 9000

# Inicia PHP-FPM
CMD ["/setup-wp.sh"]
