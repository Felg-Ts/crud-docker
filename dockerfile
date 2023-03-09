FROM php:7.4-apache-bullseye
COPY src/ /var/www/html
ADD script.sh /opt/
RUN apt update && apt upgrade -y && apt install apache2 mariadb-client -y && docker-php-ext-install mysqli pdo pdo_mysql && apt clean && chmod +x /opt/script.sh
WORKDIR /var/www/html
ENV DB_HOST='db_crud'
ENV DB_NAME='crud'
ENV DB_USER='cruduser'
ENV DB_PASSWORD='crudpass'
CMD ["/opt/script.sh"]
