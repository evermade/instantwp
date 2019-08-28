FROM ubuntu:18.04
MAINTAINER Jaakko Alajoki <jaakko@alajoki.fi>

# Install nginx and php
RUN apt-get update
RUN apt-get install -y nginx php7.2-fpm php7.2-mysql vim curl

# Run nginx as daemon
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Install mariadb (with empty root password)
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server

# Add out local configs in.
ADD default /etc/nginx/sites-available/
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

# Install wp-cli
RUN bash -c "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
RUN bash -c "chmod +x wp-cli.phar"
RUN bash -c "mv wp-cli.phar /usr/local/bin/wp"

WORKDIR /var/www/html/

# Start daemons.
ENTRYPOINT ["/entrypoint.sh"]
