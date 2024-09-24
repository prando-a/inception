FROM debian:bullseye

# Definir variables de entorno
ENV DB_NAME=${DB_NAME}
ENV DB_ROOT_PASS=${DB_ROOT_PASS}
ENV DB_USER=${DB_USER}
ENV DB_PASS=${DB_PASS}

# Instalar MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Crear directorios necesarios
RUN mkdir -p /docker-entrypoint-initdb.d
RUN mkdir -p /var/run/mysqld/
RUN chown -R mysql:mysql /var/run/mysqld/
RUN mkdir -p /etc/mysql

# Copiar configuración personalizada de MariaDB
COPY ./config/my.cnf /etc/mysql/my.cnf

# Inicializar la base de datos
RUN service mariadb start && \
    echo "CREATE DATABASE IF NOT EXISTS '${DB_NAME}' ;" > msql_db.sql && \
    echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}' ;" >> msql_db.sql && \
    echo "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' ;" >> msql_db.sql && \
    echo "FLUSH PRIVILEGES;" >> msql_db.sql && \
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}' ;" >> msql_db.sql && \
    mariadb < msql_db.sql

# Iniciar el servidor de MariaDB
CMD ["mysqld"]

