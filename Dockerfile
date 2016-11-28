FROM ubuntu:latest

#Install nginx
RUN apt-get -y --force-yes  update && apt-get install -y nginx && apt-get -y --force-yes install php7.0-fpm && apt-get install -y --force-yes git\
  && apt-get -y --force-yes install php-fpm php-mysql php-mbstring

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/


# Remove the default site configuration file
RUN rm -v /etc/nginx/sites-enabled/default

# Copy the default website configuration file from the current directory
ADD default /etc/nginx/sites-enabled/

# Copy php info file
ADD phpinfo.php /var/www/html/

# Copy Startup script
ADD startup.sh /root/

#Make startup.sh executable
RUN chmod 550 /root/startup.sh

EXPOSE 80

CMD ["bash", "/root/startup.sh"]
