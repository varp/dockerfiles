FROM vardan/ubuntu:base
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="basecli"
LABEL target="dev"


ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 

RUN set -ex \
    apt-get update && apt-get install -y -q \
    wget \
    curl \
    tzdata \
    bash \
    bash-completion \
    language-pack-ru \
    git \
    mc \
    vim-nox; \
    echo "ru_RU.UTF-8" > /etc/default/locale && \
    update-locale LC='ru_RU.UTF-8' && \
    dpkg-reconfigure locales && \
    useradd -m -G adm,sudo -s /bin/bash ubuntu && \
    rm -rf /var/lib/apt/lists/*

CMD "/bin/bash"
ENTRYPOINT "/bin/bash"
