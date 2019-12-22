FROM vardan/ubuntu:basecli
LABEL maintainer="vardan.pogosyan@gmail.com" repo="vardan/ubuntu" target="dev" app="php"


ENV WORK_DIR /var/www/html
ENV PHP_VERSION 7.2
ENV PHP_INI_DIR /etc/php/${PHP_VERSION}
ENV PHP_EXT fpm intl mbstring mysql pgsql sqlite3 zip opcache xml yaml zip curl http gmagick \
   xdebug redis memcache

RUN set -e -x -o pipefail \
   ; \
   export PHP_VERSION; \
   apt-get update && \
   apt-get install --no-install-recommends -y \
   libicu-dev \
   libpq-dev \
   libpq5 \
   libmcrypt-dev \
   zlib1g-dev \
   libfreetype6-dev \
   libjpeg-turbo8-dev \
   libyaml-dev \
   libxml2-dev \
   libpng-dev \
   graphicsmagick \
   graphicsmagick-imagemagick-compat graphicsmagick-libmagick-dev-compat \
   $(echo ${PHP_EXT} | awk "BEGIN {RS=\" \"} { printf \" php%s-%s\", \"$PHP_VERSION\", \$1; }") \
   ; \
   apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 


ENV COMPOSER_ALLOW_ROOT true

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer; \
    echo "export COMPOSER_ALLOW_ROOT=true" >> /root/.bashrc; \
    composer global require hirak/prestissimo -n && composer clear-cache


ADD conf/php.fpm.ini ${PHP_INI_DIR}/fpm/php.ini
ADD conf/php-fpm.conf ${PHP_INI_DIR}/fpm/php-fpm.conf

WORKDIR ${WORK_DIR}

VOLUME [ "/var/www/html" ]

STOPSIGNAL SIGQUIT

EXPOSE 9000

ENTRYPOINT  ["/usr/sbin/php-fpm7.2", "--allow-to-run-as-root"]