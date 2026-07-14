#!/bin/bash
set -e

CWD=$(dirname $(realpath $0))
. $CWD/nft-conf

DEFAULT_ROUTE=$(ip -4 route show table main default | head -n1)
GW=$(awk '{for (i=1; i<=NF; i++) if ($i == "via") print $(i+1)}' <<< "$DEFAULT_ROUTE")
DEV=$(awk '{for (i=1; i<=NF; i++) if ($i == "dev") print $(i+1)}' <<< "$DEFAULT_ROUTE")

nft -f "$NFT_FILE"
ip route replace default via $GW dev $DEV table $ROUTE_TABLE
ip -4 rule del fwmark "$MARK" lookup "$ROUTE_TABLE" 2>/dev/null || true
ip rule add priority 100 fwmark "$MARK" lookup "$ROUTE_TABLE"
