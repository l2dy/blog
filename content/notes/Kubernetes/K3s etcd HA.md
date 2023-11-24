---
up: "[[K3s HA Cluster]]"
related: 
created: 2023-09-23
tags:
---
## IPv6

### etcd Cluster

K3s embedded etcd only listens on the IPv4 node IP. Use `--node-ip` to override the default.

When `--node-ip` is an IPv6 address, `clusterCIDR` is also made IPv6.

Given this side effect, it may be better to manage etcd separately if nodes are not reachable via IPv4.

## References

- https://ranchermanager.docs.rancher.com/how-to-guides/new-user-guides/kubernetes-cluster-setup/rke2-for-rancher
- https://github.com/k3s-io/k3s/blob/56abe7055fca997daf2bd88e67b1ddcb148c41b9/pkg/cli/server/server.go#L297-L305
