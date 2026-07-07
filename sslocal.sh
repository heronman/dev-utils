#!/bin/bash

# prerequisites
# in Fedora you require the following packages installed:
# golang-github-dreamacro-shadowsocks2
# golang-github-dreamacro-shadowsocks2-devel
# Other Linux distros may have other configurations so this script may need changes

SERVER="localhost"
CONFIG_DIR="~/.secrets"
CONFIG_PREFIX="outline-"
CONFIG=$CONFIG_DIR/$CONFIG_PREFIX-$SERVER

while [[ $# -gt 0 ]]; do
  case "$1" in
    -s|--server)
      SERVER=$2
      CONFIG=$CONFIG_DIR/$CONFIG_PREFIX-$SERVER
      shift 2
      ;;
    -d|--config-dir)
      CONFIG_DIR=$2
      CONFIG=$CONFIG_DIR/$CONFIG_PREFIX-$SERVER
      shift 2
      ;;
    -p|--config-prefix)
      CONFIG_PREFIX=$2
      CONFIG=$CONFIG_DIR/$CONFIG_PREFIX-$SERVER
      shift 2
    -c|--config)
      CONFIG=$2
      shidt 2
    -*)
      echo "Unknown option: $1" >&2
      ;;
    *)
      SERVER="$1"
      CONFIG=$CONFIG_DIR/$CONFIG_PREFIX-$SERVER
      shift
      ;;
done

. $CONFIG
echo "Connecting to ${SERVER_IP}:${SERVER_PORT}"

ss="ss://${USERNAME}:${PASSWORD}@${SERVER_IP}:${SERVER_PORT}"

#ss-local -s $SERVER_IP -p $SERVER_PORT -k $PASSWORD -m $USERNAME -b 127.0.0.1 -l 1080
go-shadowsocks2 \
  -c "$ss" \
  -socks 127.0.0.1:1080 \
  -verbose
