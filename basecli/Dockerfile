FROM vardan/ubuntu:base
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="basecli" target="dev"

ENV DEBIAN_FRONTEND noninteractive

ENV DEFAULT_LOCALE ru_RU.UTF-8
ENV LC_ALL $DEFAULT_LOCALE
ENV LANG $DEFAULT_LOCALE
ENV LANGUAGE $DEFAULT_LOCALE


USER root

ADD debconf /debconf

RUN apt-get -qy update 
RUN set -ex \
    apt-get -qy update && apt-get -qy install \
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
    update-alternatives --install /bin/sh sh /bin/bash 10 && \
    update-alternatives --install /bin/sh sh /bin/dash 20 && \
    update-alternatives --set sh /bin/bash && \
    # useless for docker image
    # debconf-set-selections < /debconf/console-setup-cyrillic.conf && \
    # dpkg-reconfigure console-setup && \
    # dpkg-reconfigure console-cyrillic && \
    # setupcon && \
    cp -f /etc/skel/.bashrc /root/ && \
    update-locale LANG=$DEFAULT_LOCALE && \
    echo "LANGUAGE=$DEFAULT_LOCALE" > /etc/default/locale && \
    echo "LC_ALL=$DEFAULT_LOCALE" >> /etc/default/locale && \
    echo "LANG=$DEFAULT_LOCALE" >> /etc/default/locale && \
    useradd -m -G adm,sudo -s /bin/bash  ubuntu && \
    cp -f /etc/skel/.bashrc /home/ubuntu/ && \
    echo "ubuntu ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    apt-get -qy autoremove && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

USER ubuntu

ENTRYPOINT ["/bin/bash"]
CMD ["-l"]
