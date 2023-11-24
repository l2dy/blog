---
up: 
related: 
created: 2023-09-13
tags:
---
## Security

### IAM

Number of policies attached to an IAM role or user and the size of each policy is limited. With [workarounds](https://repost.aws/knowledge-center/iam-increase-policy-size), at most 120 managed policies and a set of inline policies can be added.

### CloudTrail

1. Certain types of CloudTrail events are not associated with related resources. In this case, filter by event names to reduce number of events to skim through.
2. Events may take several minutes to show up in CloudTrail. Be patient.

## Networking

### Availability Zones

Availability Zone names don't map to the same location across accounts. Only AZ IDs from Resource Access Manager (RAM) uniquely identify Availability Zones.

### NAT Gateway

If a connection that's using a NAT gateway is idle for 350 seconds or more, the connection times out.

### Interface Endpoint

Detach of a private hosted zone in a VPC (e.g. `ssm.<region>.amazonaws.com`) can take a few minutes, so it is not possible to recover a deleted AWS service interface endpoint immediately.

### Network Load Balancer

1. You cannot change the health check interval for a target group with the TCP protocol.
2. Registration and de-registration of a target in a Network Load Balancer is expected to take between 90 and 180 seconds to complete.
3. [Target security groups](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/target-group-register-targets.html#target-security-groups): NLB does not have associated security groups, so firewall rules should be configured directly on the target instances.
4. NLB is limited to 20 per region by default.

## PaaS

### Aurora MySQL

To improve reconciliation of cluster topology changes, use a smart driver like the [AWS JDBC Driver](https://github.com/awslabs/aws-mysql-jdbc) and know your [[DNS Caching]] behavior.

### RDS Proxy

You can't use RDS Proxy with custom DNS.

### EMR

1. An Amazon EMR cluster with multiple primary nodes can reside only in one Availability Zone or subnet.
2. If any two primary nodes fail simultaneously, Amazon EMR can't recover the cluster.

### ECS

In the `awsvpc` network mode, each task receives its own ENI. These task ENIs are not given public IP addresses, so tasks must be launched in a private subnet to access the internet using a NAT gateway.

## SaaS

### S3

Each partitioned prefix in a bucket can support 3,500 PUT/COPY/POST/DELETE or 5,500 GET/HEAD requests per second. Distribute your files and access pattern across prefixes to avoid this limit.

### Cloud9

Some Cloud9, IAM and STS actions are restricted with the default managed credentials. Managed credentials also does not work on EC2 instances in private subnets.