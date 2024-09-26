FROM debian:bullseye

RUN mkdir -p /var/www/html
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install php php-mysql php-fpm
RUN apt-get -y install mariadb-client
RUN apt-get -y install wget tar

RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz
RUN tar -xzf /tmp/wordpress.tar.gz -C /var/www/html

COPY /config/setup-wp.sh .

RUN chmod +x /setup-wp.sh

EXPOSE 9000

# Inicia PHP-FPM
CMD ["/setup-wp.sh"]
