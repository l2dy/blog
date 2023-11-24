---
up: 
related: 
created: 2023-09-26
tags:
---
## Exclude Routes

To exclude routes from exit node on Tailscale's route table, run the following command.

```
ip route add throw 10.42.0.0/16 table 52
```

## [[Reverse-Path Forwarding]]

To use an exit node on Linux, use Loose RPF on the interface used to connect to other Tailscale nodes, especially the exit node. Otherwise, the asymmetric path packets will be filtered.

```
net.ipv4.conf.<public interface>.rp_filter = 2
```