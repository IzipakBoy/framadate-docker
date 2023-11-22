#!/bin/bash

htpasswd -b -c /var/www/html/framadate/admin/.htpasswd admin ${APP_ADMIN_PASSWORD}
chown www-data:www-data /var/www/html/framadate/admin/.htpasswd
rm -f /var/www/html/framadate/app/inc/config.php
docker-php-entrypoint apache2-foreground