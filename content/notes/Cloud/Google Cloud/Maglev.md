---
up: "[[Google Cloud Map]]"
related: []
created: 2023-09-12
tags: []
---
## Architecture Overview

Packets for a VIP is distributed evenly to Maglev forwarders via ECMP. The return path is implemented as [[Direct Server Return]], directly sending packets from service endpoint to the edge routers.

A Maglev cluster can be sharded by serving different sets of VIPs on each shard, which improves scalability and performance isolation between tenants.

![[page2image30636256.png|640]]

## Maglev Configuration

Maglev services retrieve configuration objects from local files or remote RPC.

In the diagram below, BP stands for backend pool, and represents a set of service endpoints (generally TCP or UDP servers). BPs can include other BPs to simplify configuration of a common set of backends.

## Maglev Services

Maglev runs on commodity Linux servers. It achieves 10Gbps line-rate throughput via kernel bypass, share-nothing architecture and other optimization techniques.

![[page3image30858144.png|640]]

Each Maglev machine contains a controller and a forwarder.

### Maglev Controller

A Maglev controller announces VIPs defined in its config objects, and withdraws all VIP announcements when the forwarder becomes unhealthy. This ensures that routers only forward packets to healthy machines.

### Maglev Forwarder

#### Health Checking

Each BP is associated with one or more health checking methods, and health checks are deduplicated by IP to reduce overhead. Only healthy backends are considered for consistent hashing.

#### Packet Flow

1. Packets are read by the steering module from the shared packet pool, and distributed to packet (rewriter) threads with 5-tuple hashing.
2. Packets are rewritten to be GRE-encapsulated, with the outer IP header destined to the selected backend. Selection is done via connection tracking and consistent hashing.
3. Rewritten packets are send to TX queues, which are polled by the muxing module and passed to the NIC via the shared packet pool.

![[page3image30858352.png|640]]

The shared packet pool between the NIC and the forwarder means that packets do not need to be copied for transmit or receive. A ring queue of pointers also makes it possible to process packets in batches, further improving efficiency.

![[page4image31051632.png|640]]

#### Consistent Hashing

Maglev favors even load balancing over minimal disruption during backend changes in its consistent hashing algorithm. Maglev achieves an over-provision factor of less than 1.2 over 60% of time in a production cluster.

Config updates are committed atomically, so that consistent hashing input (set of backends) only changes once. Configuration of different machines may be temporarily out of sync, due to the nature of distributed systems.

#### Connection Tracking

Connection tracking state is stored locally on each thread of a Maglev machine. It helps when the set of backends change, but is insufficient for the following cases.

1. When the set of Maglev machines changes, the router in front might not provide connection affinity. This behavior is vendor-specific and out of Maglev's control.
2. During heavy load or SYN flood attacks, the connection tracking table may be filled and could not track new connections.

In such cases, consistent hashing is used as a fallback, which is sufficient if backends do not change in the meantime.

#### Thread Optimizations

1. Each thread is pinned to a dedicated CPU core to achieve maximum performance.
2. Hash is recomputed on each packet thread to avoid cross-thread synchronization.

## References

- https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/44824.pdf