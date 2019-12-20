# dockerfiles
Ubuntu/CentOS based development environment

## base
Minimalistic base environment, based on Ubuntu/CentOS
 - Locales enabled
 - BASH as default shell interpreter
 - Full set of APT/RPM utils.

## basecli
Simple dev environment with timezones enabled and vital cli utils and completions
 - wget
 - curl
 - unzip
 - p7zip
 - bash-completion
 - git
 - vim-nox/vim-enhanced
 
 ## PHP
 Based on the **basecli** image is ready to use with LEMP stack
 - php 7.2 
    - fpm 
    - intl 
    - mbstring 
    - mcrypt 
    - mysql 
    - pgsql 
    - sqlite3 
    - zip 
    - opcache 
    - xml 
    - yaml 
    - curl 
    - http 
    - gmagick 
    - imagick