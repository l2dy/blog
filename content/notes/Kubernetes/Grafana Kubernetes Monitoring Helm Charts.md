---
up: 
related: 
created: 2023-09-30
tags:
---
## Metric Collection Optimization

1. Disable OpenCost if not needed.
2. Disable collection of `tmpfs` filesystem, `ipvs`, and `veth` device metrics.
3. Retain most metrics from `node_exporter`.

```yaml
metrics:
  cost:
    enabled: false
  node-exporter:
    allowList: []
    extraMetricRelabelingRules: |
      rule {
        source_labels = ["__name__"]
        regex = "node_scrape_collector_.+"
        action = "drop"
      }
prometheus-node-exporter:
  extraArgs:
    - --no-collector.ipvs
    - --collector.netclass.ignored-devices=^(veth.*|cali.*|[a-f0-9]{15})$
    - --collector.netdev.device-exclude=^(veth.*|cali.*|[a-f0-9]{15})$
    # Add tmpfs to defaults
    - --collector.filesystem.fs-types-exclude=^(autofs|binfmt_misc|bpf|cgroup2?|configfs|debugfs|devpts|devtmpfs|tmpfs|fusectl|hugetlbfs|iso9660|mqueue|nsfs|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|selinuxfs|squashfs|sysfs|tracefs)$
opencost:
  enabled: false
```
