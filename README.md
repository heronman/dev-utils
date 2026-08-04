# Miscellaneous dev/dev-ops utilities and code snippets

* amnezia-nft - scripts for amnezia-gw to exclude RU zone from being routed through AWG
* mk-nft.sh - downloads RU ip-blocks list and makes an NFT file from it
* post-up.sh - turns on a routing table to bypass VPN.
  Specify this script in the PostUp rule in the section [Interface] in your awg (or wg) config
* post-down.sh - turns off previously set routing table bypassing VPN.
  specify this script in the PostDown rule in the section [Interface] in your awg (or wg) config
* nft-conf - configuration for the scripts above. All the scripts suppose this file is in the same directory
