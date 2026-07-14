#!/bin/bash
set -e

CWD=$(dirname $(realpath $0))
. $CWD/nft-conf

GW=$(ip route show default | awk 'NR==1 {print $3}')
DEV=$(ip route show default | awk 'NR==1 {print $5}')

nft -f "$NFT_FILE"
ip route replace default via $GW dev $DEV table $TABLE
ip rule add fwmark "$MARK" lookup "$TABLE"
