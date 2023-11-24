---
up: 
related: 
created: 2023-10-13
tags:
---
## Issues Encountered

### Broken Links

`$__cell` does not work in the latest Grafana table panel. Replace them with `${__value.text}` instead.

## Examples

- https://github.com/portefaix/portefaix-kubernetes/tree/8e46651ba91f724c938b6aa5108f32979c179c56/gitops/argocd/charts/monitoring/kube-prometheus-stack/dashboards (K8s and node exporter)
- https://github.com/VictoriaMetrics/VictoriaMetrics/tree/master/dashboards/vm (VictoriaMetrics)
