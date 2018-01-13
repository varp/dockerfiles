FROM ubuntu:latest
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="base"
LABEL target="dev"


ENV DEBIAN_FRONTEND noninteractive


RUN mkdir -p /var/lib/resolvconf

RUN set -ex \
    touch /var/lib/resolvconf/linkified; \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" \
    | debconf-set-selections; \
    apt-get -qqy update && \
    apt-get -qqy install \
    apt-utils \
    resolvconf \
    ubuntu-minimal \
    python3 \
    python3-pip \
    python-software-properties \
    software-properties-common \
    language-pack-en \
    apparmor && \
    pip3 --upgrade && \
    locale-gen 'ru_RU.UTF-8' && \
    update-locale LC_ALL='ru_RU.UTF-8' && \
    dpkg-reconfigure locales && \
    echo "Europe/Moscow" > /etc/timezone && \
    dpkg-reconfigure tzdata && \
    echo "en_US.UTF-8" > /etc/default/locale && \
    echo "Europe/Moscow" > /etc/default/timezone && \
    rm -rf /var/lib/apt/lists/*

CMD "/bin/bash"
