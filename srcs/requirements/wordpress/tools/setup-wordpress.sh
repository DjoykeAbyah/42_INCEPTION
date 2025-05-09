#!/bin/bash

set -e

# Wait for MariaDB to be available
until mysqladmin ping -h"$WORDPRESS_DATABASE_HOST" --silent; do
    echo "Waiting for database..."
    sleep 2
done

# Only set up if wp-config.php doesn't exist
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating WordPress Configuration..."
    wp config create \
        --path="/var/www/html" \
        --dbname="${WORDPRESS_DATABASE_NAME}" \
        --dbuser="${DATABASE_USER}" \
        --dbpass="${DATABASE_USER_PASSWORD}" \
        --dbhost="${WORDPRESS_DATABASE_HOST}" \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --path="/var/www/html" \
        --url="${DOMAIN_NAME}" \
        --title="inception" \
        --admin_user="${WORDPRESS_ADMIN}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
        --allow-root

    echo "Creating WordPress User..." 
    wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} \
        --path="/var/www/html" \
        --user_pass="${WORDPRESS_USER_PASSWORD}" \
        --role=editor \
        --allow-root

    echo "WordPress setup complete."
else
    echo "WordPress is already set up."
fi

# Start php-fpm
exec php-fpm7.4 -F
