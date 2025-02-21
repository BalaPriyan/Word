# Use an official PHP image with Apache
FROM php:7.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    wget \
    mariadb-server \
    mariadb-client \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Set up MySQL
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld
COPY my.cnf /etc/mysql/my.cnf

# Download and extract WordPress
RUN wget -O wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzf wordpress.tar.gz && \
    mv wordpress /var/www/html/ && \
    rm wordpress.tar.gz

# Set up startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose port
EXPOSE 80

# Set entrypoint
CMD ["/start.sh"]
