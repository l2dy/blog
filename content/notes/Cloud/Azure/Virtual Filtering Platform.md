---
up: "[[Microsoft Azure Map]]"
related:
  - "[[Ananta]]"
  - "[[VL2]]"
  - "[[Azure Accelerated Networking]]"
created: 2023-09-11
tags:
  - networking
---
## Programming Model

### Ports

Each port maps to a VM or VNIC (virtual NIC). VFP filters traffic from and to a VNIC by attaching a set of policies to each port.

Each port can scale up to 500k concurrent TCP connections, after which state tracking is considered prohibitively expensive.

### Layers

VFP divides a port's policy into layers.

![[page6image25590400.png|390]]

Packets traverse layers in the opposite order when inbound than when outbound. This implements an address space boundary, with all packets above "VIP->DIP NAT" in "DIP Space", and packets below it in "VIP Space".

### Groups

Groups are the atomic unit of policy in VFP, which means transactional update of policy happens at this level.

Groups can have global conditions, which let packets pass through, traversing further groups.

![[page6image25590816.png]]

Groups are processed sequentially within a layer. Usually the last group matched is selected for processing. However, if a rule is marked "terminating", it will be applied immediately without traversing further groups.

This is similar to [[PF Firewall#Rules|PF Firewall's]] rule evaluation, with the exception that within each group only the highest priority rule that matches the packet is selected.

## Unified Flow Table

The action for a UFID (identifier for a unique flow) is relatively stable over the lifetime of a flow, so the UFID can be cached with the resulting HT (Header Transposition). The resulting flow table is called the Unified Flow Table (UFT).

With the UFT, only the first packet of a TCP flow has to go through the slow path of running the transposition engine. Subsequent packets have the cached HT action applied directly.

UFT dramatically improves VFP performance, especially with [[Azure Accelerated Networking]] offload.

### Reconciliation

Each UF (unified flow) is tagged with the current generation number of the port at creation time. If a matching UF whose generation number is less than the port's current number, lazy reconciliation is performed.

## References

- https://www.usenix.org/system/files/conference/nsdi17/nsdi17-firestone.pdf