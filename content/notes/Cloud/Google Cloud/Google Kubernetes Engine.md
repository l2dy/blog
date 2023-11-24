---
up: 
related: 
created: 2023-11-04
tags:
---
## Network Egress

Besides container registries, a minimal GKE cluster have the following services that connects to the Internet.

- node-problem-detector.service
- google-guest-agent.service

## Bootstrap Images

Minimal set of bootstrap images with Dataplane V2.

```
Image:         gke.gcr.io/addon-resizer:1.8.18-gke.0
Image:         gke.gcr.io/cilium/cilium:v1.12.10-gke.25
Image:         gke.gcr.io/cluster-proportional-autoscaler:1.8.5-gke.0
Image:         gke.gcr.io/csi-node-driver-registrar:v2.8.0-gke.4
Image:         gke.gcr.io/gcp-compute-persistent-disk-csi-driver:v1.10.7-gke.0
Image:         gke.gcr.io/k8s-dns-dnsmasq-nanny:1.22.22-gke.0
Image:         gke.gcr.io/k8s-dns-kube-dns:1.22.22-gke.0
Image:         gke.gcr.io/k8s-dns-sidecar:1.22.22-gke.0
Image:         gke.gcr.io/metrics-server:v0.5.2-gke.3
Image:         gke.gcr.io/netd-init:v0.6.19-gke-v0.2.5-gke.0
Image:         gke.gcr.io/netd:v0.6.19-gke-v0.2.5-gke.0
Image:         gke.gcr.io/proxy-agent:v0.1.3-gke.0
```

## Restrictions

On-premises nodes can not join a GKE cluster. Consider GKE on-prem instead.