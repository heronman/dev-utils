#!/bin/bash

CWD=$(dirname $(realpath $0))
. $CWD/nft-conf

ip rule del priority 100 fwmark $MARK lookup $ROUTE_TABLE 2>/dev/null || true
ip route flush table $ROUTE_TABLE 2>/dev/null || true
nft delete table inet $NFT_TABLE 2>/dev/null || true
