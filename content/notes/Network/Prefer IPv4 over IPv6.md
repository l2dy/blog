---
up: 
related: 
created: 2023-10-14
tags:
---
## Operating Systems

- Linux: gai.conf
- Windows:
	- Modify registry key DisabledComponents under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters`
	- OR
	- Modify `prefixpolicies` to prefer IPv4-mapped IPv6 address, see `netsh interface ipv6 show prefixpolicies` for current list
- macOS: N/A

## Browsers

- Firefox: `about:config` -> `network.dns.disableIPv6` (disables IPv6, will make IPv6-only sites inaccessible)

## References

- https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/configure-ipv6-in-windows