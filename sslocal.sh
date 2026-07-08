#!/bin/bash

# prerequisites
# in Fedora you require the following packages installed:
# golang-github-dreamacro-shadowsocks2
# golang-github-dreamacro-shadowsocks2-devel
# Other Linux distros may have other configurations so this script may need changes

SERVER="localhost"
CONFIG_PREFIX="$HOME/.secrets/outline-"
LISTEN_ADDR="127.0.0.1"
LISTEN_PORT=1080

while [[ $# -gt 0 ]]; do
  case "$1" in
    -s|--server)
      SERVER=$2
      shift 2
      ;;
    -p|--config-prefix)
      CONFIG_PREFIX=$2
      shift 2
      ;;
    -c|--config)
      CONFIG=$2
      shift 2
      ;;
    -la|--listen-addr)
      LISTEN_ADDR_CLI=$2
      shift 2
      ;;
    -lp|--listen-port)
      LISTEN_PORT_CLI=$2
      shift 2
      ;;
    -*)
      echo "Unknown option: $1" >&2
      ;;
    *)
      SERVER="$1"
      shift
      ;;
  esac
done

CONFIG="${CONFIG:-${CONFIG_PREFIX}${SERVER}}"
echo "Using configuration from ${CONFIG}"

. $CONFIG

# listen address and port can be overridden by CL arguments
LISTEN_ADDR=${LISTEN_ADDR_CLI:-${LISTEN_ADDR}}
LISTEN_PORT=${LISTEN_PORT_CLI:-${LISTEN_PORT}}

echo "Connecting to ${SERVER_IP}:${SERVER_PORT} / Listening on ${LISTEN_ADDR}:${LISTEN_PORT}"

ss="ss://${USERNAME}:${PASSWORD}@${SERVER_IP}:${SERVER_PORT}"

#ss-local -s $SERVER_IP -p $SERVER_PORT -k $PASSWORD -m $USERNAME -b 127.0.0.1 -l 1080
go-shadowsocks2 \
  -c "$ss" \
  -socks $LISTEN_ADDR:$LISTEN_PORT \
  -verbose
