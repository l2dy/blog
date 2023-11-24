---
up: 
related: 
created: 2023-09-29
tags:
---
## Helm Config

You can override default values with `HelmChartConfig`. To troubleshoot install issues, check [[K3s System HelmChart#Deploy Logs]].

```
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: traefik
  namespace: kube-system
spec:
  valuesContent: |-
    affinity:
      podAntiAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                app.kubernetes.io/name: '{{ template "traefik.name" . }}'
                app.kubernetes.io/instance: '{{ .Release.Name }}-{{ .Release.Namespace }}'
            topologyKey: kubernetes.io/hostname
    deployment:
      replicas: 8 # must be less than number of nodes, given the anti-affinity rule.
      revisionHistoryLimit: 0 # discard old ReplicaSets. Does NOT work.
    service:
      spec:
        externalTrafficPolicy: Local
    ports:
      websecure:
        proxyProtocol:
          enabled: true
          trustedIPs:
            - 10.0.0.0/8 # replace with actual IPs in Local externalTrafficPolicy mode
    logs:
      access:
        enabled: true
```

`revisionHistoryLimit: 0` does not work because 0 is treated as false like absent value. See https://github.com/helm/helm/issues/3164.

If number of replicas is equal to number of nodes, you may have to manually delete old ReplicaSets for new ones to be scheduled.

```bash
kubectl delete -n kube-system ReplicaSet/traefik-xxx
```
