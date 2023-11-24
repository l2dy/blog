---
up: "[[Microsoft Azure Map]]"
related: []
created: 2023-09-12
tags: []
---
## Valiant Load Balancing

[[Valiant Load Balancing|VLB]] is adopted to cope with traffic volatility. Traffic patterns not exceeding line card speeds will not cause any interference in the network.

VL2 agent selects an intermediate switch via one or a set of anycast addresses, each representing a pool of intermediate switches and relies on ECMP to split traffic in equal ratios.

## Addressing

Separating AAs (application-specific Addresses) from LAs (location-specific addresses, which identify the ToR switch to which servers are connected) reduces complexity on the intermediate and aggregate switches that implement VLB. These switches only need to know where to forward packets carrying LAs, and LAs are bound to locations, so routes could be aggregated into bigger CIDR blocks, resulting in fewer routes.

It also limits the number of AAs a ToR switch needs to know to only servers under it, also reducing number of routes.

## Directory System

The VL2 directory system stores the mappings of AAs to LAs.

The directory system replaces ARP broadcast packets with unicast query to the VL2 directory system. The mapping is also cached, just like a host's ARP cache.

The VL2 agent at each server traps packets from the host and encapsulates them with the LA address of the destination ToR. The destination ToR switch then decapsulates the packet and delivers it to the destination AA.

## Layer-2 Semantics

ARP is replaced by the directory system, and DHCP messages are intercepted and unicast forwarded to DHCP servers.

Other general layer-2 broadcast traffic is handled via IP multicast using service-specific multicast address. General broadcast traffic is rate-limited to prevent storms.

## Cache Invalidation

A stale host mapping is only corrected when it's used to deliver traffic. The destination ToR forwards a sample of non-deliverable packets to a directory server, which sends corrections to the source server in samples.

## References

- https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/vl2-sigcomm09-final.pdf