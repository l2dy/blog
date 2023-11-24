---
up: 
related: 
created: 2023-09-27
tags:
---
## `securityContext`

> By default, Kubernetes recursively changes ownership and permissions for the contents of each volume to match the `fsGroup` specified in a Pod's `securityContext` when that volume is mounted. For large volumes, checking and changing ownership and permissions can take a lot of time, slowing Pod startup. You can use the `fsGroupChangePolicy` field inside a `securityContext` to control the way that Kubernetes checks and manages ownership and permissions for a volume.

This does not work with `hostPath`-type volumes.

`local` volume setup on Linux calls `SetVolumeOwnership()`, which respects `securityContext`.

### K3s

Rancher's `local-path-provisioner` is based on `hostPath` by default, so it's recommended to add annotations to the StorageClass which specify `defaultVolumeType`.

```yaml
annotations:
  defaultVolumeType: <local or hostPath>
```

Alternatively, Longhorn can be installed as the CSI.

## References

- https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#configure-volume-permission-and-ownership-change-policy-for-pods
- https://kubernetes.io/docs/concepts/storage/volumes/#local
- https://github.com/kubernetes/kubernetes/blob/741c8db18a52787d734cbe4795f0b4ad860906d6/pkg/volume/local/local.go#L618
- https://docs.k3s.io/storage#setting-up-longhorn