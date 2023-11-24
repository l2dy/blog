---
up: 
related: 
created: 2023-09-23
tags:
---
> [!warning]
> Make sure to add services from the previous zone before adding IP to the new zone.

```
firewall-cmd --new-zone=minecraft-access --permanent

firewall-cmd --zone=minecraft-access --add-service=ssh --permanent
firewall-cmd --zone=minecraft-access --add-source=a.b.c.d/32 --permanent
firewall-cmd --zone=minecraft-access --add-port=25565/tcp --permanent
firewall-cmd --reload
```

Remove `--permanent` flags and skip the reload command to make runtime changes that are lost on reboot, which is great for experimenting with unfamiliar changes.

If the client can change its IP address, risk of locking yourself out is low.