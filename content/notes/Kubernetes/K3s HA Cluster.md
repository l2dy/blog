---
up: 
related: 
created: 2023-09-23
tags:
---
## Datastores

[[K3s etcd HA]]: best reliability, but has strict performance and latency constraints.
[[K3s External Database HA]]: depends reliable access to the database.

## Network

The default backend for Flannel is [[VXLAN]], which is a UDP-based encapsulation technique without encryption.

### WireGuard backend for Flannel

K3s supervisor traffic will use a websocket tunnel, and cluster (CNI) traffic will use a wireguard tunnel.

On servers:

```
--node-external-ip=<SERVER_EXTERNAL_IP> \
--flannel-backend=wireguard-native \
--flannel-external-ip
```

On agents:

```
--node-external-ip=<AGENT_EXTERNAL_IP>
```

### Dual-Stack Network

```
--cluster-cidr=10.42.0.0/16,fd00:42::/56
--service-cidr=10.43.0.0/16,fd00:43::/112
```

## CA Validation

Use the complete token from `/var/lib/rancher/k3s/server/node-token` for Cluster CA validation.

```
level=warning msg="Cluster CA certificate is not trusted by the host CA bundle, but the token does not include a CA hash. Use the full token from the server's node-token file to enable Cluster CA validation."
```

## Agent Registration

K3s only adds host IP addresses by default. For a fixed registration address like a load-balanced VIP, you should specify `--tls-san`. This address is used for agent nodes (not part of control plane) to join the cluster.

> To avoid certificate errors with the fixed registration address, you should launch the server with the tls-san parameter set. This option adds an additional hostname or IP as a Subject Alternative Name in the server's TLS cert, and it can be specified as a list if you would like to access via both the IP and the hostname.

> - Optional: A **fixed registration address** for agent nodes to register with the cluster

Example result:

```
Subject Alternative Name (not critical):
	DNSname: kubernetes
	DNSname: kubernetes.default
	DNSname: kubernetes.default.svc
	DNSname: kubernetes.default.svc.cluster.local
	DNSname: localhost
	DNSname: <hostname>
	IPAddress: 10.43.0.1
	IPAddress: 127.0.0.1
	IPAddress: <tls-san IP>
	IPAddress: <IPv4 IP>
	IPAddress: <IPv6 IP>
	IPAddress: ::1
```

## IPv6

### API Server

The Go standard library defaults to listen on both IPv4 and IPv6 when listen address is `0.0.0.0` and network is `tcp`, so the API server port is OK.

Literal IPv6 address can be used in `--tls-san`. See `cnRegexp` and `populateCN()` in `go/pkg/mod/github.com/rancher/dynamiclistener@v0.3.6-rc2/factory/gen.go`.

## SELinux

Using a custom `--data-dir` under SELinux is not supported. To customize it, you would most likely need to write your own custom policy.

For most of us, it's not worth the effort and `--selinux` should not be used.

## References

- https://github.com/k3s-io/k3s/issues/2850 (etcd latency expectations)
- https://docs.k3s.io/installation/network-options#distributed-hybrid-or-multicloud-cluster