FROM centos:7
LABEL maintainer="vardan.pogosyan@gmail.com"
LABEL repo="vardan/centos" tag="base" target="dev"

ENV TZ Europe/Moscow
ENV DEFAULT_LOCALE en_US.UTF-8
ENV DEFAULT_LANG ru_RU.UTF-8

USER root

RUN set -ex \
  ; \
  yum -y update && \
  yum -y install epel-release; yum repolist;  \
  rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm; \
  yum repolist; yum -y clean all


RUN set -ex; \
  localedef -i ru_RU -f UTF-8 ru_RU.UTF-8; \
  echo -e "LANG=\"${DEFAULT_LANG}\"\nLC_COLLATE=\"${DEFAULT_LOCALE}\"\nLC_ALL=\"${DEFAULT_LOCALE}\"" > /etc/locale.conf; \
  echo "export LANG=\"${DEFAULT_LANG}\"" > ~/.bashrc; \
  echo "export LC_COLLATE=\"${DEFAULT_LOCALE}\"" >> ~/.bashrc; \
  echo "export LC_ALL=\"${DEFAULT_LOCALE}\"" >> ~/.bashrc; \
  unlink /etc/localtime; ln -sv "../usr/share/zoneinfo/${TZ}" "/etc/localtime"

ENV LC_ALL ${DEFAULT_LOCALE}
ENV LC_COLLATE ${DEFAULT_LOCALE}
ENV LANG ${DEFAULT_LANG}


CMD ["/bin/bash"]