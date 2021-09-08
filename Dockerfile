FROM debian:buster

RUN apt-get -y update  && apt-get -y upgrade
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install procps
RUN apt-get -y install openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=Ayoub"
COPY srcs/default etc/nginx/sites-available/
RUN apt-get install php-mbstring php-gd php-zip php-xml php-pear php-gettext php-cli php-cgi -y
RUN apt-get install php-mysql -y
RUN apt-get install php7.3-fpm -y
RUN apt-get -y install default-mysql-server
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar xf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.0.1-all-languages var/www/html/phpmyadmin/
RUN wget https://wordpress.org/latest.tar.gz
RUN tar xf latest.tar.gz
RUN mv wordpress/ var/www/html/wordpress
COPY srcs/config.inc.php var/www/html/phpmyadmin/
COPY srcs/wp-config.php var/www/html/wordpress/
COPY srcs/Script.sh tmp/
RUN sh tmp/Script.sh
COPY srcs/Start.sh Scripts/
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p ~/Scripts
CMD sh Scripts/Start.sh
