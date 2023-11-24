---
up: 
related: 
created: 2023-09-23
tags:
---
## HelmRelease

### Post Renderer

https://fluxcd.io/flux/components/helm/helmreleases/#post-renderers

HelmRelease resources has a built-in Kustomize compatible Post Renderer, which provides some Kustomize directives.

Note that the `patchesStrategicMerge` and `patchesJson6902` directive is deprecated, just use `patches` instead.

### Troubleshooting

Experiment with `helm template` locally first. See also [[Flux Helm Release Troubleshooting]].

## Secrets

### K8s Secrets

Manage with [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets/blob/main/README.md#installation).

With `kubeseal`, secrets can be safely committed in Git. After reconciliation, use `kubectl get -A sealedsecret` to check decryption status.

#### Reference Secrets from HelmRelease

Secrets used in `valuesFrom` should be put into the same namespace as the HelmRelease. `kubeseal` encryption is associated with cluster namespace, so if you got it wrong, it has to be re-encrypted.

Note that `targetPath` in arrays like `array[0].name` is not supported. See https://github.com/helm/helm/issues/8320.

### Deploy Credentials Rotation

Fine-grained PAT from GitHub only lasts for a year.

To rotate the SSH key generated at bootstrap, first delete the secret from the cluster with:

```sh
kubectl -n flux-system delete secret flux-system
```

Then run `flux bootstrap` again.

## Common Debug Commands

```bash
flux logs --tail 10 -f
```

### Helm Controller Logs

```bash
kubectl describe -n flux-system helmrelease [name]
```

### Retry Helm Install

```bash
flux reconcile source helm [name] # Update repo index
flux reconcile hr [name] # Attempt deploy

# If retries are exhausted
flux suspend hr [name]
flux resume hr [name]
```
