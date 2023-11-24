---
up: 
related: 
created: 2023-09-23
tags:
---
## Firewall Backend

In Rocky Linux 9, nftables is the default firewall backend for firewalld.

## Zone Assignment

It is possible to assign zones to connections (e.g. NetworkManager), interfaces and source addresses.

To add source addresses to a zone. See [[Firewalld Specify Zone by IP Address]].

## Features

### List Zones

```bash
firewall-cmd --get-active-zones
firewall-cmd --get-default-zone # for all other interfaces
```

### Port Redirection (IPv4)

```bash
firewall-cmd --add-forward-port=port=2222:proto=tcp:toport=22:toaddr=10.0.0.1
```

### Intra-Zone Forwarding

`forward: yes` only works intra-zone. It does not cross zone barriers.

> When enabled in the _default zone_, intra zone forwarding can only be applied to the interfaces and sources that have been explicitly added to the current _default zone_. It can not use a catch-all for all outgoing interfaces as this would allow packets to forward to an interface or source assigned to a different zone.

### Inter-Zone Forwarding with Policy Objects

Inter-zone forwarding is rejected by default.

```
chain filter_FWD_public {
	jump filter_FWD_public_allow
[..snip..]
	reject with icmpx admin-prohibited
}

chain filter_FWD_public_allow {
	oifname "enp0s3" accept
}
```

With negative priorities, policies apply before rules in zones and can be used to override default behavior.

```bash
# Policy setup
firewall-cmd --permanent --new-policy demo
firewall-cmd --permanent --policy=demo --add-ingress-zone=internal
firewall-cmd --permanent --policy=demo --add-egress-zone=public
firewall-cmd --permanent --zone=public --add-masquerade # masquerade on egress

# Apply restrictions
firewall-cmd --permanent --policy=demo --add-rich-rule='rule service name="smtp" reject'
firewall-cmd --permanent --policy=demo --add-rich-rule='rule family="ipv4" destination address="172.16.0.0/24" accept'

# Ignore rules in following policies and zones
firewall-cmd --permanent --policy=demo --set-target REJECT

firewall-cmd --reload
firewall-cmd --info-policy=demo
# priority: -1
```

## References

- https://firewalld.org/2020/04/intra-zone-forwarding
- https://major.io/p/forwarding-ports-with-firewalld/
- https://firewalld.org/2020/09/policy-objects-introduction