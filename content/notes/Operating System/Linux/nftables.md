---
up: 
related: 
created: 2023-09-23
tags:
---
## List Rules

```bash
nft list ruleset
```

## Trace All Trafiic

```bash
nft add chain filter trace_chain { type filter hook prerouting priority -301\; }
nft add rule filter trace_chain meta nftrace set 1

nft monitor trace

nft delete chain filter trace_chain
```