FROM ubuntu:latest
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="base" target="dev"



ENV TZ="Europe/Moscow"
ENV DEBIAN_FRONTEND noninteractive
ENV DEFAULT_LOCALE en_US.UTF-8

USER root

RUN mkdir -p /var/lib/resolvconf

RUN set -ex \
    touch /var/lib/resolvconf/linkified; \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" \
    | debconf-set-selections; \
    apt-get -qqy update && \
    apt-get -qqy install \
    apt-utils \
    debconf-utils \
    apt-transport-https \
    ca-certificates \
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
    echo "LANGUAGE=$DEFAULT_LOCALE" >> /etc/default/locale && \
    echo "LC_ALL=$DEFAULT_LOCALE" >> /etc/default/locale && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    echo $TZ > /etc/default/timezone && \
    rm -rf /var/lib/apt/lists/*


CMD ["/bin/sh"]
