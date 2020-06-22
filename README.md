# docker-httpd_php
Docker for Apache with PHP, pre-configured for Moodle and Wordpress  
  
  This is a fairly large image (1.7G), as it has Unoconv and LibreOffice configured for Moodle/Wordpress Document Conversion Plugins
````
docker run \
  --publish 80:80 \
  --publish 443:443 \
  --detach --name httpd \
  --volume /opt/data:/opt/data \
  --volume /var/www/html:/var/www/html \
  --volume /var/log/apache2:/var/log/apache2 \
  bshp/httpd_php:latest
````  
