#!/bin/bash

sudo service mysql restart && \
sudo service php7.1-fpm restart && \
sudo service nginx restart && \
tailf /var/log/nginx/access.log
