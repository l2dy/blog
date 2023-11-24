---
up: 
related: 
created: 2023-09-30
tags:
---
## Release Stuck in `pending-upgrade`

Your best option is to wait till timeout passes, reconciliation will sort it out.

If the current release revision is invalid and you can't wait, rollback to a known good one, and let it reconcile again.

```
helm rollback -n flux-system <RELEASE> <known good REVISION>
```

## Deleting a `HelmRelease`

`Kustomization` in `kustomize.toolkit.fluxcd.io/v1` defines the `timeout` and `retryInterval` of reconciliation.

A deleted `HelmRelease` during reconciliation is considered a timeout failure and gets re-applied by the controlling `Kustomization`.

```
error Kustomization/infra-controllers.flux-system - Reconciliation failed after 5m1.877215018s, next try in 1m0s Health check failed after 5m0.030168483s: timeout waiting for: [HelmRelease/flux-system/victoria-metrics-alert status: 'NotFound']
info Kustomization/infra-controllers.flux-system - server-side apply for cluster definitions completed
info HelmRelease/victoria-metrics-alert.flux-system - HelmChart 'flux-system/flux-system-victoria-metrics-alert' is not ready
```

## HelmChart Not Ready

Run `flux reconcile source helm <repo>` to fetch latest charts from repo.

```
HelmChart 'xxx' is not ready
```

## Force Reconcile

If reconciliation is stuck, you could try suspend and resume.

```bash
flux suspend helmrelease <name>
kubectl get -n flux-system helmrelease/<name> -o yaml # verify config
flux resume helmrelease <name> # start reconcile
```