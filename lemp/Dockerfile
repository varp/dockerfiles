FROM vardan/ubuntu:basecli
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="lemp"

COPY entrypoint.sh /

RUN apt-get -qqy update 

RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.9-1_all.deb \
    -O /root/mysql-apt-config_0.8.9-1_all.deb && \
    dpkg -i /root/mysql-apt-config_0.8.9-1_all.deb; \
    LC_ALL=ru_RU.UTF-8 add-apt-repository ppa:ondrej/php -y && \
    add-apt-repository ppa:nginx/stable -y && \
    apt-get -qqy update; \
    echo "mysql-community-server mysql-community-server/root-pass password qwerty" | debconf-set-selections; \
    echo "mysql-community-server mysql-community-server/re-root-pass password qwerty" | debconf-set-selections; \
    apt-get -qqy install mysql-server \
    mysql-client \
    php7.1-zip \
    php7.1-curl \
    php7.1-cli \
    php7.1-intl \
    php7.1-mysql \
    php7.1-gd \
    php7.1-xml \
    php7.1-fpm \
    php7.1-mbstring \
    php-xdebug \
    nginx-full && \
    mkdir /run/php && \
    sed -i 's/user = www-data/user = ubuntu/g' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -i 's/group = www-data/group = ubuntu/g' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -i 's/owner = www-data/owner = ubuntu/g' /etc/php/7.1/fpm/pool.d/www.conf && \
    sed -i 's/sendfile on/sendfile off/g' /etc/nginx/nginx.conf && \
    sed -i 's/user www-data/user ubuntu/g' /etc/nginx/nginx.conf && \
    service mysql restart && \
    service php7.1-fpm restart && \ 
    service nginx restart && \
    rm -rf /var/lib/apt/lists/*

RUN chmod a+x /entrypoint.sh

VOLUME /var/lib/mysql

EXPOSE 80 
EXPOSE 3306

CMD "/bin/bash"
ENTRYPOINT ["/entrypoint.sh"]
