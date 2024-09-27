#!/bin/sh

service mariadb start && \
echo "CREATE DATABASE IF NOT EXISTS mariadbs ;" > msql_db.sql && \
echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}' ;" >> msql_db.sql && \
echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' ;" >> msql_db.sql && \
echo "FLUSH PRIVILEGES;" >> msql_db.sql && \
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}' ;" >> msql_db.sql && \
mariadb < msql_db.sql

chmod 777 msql_db.sql
mv msql_db.sql /run/mysqld/msql_db.sql
chown -R mysql:root /var/run/mysqld

mariadbd --user=mysql --init-file=/run/mysqld/msql_db.sql