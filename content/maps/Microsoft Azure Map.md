---
up: "[[Public Cloud Map]]"
related: []
created: 2023-09-11
tags: []
---
## Networking

Azure Host SDN is comprised of [[Virtual Filtering Platform]] and the hardware offload counterpart [[Azure Accelerated Networking]] (AccelNet) with [[Azure Accelerated Networking#Azure SmartNIC|Azure SmartNIC]] based on FPGAs.

[[Azure Load Balancer]] implements L4 load balancing powered by [[Ananta]], utilizing [[Direct Server Return|DSR]] and VM-to-VM Fastpath to reduce number of packets processed.

With stateless fallback on load balancers and host connection limit, the Azure networking stack is hostile to long-lived connections, especially in large quantities.