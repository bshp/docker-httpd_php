# docker-httpd_php
Docker for Apache with mod_php  
  
````
docker run --publish 80:80 --publish 443:443 --detach --name httpd --volume /var/www/html:/var/www/html --volume /var/log/apache2:/var/log/apache2 bshp/httpd_php:latest
````  
