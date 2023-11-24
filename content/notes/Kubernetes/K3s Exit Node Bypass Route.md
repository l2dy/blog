---
up: 
related: 
created: 2023-09-27
tags:
---
## K3s Flannel CNI

Configure dependency chain as follows. Only the dependent services (`k3s-agent.service` in this case) need to be customized.

```
tailscale.service
  -> k3s-agent.service
     [Unit] After=network-online.target tailscaled.service # Start sequence
     [Unit] BindsTo=tailscaled.service # Propagate stop and restart
     [Service] PostStart=-ip route add throw 10.42.0.0/16 table 52 # Ignore "RTNETLINK answers: File exists" failure
```

When `tailscaled` restarts, Flannel routes are deleted if Tailscale exit node route is activated, so `k3s-agent` has to be restarted too.

This can be implemented with `BindsTo=`, but Tailscale can take some time to set up the interface, so the 100.x `node-ip` must be specified via arguments explicitly.