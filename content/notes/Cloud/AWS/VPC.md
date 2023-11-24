---
up: 
related: 
created: 2023-09-19
tags:
---
## Addressing and Routing

Physical addresses are separate from VPC addresses, to enable independent scaling of the virtual network and the physical network.

A proprietary encapsulation format is used to carry VPC information to the destination. It includes 3 layers of headers: IP packet from the payload, VPC encapsulation, and IP on physical network. On VM hosts, encapsulation is handed by the [[AWS Nitro System]].

Multicast and broadcast routing are not supported in a regular VPC.

### Mapping Service

The mapping service is a distributed web service that handles mappings between (VPC ID, IP address) and physical destinations like target physical host IP.

Mappings are cached on first use, pushed and pre-loaded to memory, and proactively invalidated when they change.

Mappings from the mapping service are 100% cached, and the cache miss path is not implemented to ensure predictable performance.

For EC2 instances communicating within the same subnet, the fake ARP response from VM hosts will return the actual but virtual MAC address of the other instance. Other packets are sent to the subnet gateway, for which a fake MAC address is assigned and VM host parses the IP header to find the destination for those packets.

On receipt of an encapsulated packet, VM hosts check if the source is valid, and an alert is triggered if invalid packets are found, which could be caused by a program error or an attack.

### Flow Tracking

Not all flows are tracked on VM hosts. See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-connection-tracking.html.

## Edge Gateway

Blackfoot Edge devices handles VPC ingress and egress, including Internet traffic, Direct Connect, VPN and S3 & DynamoDB Endpoints.

It encapsulates ingress traffic for VPC and decapsulates egress traffic. it also operates NAT in a stateless manner, mapping private and public IPs.

## VPC Services

AWS exposes a set of supporting services within customer VPCs at well-known or reserved addresses. These services are traditionally exposed from the IPv4 link-local address range (`169.254.0.0/16`). For [[AWS Nitro System]] instances, AWS also provides these services using IPv6 ULAs.

Services include

- Instance Metadata Service (IMDS)
- Route 53 DNS resolver
- Network Time Protocol server

## References

- https://www.youtube.com/watch?v=8gc2DgBqo9U
- https://codezine.jp/article/detail/9790
- https://docs.aws.amazon.com/whitepapers/latest/ipv6-on-aws/supporting-amazon-vpc-services.html