#!/bin/bash

INSTANTWP_REINSTALL=1

# If either WP dir or MySQL data dirs are empty we are reinstalling everything.
if [ "$(ls -A .)" ]; then
    echo "WordPress installation exists."
    INSTANTWP_REINSTALL=0
else
    echo "WordPress installation doesn't exist. Force reinstall!"
    INSTANTWP_REINSTALL=1
fi
if [ "$(ls -A /var/lib/mysql/)" ]; then
    echo "MySQL data exists."
    INSTANTWP_REINSTALL=0
else
    echo "MySQL data files doesn't exist. Force reinstall!"
    INSTANTWP_REINSTALL=1
fi

# Alter PHP settings to allow large file uploads.
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/g' /etc/php/7.4/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 256M/g' /etc/php/7.4/fpm/php.ini

# Do reinstall.
if [ "$INSTANTWP_REINSTALL" = 1 ]; then

    echo "Reinstall..."

    # Clean wp & mysql folders.
    rm -rf ./*
    rm -rf /var/lib/mysql/*

    # Init db
    mysql_install_db --user=mysql --ldata=/var/lib/mysql/

    # Start our daemons
    service mysql start
    service php7.4-fpm start

    # Create database.
    mysql -uroot -e "CREATE DATABASE app;"
    mysql -e "CREATE USER 'instantwp'@'localhost' IDENTIFIED BY 'instantwp';"
    mysql -e "GRANT ALL PRIVILEGES ON * . * TO 'instantwp'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

    # Clean installation folder.
    rm -rf /var/www/html/*

    # Download WordPress
    wp core download --allow-root --locale=$INSTANTWP_LOCALE

    wp config create --allow-root --dbname=app --dbuser=instantwp --dbpass=instantwp --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
PHP

    # Install
    wp core install --allow-root --url=$INSTANTWP_URL --title=InstantWP --admin_user=instantwp --admin_password=instantwp --admin_email=info@example.com

    # Install plugins
    IFS=',' read -r -a plugins_array <<< "$INSTANTWP_PLUGINS"
    for plugin in "${plugins_array[@]}"
    do
        wp plugin install $plugin --activate --allow-root
    done


else

    echo "Starting daemons..."

    # Start our daemons
    service mysql start
    service php7.4-fpm start

fi

# Add write permissions to uploads.
mkdir -p /var/www/html/wp-content/uploads/
chmod -R 777 /var/www/html/wp-content/uploads/

echo "All done! Now open your browser: http://127.0.0.1"

# Run nginx
exec nginx
