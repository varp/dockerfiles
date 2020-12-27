FROM vardan/ubuntu:basecli
LABEL maintainer="vardan.pogosyan@gmail.com" repo="vardan/ubuntu" target="dev" app="php"

ARG PHP_VERSION
ENV PHP_VERSION=${PHP_VERSION:-7.2}

ENV WORK_DIR ${PHP_DOCUMENT_ROOT:-/var/www/html}
ENV PHP_INI_DIR /etc/php/${PHP_VERSION}
ENV PHP_FPM php-fpm${PHP_VERSION}
ENV PHP_EXT uuid gettext fpm mbstring mysql gd pgsql sqlite3 zip opcache xml yaml zip curl \
   xdebug redis memcache intl json cli exif mailparse xmlrpc propro raphf http imagick

ENV XDEBUG_PORT ${XDEBUG_PORT:-9003}
ENV XDEBUG_HOST ${XDEBUG_HOST:-docker.host.internal}
ENV XDEBUG_IDEKEY ${XDEBUG_IDEKEY:-PHPSTORM}

ENV PHP_IDE_CONFIG ${PHP_IDE_CONFIG:-serverName=php.xdebug.internal}
ENV XDEBUG_CONFIG client_host=${XDEBUG_HOST} client_port=${XDEBUG_PORT} idekey=${XDEBUG_IDEKEY}
ENV XDEBUG_MODE develop,coverage,debug
## uncomment the following line to permanently enable auto-start 
## of debug session for every PHP CLI session calls
# ENV XDEBUG_SESSION 1

ENV COMPOSER_ALLOW_SUPERUSER 1

USER root


# Installing underlying deps for PHP extensions
RUN set -ex -o pipefail \
   ; \
   add-apt-repository ppa:ondrej/php -y; \
   apt-get update && \
   apt-get install -y \
   libicu-dev \
   libpq-dev \
   libpq5 \
   postgresql-client \
   libmcrypt-dev \
   zlib1g-dev \
   libfreetype6-dev \
   libjpeg-turbo8-dev \
   libyaml-dev \
   libexif12 \
   libexif-dev \
   libxml2-dev \
   libpng-dev \
   mysql-client \
   libpng16-16 \
   libpng-tools \
   libtiff5 \
   libtiff-tools \
   imagemagick \
   gsfonts \
   libgs9 \
   redis-tools \
   libsqlite3-0 \
   sqlite3 \
   $(echo ${PHP_EXT} | awk "BEGIN {RS=\" \"} { printf \" php%s-%s\", \"$PHP_VERSION\", \$1; }") \
   ; \
   ln -s /usr/sbin/${PHP_FPM} /usr/sbin/php-fpm; \
   mkdir -p /run/php; \
   apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 


ADD conf/php.fpm.ini ${PHP_INI_DIR}/fpm/php.ini
ADD conf/php-fpm.conf ${PHP_INI_DIR}/fpm/php-fpm.conf
ADD conf/21-xdebug-config.ini.template /tmp/

RUN set -ex; \ 
   envsubst '${XDEBUG_IDEKEY},${XDEBUG_HOST},${XDEBUG_PORT}' < /tmp/21-xdebug-config.ini.template \
   | tee ${PHP_INI_DIR}/fpm/conf.d/21-xdebug-config.ini


WORKDIR ${WORK_DIR}

VOLUME ${WORK_DIR}

STOPSIGNAL SIGQUIT

EXPOSE 9000

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

USER ubuntu

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/ubuntu/bin --filename=composer