FROM vardan/ubuntu:base
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="basecli"


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update 

RUN set -ex \
    apt-get -qqy update && apt-get -qqy install \
    wget \
    curl \
    tzdata \
    unzip \
    bash \
    bash-completion \
    language-pack-ru \
    console-cyrillic \
    git \
    mc \
    vim-nox; \
    echo "ru_RU.UTF-8" > /etc/default/locale && \
    update-locale LC_ALL='ru_RU.UTF-8' && \
    dpkg-reconfigure locales && \
    useradd -m -G adm,sudo -s /bin/bash ubuntu && \
    echo "ubuntu ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    rm -rf /var/lib/apt/lists/*

CMD "/bin/bash"
ENTRYPOINT "/bin/bash"
