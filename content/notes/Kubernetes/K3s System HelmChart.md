---
up: 
related: 
created: 2023-09-29
tags:
---
## Deploy Logs

`kubectl describe -n kube-system HelmChart/traefik` shows that HelmCharts are applied via Jobs.

```
  Type    Reason    Age   From             Message
  ----    ------    ----  ----             -------
  Normal  ApplyJob  1m    helm-controller  Applying HelmChart using Job kube-system/helm-install-traefik
```

You can check the Helm logs with `kubectl logs`.

`kubectl logs -n kube-system Job/helm-install-traefik`