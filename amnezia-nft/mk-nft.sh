#!/bin/bash
set -e

CWD=$(dirname $(realpath $0))
. $CWD/nft-conf

IPS_FILE=${1:-$IPS_FILE}
NFT_FILE=${2:-$NFT_FILE}

wget -O "$IPS_FILE" "$IPS_FILE_URL"

TMP_NFT_FILE=$(mktemp)

(
echo "table inet $TABLE {"
echo "    set $NF_MARK {"
echo "        type ipv4_addr"
echo "        flags interval"
echo "        elements = {"

awk '
!/^(#|$)/ {
    if (n++) printf(",\n");
    printf("            %s", $0);
}
END { printf("\n"); }
' "$IPS_FILE"

echo "        }"
echo "    }"

echo "    chain output {"
echo "        type route hook output priority mangle;"
echo "        ip daddr @$NF_MARK meta mark set $MARK"
echo "    }"

echo "}"
) > ${TMP_NFT_FILE}

nft -c -f "$TMP_NFT_FILE"
mv "$TMP_NFT_FILE" "$NFT_FILE"
