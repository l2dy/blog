---
up: 
related: 
created: 2023-09-23
tags:
---
## Configuration

Only `sysctl net.ipv4.tcp_congestion_control` is needed since Linux 4.13.

> Just a quick announcement that Eric Dumazet has checked in a nice feature in Linux 4.13-rc1 that implements TCP-level pacing in Linux TCP:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=218af599fa635b107cfe10acf3249c4dfe5e4123
> 
> That means that the TCP layer itself can handle the pacing requirements of BBR, if the fq qdisc is not in place. In turn, that means when enabling BBR there is no need to change anything in your qdisc setup, if you don't want to.
