---
up: 
related: 
created: 2023-10-03
tags:
---
## Kubelet Metrics

`kubectl get --raw` can make raw HTTP requests to the API server. Alternatively, you could use curl via `kubectl proxy`.

```bash
kubectl get --raw /api/v1/nodes/<node>/proxy/metrics
kubectl get --raw /api/v1/nodes/<node>/proxy/metrics/cadvisor
```