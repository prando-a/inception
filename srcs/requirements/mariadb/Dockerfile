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

COPY ./tools/setup-db.sh .

RUN chmod +x setup-db.sh

CMD ["./setup-db.sh"]

