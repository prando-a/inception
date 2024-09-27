FROM debian:bullseye

# Definir variables de entorno
ARG DB_NAME
ARG DB_ROOT_PASS
ARG DB_USER
ARG DB_PASS

# Instalar MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Crear directorios necesarios
RUN mkdir -p /docker-entrypoint-initdb.d
RUN mkdir -p /var/run/mysqld/
RUN chown -R mysql:mysql /var/run/mysqld/
RUN mkdir -p /etc/mysql

EXPOSE 3306

# Copiar configuración personalizada de MariaDB
COPY ./config/my.cnf /etc/mysql/maria.conf.d

# Inicializar la base de datos
RUN service mariadb start && \
    echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME} ;" > msql_db.sql && \
    echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}' ;" >> msql_db.sql && \
    echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' ;" >> msql_db.sql && \
    echo "FLUSH PRIVILEGES;" >> msql_db.sql && \
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}' ;" >> msql_db.sql && \
    mariadb < msql_db.sql

RUN chmod 777 msql_db.sql
RUN mv msql_db.sql /run/mysqld/msql_db.sql
RUN chown -R mysql:root /var/run/mysqld


CMD ["mariadbd", "--user=mysql", "--init-file=/run/mysqld/msql_db.sql"]

