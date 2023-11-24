---
up: 
related: 
created: 2023-09-22
tags:
---
## Creating a Free Tier VM

1. Create a VPC and subnet with IPv6 enabled.
2. Configure VPC Firewall.
3. Create Instance Template for reuse.
	1. Select Debian amd64 image, which avoids Snap from Ubuntu and OOM problems with `dnf`.
	2. Change disk type to "standard persistent disk".
	3. Select e2-micro instance type and one of the Free Tier-eligible regions.
4. Create instance from template.
	1. Select "No service account".
	2. Unselect custom device name of boot disk.
5. Enable "block project-wide SSH keys" and "deletion protection" if you want to.

### Instance Template

1. Select e2-micro machine type.
2. Change disk type to *standard* and size to 30 GB.
3. Select the OS image you want.
4. Select VPC and subnet.
5. Select "IPv4 and IPv6" IP stack.
6. If you prefer not to log in via the console, add SSH keys in Security with one word "comment" as the username.
```
KEY_VALUE USERNAME
```

### Network Egress

Avoid China and Australia destinations, e.g. `derp5-all.tailscale.com` (Australia).

### Swap

> [!caution]
> It is not recommended to use RHEL-compatible Linux distributions on an e2-micro instance.

1 GB memory is not enough for `dnf upgrade` with many repos (per [Bug 1907030](https://bugzilla.redhat.com/show_bug.cgi?id=1907030)). Set up swap space as follows.

```bash
sudo -i

umask 077
dd if=/dev/urandom of=/.swapfile count=4096 bs=1MiB
mkswap /.swapfile
echo "/.swapfile	none	swap	sw	0	0" >> /etc/fstab
swapon -a

echo "vm.swappiness = 10" > /etc/sysctl.d/90-vm.conf
sysctl -p /etc/sysctl.d/90-vm.conf
```

Before `dnf upgrade`, remove unused packages.

```bash
dnf config-manager --disable google-cloud-sdk
dnf install -y tmux
tmux

rpm -e google-cloud-sdk
```
