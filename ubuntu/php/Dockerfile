FROM vardan/ubuntu:basecli
LABEL maintainer="vardan.pogosyan@gmail.com" repo="vardan/ubuntu" target="dev" app="php"


ENV WORK_DIR ${PHP_DOCUMENT_ROOT:-/var/www/html}
ENV PHP_VERSION 7.2
ENV PHP_INI_DIR /etc/php/${PHP_VERSION}
ENV PHP_FPM php-fpm${PHP_VERSION}
ENV PHP_EXT uuid gettext fpm intl mbstring mysql pgsql sqlite3 zip opcache xml yaml zip curl http gmagick \
   xdebug redis memcache intl json cli

ENV XDEBUG_PORT ${PHP_XDEBUG_PORT:-9001}
ENV XDEBUG_HOST ${PHP_XDEBUG_HOST:-docker.host.inernal}
ENV XDEBUG_IDEKEY ${PHP_XDEBUG_IDEKEY:-PHPSTORM}
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN set -e -x -o pipefail \
   ; \
   export PHP_VERSION PHP_FPM; \
   apt-get update && \
   apt-get install --no-install-recommends -y \
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
   ghostscript \
   libpng16-16 \
   libpng-tools \
   libtiff5 \
   libtiff-tools \
   graphicsmagick \
   graphicsmagick-imagemagick-compat graphicsmagick-libmagick-dev-compat \
   redis-tools \
   libsqlite3-0 \
   sqlite3 \
   $(echo ${PHP_EXT} | awk "BEGIN {RS=\" \"} { printf \" php%s-%s\", \"$PHP_VERSION\", \$1; }") \
   ; \
   ln -s /usr/sbin/${PHP_FPM} /usr/sbin/php-fpm; \
   apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer; \
    composer global require hirak/prestissimo -n && composer clear-cache


ADD conf/php.fpm.ini ${PHP_INI_DIR}/fpm/php.ini
ADD conf/php-fpm.conf ${PHP_INI_DIR}/fpm/php-fpm.conf
ADD conf/21-xdebug-config.ini.template /tmp/

RUN set -ex; \ 
   envsubst '${XDEBUG_IDEKEY},${XDEBUG_HOST},${XDEBUG_PORT}' < /tmp/21-xdebug-config.ini.template \
    | tee ${PHP_INI_DIR}/{fpm,cli}/conf.d/21-xdebug-config.ini

WORKDIR ${WORK_DIR}

VOLUME ${WORK_DIR}

STOPSIGNAL SIGQUIT

EXPOSE 9000

ENTRYPOINT  ["/usr/sbin/php-fpm", "--allow-to-run-as-root"]