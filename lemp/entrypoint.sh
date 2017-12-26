#!/bin/bash

service mysql restart && \
service php7.1-fpm restart && \
service nginx restart && \
tailf /var/log/nginx/access.log
