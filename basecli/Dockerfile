FROM vardan/ubuntu:base
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="basecli" target="dev"

ENV DEBIAN_FRONTEND noninteractive
ENV DEFAULT_LOCALE ru_RU.UTF-8


USER root

RUN apt-get -qqy update 


COPY debconf /

RUN set -ex \
    apt-get -qqy update && apt-get -qqy install \
    wget \
    curl \
    tzdata \
    unzip \
    p7zip \
    bash \
    bash-completion \
    language-pack-ru \
    console-cyrillic \
    git \
    mc \
    vim-nox; \
    update-alternatives --install /bin/sh sh /bin/bash 100 && \
    debconf-set-selections < /debconf/console-setup-cyrillic.conf && \
    dpkg-reconfigure console-setup && \
    dpkg-reconfigure console-cyrillic && \
    cp -f /etc/skel/.bashrc /root/ && \
    update-locale LANG=$DEFAULT_LOCALE && \
    echo "LANGUAGE=$DEFAULT_LOCALE" >> /etc/default/locale && \
    echo "LC_ALL=$DEFAULT_LOCALE" >> /etc/default/locale && \
    useradd -m -G adm,sudo -s /bin/bash ubuntu && \
    cp -f /etc/skel/.bashrc /home/ubuntu/ && \
    echo "ubuntu ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    rm -rf /var/lib/apt/lists/*

USER ubuntu

CMD ["/bin/sh"]
