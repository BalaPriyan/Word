#!/bin/bash
# Start MySQL
service mysql start

# Create MySQL database and user
mysql -u root -e "CREATE DATABASE wordpress_db;"
mysql -u root -e "CREATE USER 'wordpress_user'@'localhost' IDENTIFIED BY 'wordpress_password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Start Apache (WordPress)
apache2-foreground
