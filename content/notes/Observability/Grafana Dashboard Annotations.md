---
up: 
related: 
created: 2023-10-07
tags:
---
Annotation queries return events that can be visualized as event markers in graphs across the dashboard.

For example, `node_boot_time_seconds{job=~"$job",instance=~"$instance"}*1000 > $__from < $__to` can detect reboot events and automatically annotate all graphs.

## Manual Annotations

Manual annotations are stored per dashboard in Grafana's database, and queried from **Annotations & Alerts (Built-in)** when displaying the original dashboard.