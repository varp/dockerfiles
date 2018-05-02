FROM ubuntu:xenial
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="base" target="dev"



ENV TZ="Europe/Moscow"
ENV DEBIAN_FRONTEND noninteractive

ENV DEFAULT_LOCALE en_US.UTF-8

USER root


## Enable Ubuntu Universe, Multiverse, and deb-src for main.
RUN sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list && \
    sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list && \
    sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list && \
    apt-get update


RUN apt-get update  && apt-get -y install --no-install-recommends

RUN apt-get update && \
    apt-get -qy install --no-install-recommends --no-install-suggests \
    apt-utils \
    debconf-utils \
    apt-transport-https \
    ca-certificates 

## Upgrade all packages.
RUN apt-get dist-upgrade -qy --no-install-recommends -o Dpkg::Options::="--force-confold"


RUN mkdir -p /var/lib/resolvconf    
RUN touch /var/lib/resolvconf/linkified; \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" \
    | debconf-set-selections; \
    apt-get update && \
    apt-get -qy install \
    resolvconf \
    ubuntu-minimal \
    gettext-base \
    python3 \
    python3-pip \
    python-software-properties \
    software-properties-common \
    language-pack-en \
    apparmor && \
    pip3 install --upgrade pip && \
    sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=$DEFAULT_LOCALE && \
    echo "LANGUAGE=$DEFAULT_LOCALE" > /etc/default/locale && \
    echo "LANG=$DEFAULT_LOCALE" >> /etc/default/locale && \
    echo "LC_ALL=$DEFAULT_LOCALE" >> /etc/default/locale && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    echo $TZ > /etc/default/timezone && \
    apt-get -qy autoremove && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

ENV LC_ALL $DEFAULT_LOCALE
ENV LANG $DEFAULT_LOCALE
ENV LANGUAGE $DEFAULT_LOCALE

CMD ["/bin/sh"]
