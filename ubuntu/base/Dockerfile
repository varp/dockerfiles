FROM ubuntu:focal-20201106
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="base" target="dev"


ENV TZ Europe/Moscow
ENV DEBIAN_FRONTEND noninteractive
ENV DEFAULT_LOCALE ru_RU.UTF-8
ENV DEFAULT_LANG en_US.UTF-8
ENV DEFAULT_COLLATE ru_RU.UTF-8

USER root

## Enable Ubuntu Universe, Multiverse, and deb-src for main.
RUN set -ex \
  sed -i -e 's/^#\s*\(deb.*main restricted\)$/\1/g' \
  -e 's/^#\s*\(deb.*universe\)$/\1/g' \
  -e 's/^#\s*\(deb.*multiverse\)$/\1/g'; \
  apt-get update && \
  apt-get -y install \
  apt-utils \
  debconf-utils \
  apt-transport-https \
  ca-certificates \
  ubuntu-minimal \
  software-properties-common \
  gettext-base \
  bash; \
  apt-get clean; rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/* /var/tmp/* 

RUN set -ex; \
  update-alternatives --install /bin/sh sh /bin/bash 10; \
  update-alternatives --install /bin/sh sh /bin/dash 20; \
  update-alternatives --set sh /bin/bash; \
  cp -f /etc/skel/.bashrc /root/; \
  chsh -s /bin/bash

RUN set -eux; \
  locale-gen ${DEFAULT_LANG} ${DEFAULT_LOCALE}; \
  update-locale LANG=${DEFAULT_LANG}; \
  echo -e "LANGUAGE=${DEFAULT_LOCALE}\nLANG=${DEFAULT_LANG}\nLC_ALL=${DEFAULT_LOCALE}\nLC_COLLATE=${DEFAULT_COLLATE}\n" > /etc/default/locale \
  ; \
  ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime; \
  echo ${TZ} > /etc/timezone; \
  echo ${TZ} > /etc/default/timezone

ENV LC_ALL ${DEFAULT_LOCALE}
ENV LC_COLLATE ${DEFAULT_COLLATE}
ENV LANG ${DEFAULT_LANG}

CMD ["/bin/bash"]
