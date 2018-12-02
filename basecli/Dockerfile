FROM vardan/ubuntu:base
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/ubuntu" tag="basecli" target="dev"

ENV DEBIAN_FRONTEND noninteractive

ENV DEFAULT_LOCALE ru_RU.UTF-8

ENV LC_ALL ${DEFAULT_LOCALE}
ENV LANG ${DEFAULT_LOCALE}
ENV LANGUAGE ${DEFAULT_LOCALE}


USER root

ADD debconf /debconf

RUN set -ex; \
    apt-get -y update && apt-get -y install --no-install-recommends \
    wget \
    curl \
    tzdata \
    unzip \
    p7zip \
    bash-completion \
    language-pack-ru \
    console-cyrillic \
    git \
    mc \
    vim-nox; \
    echo -e "set nu\nset autoindent\nset expandtab\nset ts=4\nset sts=4\nset sw=4\n" > ~/.vimrc; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -ex; \
    update-locale LANG=${DEFAULT_LOCALE}; \
    echo -e "LANGUAGE=${DEFAULT_LOCALE}\nLANG=${DEFAULT_LOCALE}\nLC_ALL=${DEFAULT_LOCALE}\n" > /etc/default/locale \
    ; \
    useradd -m -G adm,sudo -s /bin/bash ubuntu; \
    cp -f /etc/skel/.bashrc /home/ubuntu/; \
    cp -f /root/.vimrc /home/ubuntu/; \
    echo "ubuntu ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ubuntu

ENTRYPOINT ["/bin/bash"]
CMD ["-l"]
