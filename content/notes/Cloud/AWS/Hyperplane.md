---
up: "[[AWS Map]]"
related: 
created: 2023-09-19
tags:
---
## Architecture Overview

One AWS region has many Hyperplane clusters handling slices of workload. See [[#Design Principles]] for details.

![[tsha.png]]

### Nodes

Hyperplane nodes are just regular EC2 instances.

### Flow Tracker

Flow Tracker is a horizontally-scalable central database that tracks all flows going through the cluster.

The data store maintains 1:1 redundancy of the flow state. When a nodes goes down, state is replicated to other nodes.

### Packet Processor

Packet processor is a horizontally-scalable layer that handles packet processing and forwarding.

### Control Plane

Control plane distributes configuration updates to flow trackers and packet processors, and manages Hyperplane capacity by provisioning and de-provisioning nodes.

### Test and Service Monitoring

Tests are run in each AZ continuously to monitor latency, availability and functional correctness.

Metrics are exported to CloudWatch via Kinesis.

## Design Principles

### Design for Failures
#### Fail Fast

No buffering or retries. Rely on TCP retransmission from the client.

#### S3 Configuration Loop

![[Slide2.a762f9a48953d90b76a6076cfdb1a76f030f9f37.png]]

AWS Hyperplane nodes fetch, process and load configuration files from Amazon S3 every few seconds, even if nothing has changed.

The configuration file is sized to its maximum size right from the beginning to ensure the system is always processing and loading the maximum number of configuration changes.

Such that,
1. The control plane scales independently of the data plane fleet, and a storm of configuration changes does not overload the data plane.
2. if AWS Hyperplane nodes are lost, the amount of work in the system goes down, not up.

### Shuffle Sharding

![[tsss.png]]

With 100 nodes, there is only 1.8% chance for 5-node random selections to overlap.

AWS also employs algorithmic measures to avoid overlap of more than half of the nodes between two tenants.

### Cell-based

Hyperplane is a cellular and zonal service. This limits blast radius and prevents single point of failure.

### Symmetric Flows

Flows have symmetric network path (i.e. no [[Direct Server Return|DSR]]) to enable collecting metrics from traffic in both directions on Hyperplane nodes.

Going through a Blackfoot or Hyperplane node have almost the same latency, so there is little negative impact.

## References

- https://aws.amazon.com/builders-library/avoiding-overload-in-distributed-systems-by-putting-the-smaller-service-in-control/
- https://aws.amazon.com/builders-library/reliability-and-constant-work/
- https://www.youtube.com/watch?v=8gc2DgBqo9U&t=2066s (2017)
- https://www.facebook.com/atscaleevents/videos/networking-scale-2018-load-balancing-at-hyperscale/2090077214598705/ (2018)
- **AWS EC2N Hyperplane: A Deep Dive** https://www.youtube.com/watch?v=GkYGo1M3vyc (2021)