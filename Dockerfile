FROM alpine:latest AS framadate-fetcher
RUN apk add unzip wget curl
RUN curl -L https://packages.framasoft.org/projects/framadate/framadate-1.1.19.zip -o /tmp/framadate.zip
RUN unzip /tmp/framadate.zip -d /tmp

FROM php:8.2.12-apache

RUN set -eux; \
    apt-get update; \
    apt-get install -y\
        libicu-dev libxml2-dev libonig-dev; \
    docker-php-ext-install \
        intl pdo_mysql mbstring xml; \
    rm -rf /var/lib/apt/lists/*;

RUN a2enmod headers

COPY --chown=www-data:www-data --from=framadate-fetcher /tmp/framadate /var/www/html/framadate
COPY --chown=www-data:www-data config/.htaccess /var/www/html/framadate/admin/.htaccess
COPY --chown=www-data:www-data config/config.php /var/www/html/framadate/app/inc/config.php
COPY --chown=www-data:www-data config/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY --chown=www-data:www-data config/php.ini "$PHP_INI_DIR/php.ini"
COPY --chown=www-data:www-data resources/banner.png /var/www/html/framadate/images/banner.png
COPY entrypoint.sh /tmp/entrypoint.sh
COPY entrypoint_init.sh /tmp/entrypoint_init.sh

RUN touch /var/www/html/framadate/admin/stdout.log
RUN chmod 600 /var/www/html/framadate/admin/stdout.log
RUN chmod +x /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint_init.sh
RUN chown -R www-data:www-data /var/www/html/framadate

ENTRYPOINT [ "/tmp/entrypoint.sh" ]