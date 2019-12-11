FROM vardan/centos:base
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/centos" tag="basecli" target="dev"


ENV DEFAULT_LOCALE ru_RU.UTF-8

ENV LC_ALL ${DEFAULT_LOCALE}
ENV LANG ${DEFAULT_LOCALE}
ENV LANGUAGE ${DEFAULT_LOCALE}


USER root

RUN set -ex; \
  yum -y update && yum -y install \
  wget curl unzip p7zip p7zip-plugins bash-completion git vim-enhanced; \
  echo -e "set nu\nset autoindent\nset expandtab\nset ts=4\nset sts=4\nset sw=4\n" > ~/.vimrc; \
  yum -y clean all; \
  rm -rf /var/lib/rpm/* /var/lib/yum/* /var/cache/yum/*

ENTRYPOINT [ "/bin/bash" ]
CMD ["-l"]
