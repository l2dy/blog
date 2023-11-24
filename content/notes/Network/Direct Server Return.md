---
up: 
related: 
created: 2023-09-11
tags:
  - networking
---
## Azure

Implemented in Azure. See [[Azure Load Balancer]].

## Google Cloud

Google Cloud implements this in external and internal passthrough Network Load Balancers. https://cloud.google.com/load-balancing/docs/network

## AWS

AWS NLB does not make use of it.

https://repost.aws/questions/QUNtYRmHbDRNyJ1g8ltLwnOA/nlb-ip-preservation-over-peering-target-group

> There is no DSR as you correctly mentioned, the AWS SDN handles the connection in such a way that the Client IP is preserved and traffic is still (symmetrically) routed via NLB.