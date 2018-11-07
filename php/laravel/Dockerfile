FROM php:7.1-fpm
LABEL maintainer="vardan.pogosyan@gmail.com" repo="vardan/ubuntu" project="laravel" target="dev" language="php" language="nodejs"


ENV WORK_DIR=/var/www/html \
    PHP_VERSION=7.1 \
    PHP_EXT=intl\ mbstring\ mcrypt\ pcntl\ pdo\ pdo_mysql\ pdo_pgsql\ zip\ opcache\ xml \
    PHP_PECL_EXT=xdebug\ redis


RUN set -ex; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
    python \
    unzip \
    vim-nox \
    apt-utils \
    debconf-utils \
    apt-transport-https \
    ca-certificates \
    locales; \
    rm -rf /var/lib/apt/lists/*; \
    sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen; \
    update-locale LANG=ru_RU.UTF-8


RUN set -ex; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y bash bash-completion; \
    update-alternatives --install /bin/sh sh /bin/bash 10; \
    update-alternatives --install /bin/sh sh /bin/dash 20; \
    update-alternatives --set sh /bin/bash; \
    cp -f /etc/skel/.bashrc /root/; \
    chsh -s /bin/bash; \
    mkdir /root/.bash_completions.d/ && touch /root/.bash_completions.d/empty; \
    echo 'for compl in /root/.bash_completions.d/*; do source "${compl}"; done' >> /root/.bashrc; \
    rm -rf /var/lib/apt/lists/*

RUN set -ex && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
    libicu-dev \
    libpq-dev \
    man \
    libpq5 \
#    postgresql-client-9.6 \
    libmcrypt-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libyaml-dev \
    libxml2-dev \
    libpng-dev \
    nasm \
    ; \
    rm -rf /var/lib/apt/lists/* \
    ; \
    pecl channel-update pecl.php.net && \
    pecl install ${PHP_PECL_EXT} && \
    docker-php-ext-enable ${PHP_PECL_EXT}; \
    docker-php-ext-install ${PHP_EXT} \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer; \
    echo "export COMPOSER_ALLOW_ROOT=true" >> /root/.bashrc; \
    composer global require hirak/prestissimo -n

# Install nodejs
RUN set -eo pipefail; \
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash; \
    export NVM_DIR="$HOME/.nvm"; \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; \
    nvm install node

ADD conf/php.fpm.ini $PHP_INI_DIR/conf.d/php.fpm.ini
ADD conf/phpfpm.conf $PHP_INI_DIR/php-fpm.d/www.conf

WORKDIR /var/www/html

