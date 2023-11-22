#!/bin/bash

htpasswd -b -c /var/www/html/framadate/admin/.htpasswd admin ${APP_ADMIN_PASSWORD}
chown www-data:www-data /var/www/html/framadate/admin/.htpasswd
sed -i "s/ENV_APP_URL/${APP_URL}/" /var/www/html/framadate/app/inc/config.php
sed -i "s/ENV_DB_ADRESS/${DB_ADRESS}/" /var/www/html/framadate/app/inc/config.php
sed -i "s/ENV_DB_PASSWORD/${DB_PASSWORD}/" /var/www/html/framadate/app/inc/config.php
docker-php-entrypoint apache2-foreground