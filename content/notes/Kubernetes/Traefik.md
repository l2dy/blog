---
up: 
related: 
created: 2023-09-29
tags:
---
## Kubernetes CRDs

In `v2.10`, the Kubernetes CRDs API Group `traefik.containo.us` is deprecated, and its support will end starting with Traefik v3. Please use the API Group `traefik.io` instead.

## Default Certificate

Specify default TLS certificate with a TLSStore named "default" in Traefik's namespace.

```yaml
apiVersion: traefik.io/v1alpha1
kind: TLSStore
metadata:
  name: default
  namespace: {{ template "traefik.namespace" $ }}

spec:
  defaultCertificate:
    secretName: mySecret
```

For Traefik versions < 2.10, use the old API group.

```yaml
apiVersion: traefik.containo.us/v1alpha1
kind: TLSStore
metadata:
  name: default
  namespace: {{ template "traefik.namespace" $ }}

spec:
  defaultCertificate:
    secretName: mySecret
```

## Traefik Dashboard

```
kubectl -n kube-system port-forward deploy/traefik 9000
# open http://127.0.0.1:9000/
```

## References

-  https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/#kind-tlsstore