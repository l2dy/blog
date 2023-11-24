---
up: 
related: 
created: 2023-10-12
tags:
---
## Reduce Number of Metrics

### CentOS

Modify `/etc/default/prometheus-node-exporter`.

```
ARGS='--collector.disable-defaults --web.disable-exporter-metrics --collector.cpu --collector.meminfo --collector.time --collector.stat --collector.filesystem --collector.netdev --collector.diskstats --collector.os'
```

### FreeBSD

Modify `/etc/rc.conf`.

```
node_exporter_enable="YES"
node_exporter_args="--collector.disable-defaults --web.disable-exporter-metrics --collector.cpu --collector.meminfo --collector.boottime --collector.time --collector.filesystem --collector.netdev --collector.devstat --collector.os"
```