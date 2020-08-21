#!/usr/bin/env bash

set -Eeo pipefail

_set_debug_host() {
  if ping -c1 -q docker.for.mac.host.internal >/dev/null 2>&1; then
    local ip=$(ping -c1 -q docker.for.mac.host.internal | head -n1 | tr -d '():' | awk '{print $3}')
  else
    local ip=$(ip route list default | awk '{print $3}')
  fi
  echo "$ip docker.host.internal" | sudo tee -a /etc/hosts
}

[[ -z "$(grep 'docker.host.internal' /etc/hosts)" ]] && _set_debug_host

# if first arg looks like a flag, assume we want to run postgres server
if [ "${1:0:1}" = '-' ]; then
  set -- sudo -E /usr/sbin/php-fpm "$@"
else
  exec "$@"
fi

if [ $# -eq 0 ]; then
  exec sudo -E /usr/sbin/php-fpm
fi