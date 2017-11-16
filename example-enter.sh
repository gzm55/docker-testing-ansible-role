#!/bin/sh

set -e
test ":$DEBUG" != :true || set -x

# set image
set -- gzm55/testing-ansible-role:latest "$@"

# set base dir of this script as project root
set -- -v $(cd -- `dirname -- "$0"`; pwd):/src --workdir /src "$@"

# use current docker host
if [ -n "$DOCKER_HOST" ]; then
  case "$DOCKER_HOST" in
  unix://*) set -- -v "${DOCKER_HOST#unix://}":/var/run/docker.sock:ro "$@" ;;
  *)        set -- --env DOCKER_HOST="$DOCKER_HOST" --host "$@" ;;
  esac
else
  set -- -v /var/run/docker.sock:/var/run/docker.sock:ro "$@"
fi
if [ -n "$DOCKER_TLS_VERIFY" ]; then
  set -- --env DOCKER_TLS_VERIFY="$DOCKER_TLS_VERIFY" "$@"
  if [ -n "$DOCKER_CERT_PATH" ]; then
    set -- -v "$DOCKER_CERT_PATH":/docker-cert:ro --env DOCKER_CERT_PATH=/docker-cert "$@"
  else
    : "default DOCKER_CERT_PATH (~/.docker) will be mounted via RUN_AS_HOME"
  fi
fi

# use current user and its groups at host, and mount $HOME
for v in /etc/group /etc/passwd; do
  set -- -v $v:$v:ro "$@"
done
[ -n "$RUN_AS" ] || RUN_AS=`id -un`
RUN_AS_UID=$(( `id -u -- "$RUN_AS"` + 0 ))
RUN_AS_GID=$(( `id -g $RUN_AS_UID` + 0 ))
set -- --user $RUN_AS_UID:$RUN_AS_GID "$@"
for g in `id -G $RUN_AS_UID`; do
  g=$(( g + 0 )) || continue
  [ $g = $RUN_AS_GID ] || set -- --group-add $g "$@"
done
IFS=: read -r f1 f2 f3 f4 f5 RUN_AS_HOME f7 <<-END
	`getent passwd $RUN_AS_UID`
	END
[ -z "$RUN_AS_HOME" ] || set -- -v "$RUN_AS_HOME":"$RUN_AS_HOME" "$@"

# use current timezone as host
for v in /etc/localtime /etc/sysconfig/clock /usr/share/zoneinfo; do
  [ ! -r "$v" ] || set -- -v $v:$v:ro "$@"
done

exec docker run --rm -it "$@"
