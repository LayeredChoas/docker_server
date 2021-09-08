#! /bin/sh
service mysql start
mysql < /var/www/html/phpmyadmin/sql/create_tables.sql
mysql -u root -e "CREATE USER 'ayoub'@'localhost' IDENTIFIED BY 'ayoub';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'ayoub'@'localhost';"
mysql -u root -e "CREATE USER 'guest'@'localhost' IDENTIFIED BY 'guest';"
mysql -u root -e "GRANT INSERT,SELECT,DELETE,UPDATE ON phpmyadmin.* TO 'guest'@'localhost';"
mysql -u root -e "CREATE DATABASE wordpress_db;"
mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'ayoub'@'localhost';"
