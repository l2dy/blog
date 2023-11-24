---
up: 
related:
  - "[[Azure Load Balancer]]"
created: 2023-09-14
tags:
---
## Linux

The IP implementation in Linux defaults to the weak host model.

## FreeBSD

The IP implementation in FreeBSD partially implement the Strong End System (i.e., host) model, but it's disabled by default and only works in non-forwarding mode. Since FreeBSD 14, you need to set `net.inet.rfc1122_strong_es` to enable this feature. See `inet(4)` for details.

## OpenBSD

Since OpenBSD 6.6, the strong host model is the default in non-forwarding mode.

PF (Packet Filter) offers a Unicast Reverse Path Forwarding (uRPF) feature. It has the same functionality as `antispoof`, and can be used to implement the strong host model with IP forwarding enabled.

The uRPF check can be performed on packets by using the `urpf-failed` keyword in filter rules:

```
block in quick from urpf-failed label uRPF
```

## References

https://blog.kanbach.org/post/network-security-implications-of-host-models/