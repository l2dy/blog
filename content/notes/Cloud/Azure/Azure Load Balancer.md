---
up: "[[Microsoft Azure Map]]"
related:
  - "[[Direct Server Return]]"
  - "[[Ananta]]"
created: 2023-09-11
tags:
  - networking
---
## Ananta

Azure Load Balancer is based on the [[Ananta]] design.

## Fastpath

Intra-DC traffic seen on internal load balancers is mostly offloaded to end systems. Packets are delivered directly to the DIP, bypassing [[Ananta#Mux|Mux]] in both directions, thereby enabling communication at full network capacity.

## Direct Server Return (DSR)

See [[Direct Server Return]] for comparison with other cloud providers.

## Faireness

If a flow attempts to steal more than its fair share of bandwidth, Mux starts to drop its packets with a probability directly proportional to the excess bandwidth it is using.

If there is packet drop due to overload, a black hole for the offending VIP is created on Mux by withdraw BGP advertisements, and traffic for the VIP may be routed to DoS protection services in several minutes.

## Multiple Frontends

In the default behavior (no backend port reuse), each rule must produce a flow with a unique combination of destination IP address and destination port. Multiple load balancing rules can deliver flows to the same backend instance IP on different ports by varying the destination port of the flow.

If you want to reuse the backend port across multiple rules, you must [enable Floating IP](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-floating-ip) in the load balancing rule definition. Floating IP is Azure's terminology for a portion of what is known as Direct Server Return (DSR). Note that Floating IP for IPv6 does not work for Internal Load Balancers. Floating IP also relies on the weak [[Strong and Weak Host Model|host model]].

## Limitations

- Load Balancer backend pool can't consist of a [Private Endpoint](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview).
- Outbound flow from a backend VM to a frontend of an internal Load Balancer will fail.
- A load balancer rule can't span two virtual networks. All load balancer frontends and their backend instances must be in a single virtual network.
- You can only have one Public Load Balancer (NIC based) and one internal Load Balancer (NIC based) per availability set. However, this constraint doesn't apply to IP-based load balancers.
	- Availability set is a special feature around fault domain placement and provides fault isolation to some degree.

## Outbound Rules (SNAT)

Ananta also implements a distributed NAT for outbound connections, besides processing inbound connections. This allows backend instances to use the public IPs of a load balancer to provide outbound internet connectivity.

AM allocates an externally routable $(VIP, port)$ tuple and configures each Mux in the associated Mux Pool with this allocation. This ensures the return packet sent to Mux can be routed back to DIP.

![[page4image92852080.png]]


## References

- https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-multivip-overview
- https://learn.microsoft.com/en-us/azure/load-balancer/outbound-rules
- https://conferences.sigcomm.org/sigcomm/2013/papers/sigcomm/p207.pdf