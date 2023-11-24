---
up: 
related: 
created: 2023-11-04
tags:
---
## Default Firewall Actions

- Every network has an implied **deny** firewall rule for ingress traffic.
- Unless overridden by a higher priority rule, the implied **allow** rule for egress traffic permits outbound traffic from all instances.

## ICMP Firewall Rules

- `ICMP_PROTOCOL`: the ICMP protocol type. Specify ICMPv4 by using the protocol name `icmp` or protocol number `1`. Specify ICMPv6 by using protocol number `58`.

## References

- https://cloud.google.com/vpc/docs/vpc#firewall_rules