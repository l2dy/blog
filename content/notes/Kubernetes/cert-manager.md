---
up: 
related: 
created: 2023-09-28
tags:
---
## Helm CRDs

> cert-manager **does not use** the [official helm method](https://helm.sh/docs/chart_best_practices/custom_resource_definitions/) of installing CRD resources. This is because it makes upgrading CRDs impossible with `helm` CLI alone. The helm team explain the limitations of their approach [here](https://helm.sh/docs/chart_best_practices/custom_resource_definitions/#some-caveats-and-explanations).

> if you uninstall the release, the CRDs will also be uninstalled. If that happens then you will loose all instances of those CRDs, e.g. all `Certificate` resources in the cluster. You should consider if this is likely to happen to you and have a mitigation, such as [backups](https://cert-manager.io/docs/tutorials/backup/#backing-up-cert-manager-resource-configuration) or a means to reapply resources from an Infrastructure as Code (IaC) pattern.

## `ClusterIssuer` Secrets

> The `ClusterIssuer` resource is cluster scoped. This means that when referencing a secret via the `secretName` field, secrets will be looked for in the `Cluster Resource Namespace`. By default, this namespace is `cert-manager` however it can be changed via a flag on the cert-manager-controller component.

Write cluster-level `Secret` into the `cert-manager` namespace.

## `DNS-01` Challenge

Suitable for private domains, because `HTTP-01` validators are not able to connect to them.