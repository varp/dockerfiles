# dockerfiles
Ubuntu based development environment

## base
Minimalistic base environment, based on Ubuntu Xenial
 - Locales enabled
 - BASH as default shell interpreter
 - Full set of APT utils.

## basecli
Simple dev environment with timezones enabled and vital cli utils and completions
 - wget
 - curl
 - unzip
 - p7zip
 - bash-completion
 - git
 - mc
 - vim-nox
 
 ## lemp
 Based on the **basecli** image is ready to use LEMP stack
 - php 7.1 (xdebug,zip,curl,gd,intl,mdstring)
 - mysql 5.7
 
 ## php
 Set of images based on [the official Docker's php images](https://store.docker.com/images/php).
 
 ### laravel
 Simple development environment based on the [php:7.1-fpm](https://github.com/docker-library/php/blob/3f3220a0aa5992cdc08128cbbe0f2490694d6be9/7.1/stretch/fpm/Dockerfile) with:
  - NVM
  - PHP_VERSION=7.1
  - PHP_EXT=intl\ mbstring\ mcrypt\ pcntl\ pdo\ pdo_mysql\ pdo_pgsql\ zip\ opcache\ xml
  - PHP_PECL_EXT=xdebug\ redis
  - BASH instead of Dash
  - apt-utils
  - ca-certificates
  - vim-nox
  - preinstalled composer and `hirak/prestissimo`
