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
 Based on the **basecli** image is fully configured for comfortable use for developent environment.
 
 - php 7.1
   - uuid
   - gettext
   - fpm
   - intl
   - mbstring
   - mysql
   - gd
   - pgsql
   - sqlite3
   - zip
   - opcache
   - xml
   - yaml
   - zip
   - curl
   - http
   - imagick
   - xdebug
   - redis
   - memcache
   - intl
   - json
   - cli
   - exif