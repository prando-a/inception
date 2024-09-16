#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' /root/.env | xargs)

# Set the path where WordPress should be installed
WP_PATH="/var/www/html"

# Download WordPress if not already present
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Downloading WordPress..."
    wp core download --path=$WP_PATH --allow-root
fi

# Create the wp-config.php file using the environment variables
echo "Configuring WordPress..."
wp core config --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --path=$WP_PATH --allow-root

# Install WordPress core
echo "Installing WordPress..."
wp core install --url=$DOMAIN_NAME --title="$WP_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --path=$WP_PATH --allow-root

# Change ownership and permissions
echo "Setting permissions..."
usermod -aG wp_group $(whoami)
chown -R $(whoami):wp_group $WP_PATH && chmod -R 775 $WP_PATH

# Start PHP-FPM
echo "Starting PHP-FPM..."
php-fpm7.4 -y /etc/php/7.4/fpm/php-fpm.conf -F

echo "WordPress installation and configuration complete!"
