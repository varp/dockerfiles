# dockerfiles
Ubuntu/CentOS based development and applications running environments.

## base
Minimalist base environment, based on Ubuntu/CentOS. In each version of the base distribution you will get enabled:
  - Locales support
  - BASH as default shell interpreter
  - Full set of APT/RPM utils.

The base layer is basically for non-interactive (without terminal and shell) use. This base layer is useful:
  - as a base for fast installing and running application in your own environments, because of enabled by default distribution's packages repositories. In CentOS out-of-box enabled: [Enterprise Linux Repo](https://rpms.remirepo.net/enterprise/7/), which will give you access to the latest version and wide variety of software not available or not enabled by default. In Ubuntu out-of-box enabled: restricted, universe and multiverse repositories.
  - It's convenient to run locale dependent applications such as PostgreSQL (#1). First of all the application will use your locale in cases of data inputs, default collates and outputs it's 
  message and logs.

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
 Based on the **basecli** image is fully configured for comfortable use for development environment.
 
 - php 7.2
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


## Requirements 
The latest version of [Docker CE](https://www.docker.com/products/docker-desktop).


Links:
- #1 - Examples of running PostgreSQL app without of doing boilerplate: `RUN localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8`
