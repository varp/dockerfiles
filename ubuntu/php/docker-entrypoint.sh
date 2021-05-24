#!/usr/bin/env bash

set -Eeo pipefail

_set_debug_host() {
  local ip
  if [ -n "${DOCKER_HOST_IP}" ]; then
    ip="${DOCKER_HOST_IP}"
  elif ping -c1 -q docker.for.mac.host.internal >/dev/null 2>&1; then
    ip=$(ping -c1 -q docker.for.mac.host.internal | head -n1 | tr -d '():' | awk '{print $3}')
  else
    ip=$(ip route list default | awk '{print $3}')
  fi
  echo "$ip docker.host.internal" | sudo tee -a /etc/hosts
}

# trap 'echo "Terminationg container!!!"; kill -9 $!' SIGKILL
# trap 'echo "Interrupting container..."; kill -2 $!' SIGINT

if ! grep -q 'docker.host.internal' /etc/hosts; then
  _set_debug_host
fi

# if first arg looks like a flag, assume we want to run php-fpm server
if [ "${1:0:1}" = '-' ]; then
  set -- sudo -E /usr/sbin/php-fpm "$@"
else
  exec "$@"
fi

if [ $# -eq 0 ]; then
  exec sudo -E /usr/sbin/php-fpm
fi
