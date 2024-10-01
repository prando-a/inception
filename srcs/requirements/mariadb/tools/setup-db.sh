#!/bin/sh

echo "[DEBUG]: env passed..."
echo "--------------------------"
echo "NAME: $DB_NAME"
echo "USERNAME: $DB_USER"
echo "PASSWORD: $DB_PASS"
echo "ROOT PASSWORD: $DB_ROOT_PASS"
echo "--------------------------"

service mariadb start && \
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > msql_db.sql && \
echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}' ;" >> msql_db.sql && \
echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' ;" >> msql_db.sql && \
echo "FLUSH PRIVILEGES;" >> msql_db.sql && \
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}' ;" >> msql_db.sql && \
mariadb < msql_db.sql

echo "[DEBUG]: msql_db.sql content:"
echo "--------------------------"
cat msql_db.sql
echo "--------------------------"

chmod 777 msql_db.sql
mv msql_db.sql /run/mysqld/msql_db.sql
chown -R mysql:root /var/run/mysqld

mariadbd --user=mysql --init-file=/run/mysqld/msql_db.sql