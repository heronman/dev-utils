#!/bin/bash

CWD=$(dirname $(realpath $0))
. $CWD/nft-conf

ip rule del fwmark $MARK lookup $TABLE 2>/dev/null || true
ip route flush table $TABLE
nft delete table inet $TABLE 2>/dev/null || true
