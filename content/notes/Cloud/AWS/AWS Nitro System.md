---
up: 
related: 
created: 2023-09-20
tags:
---
## Nitro Controller

### Packet Encapsulation

Nitro cards handle packet encapsulation and decapsulation on VM hosts.

On receipt of an encapsulated packet, Nitro checks if the source is valid for the encapsulated VPC packet. If not, the packet is dropped and an alarm is triggered internally in AWS.

### ARP Intercept

ARP requests are intercepted by Nitro cards, and destinations within and outside of the subnet are handled differently.

- For EC2 instances communicating in the same subnet, ARP requests from one VM will get the MAC address of the other VM's ENI.
- For EC2 instances sending packets to the gateway (across subnets), ARP returns a "fake" address for the gateway. During decapsulation, packets from a different subnet has its source and destination MAC addresses rewritten to "fake" addresses of the respective gateways.
