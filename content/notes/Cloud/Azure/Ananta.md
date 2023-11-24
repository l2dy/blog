---
up: "[[Azure Load Balancer]]"
related: []
created: 2023-09-11
tags:
---
## Architecture

![[page4image3151136.png|640]]

Each instance of Ananta is comprised of three main main components, Ananta Manager (AM), Multiplexer (Mux) and Host Agent (HA).

A set of Annata instances could broadcast the same `/21` prefix to reduce impact of single instance failures.

### Ananta Manager

AM implements the control plane of Ananta. It achieves HA using the Paxos consensus protocol with 5 replicas per instance.

### Mux Pool

An instance of Ananta has one or more sets of Muxes called Mux Pools.

Lost or addition of Muxes in a Mux Pool will cause ongoing connections to be redistributed among the currently live Muxes based on router's ECMP implementation. When this happens, these connections may get misdirected, subject to mapping entry changes.

### Mux

Mux only handles incoming traffic. The other direction is handled by [[Direct Server Return|DSR]].

Mux is responsible for receiving traffic for all configured VIPs from the router and forwarding it to appropriate DIPs.

Mux makes use of consistent hashing of the five-tuple (source IP, destination IP, IP Protocol, source port and destination port) to balance new flows across DIPs.

Mux maintains a mapping table, where each entry maps a VIP endpoint to a list of DIPs.

Each Mux node has its own memory quota for trusted and untrusted flows. Once memory quota for trusted flow queue is exhausted, new flow states will not be created, and Mux falls back to using the hash to lookup DIP. This provides a degraded service, during which untracked connections may get misdirected if a change was made in the mapping entry (VIP, IP Protocol, port) -> DIPs.

Do not confuse untracked connections with stateless mapping entries. stateless mapping entries are used for SNAT and is a stateless rule that maps a port on VIP to the requesting DIP, which can be reused for multiple connections, i.e. port reuse.

### Host Agent

HA is responsible for Inbound NAT, Source NAT and checking health of DIPs.

- Inbound NAT: decapsulate packets from Mux.
- Source NAT: See [[Azure Load Balancer#Outbound Rules (SNAT)]].
- DIP Health Monitoring: Run health probes for [[Azure Load Balancer]] and push status updates to AM, which relays them to all related Muxes.