from debian:bullseye

ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG WORDPRESS_DB_HOST

RUN apt-get update && apt-get install -y mariadb-server

RUN mkdir -p /docker-entrypoint-initdb.d

RUN mkdir -p /var/run/mysqld/
RUN chown -R mysql:mysql /var/run/mysqld/
RUN mkdir -p /etc/mysql
COPY ./config/my.cnf /etc/mysql/my.cnf

RUN service mariadb start && \
    echo "CREATE DATABASE IF NOT EXISTS mariadb ;" > msql_db.sql && \
    echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;" >> msql_db.sql && \
    echo "GRANT ALL PRIVILEGES ON ${MYSQL_ROOT_PASSWORD}.* TO '${MYSQL_USER}'@'%' ;" >> msql_db.sql && \
    echo "FLUSH PRIVILEGES;" >> msql_db.sql && \
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;" >> msql_db.sql && \
    mariadb < msql_db.sql



CMD ["mysqld"]
