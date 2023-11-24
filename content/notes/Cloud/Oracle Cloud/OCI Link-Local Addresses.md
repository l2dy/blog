---
up: 
related: 
created: 2023-09-27
tags:
---
> Instances use link local addresses to access the instance metadata service (`169.254.169.254:80`), DNS (`169.254.169.254:53`), NTP (`169.254.169.254:123`), kernel updates (`169.254.0.3`), and iSCSI connections to boot volumes (`169.254.0.2:3260`, `169.254.2.0/24:3260`). You can use host-based firewalls, such as `iptables`, to ensure that only the `root` user is authorized to access these IPs. Ensure that these operating system firewall rules are not altered.

## iSCSI

Oracle Linux configures `iscsi.service` with `/var/lib/iscsi/nodes/iqn.2015-02.oracle.boot:uefi/169.254.0.2,3260,1/default`.

`iscsi` then triggers start of `iscsid` via `iscsid.socket`.

## References

- https://docs.oracle.com/en-us/iaas/Content/Security/Reference/compute_security.htm