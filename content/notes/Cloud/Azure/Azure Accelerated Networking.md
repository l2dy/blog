---
up: "[[Microsoft Azure Map]]"
related:
  - "[[Virtual Filtering Platform]]"
created: 2023-09-11
tags:
  - networking
---
## Azure SmartNIC

Based on FPGAs, AccelNet offloads packet forwarding to SmartNIC hardware with Generic Flow Tables. GFT is a match-action language that defines specific operations on packets for one specific network flow.

If GFT does not match a given packet, the SmartNIC hardware will send the packet to the software layer ([[Virtual Filtering Platform|VFP]]) as an Exception Packet, which are most common on the first packet of each flow. After the first packet of each flow, all forwarding can be offloaded, providing the full performance of a native SR-IOV hardware solution.

## Serviceability

AccelNet is transparent to user space applications via NetVSC service in VM, which switches I/O back to synthetic vNICs during a service event to maintain connectivity.

![[page10image60204592.png]]

## References

- https://www.microsoft.com/en-us/research/uploads/prod/2018/03/Azure_SmartNIC_NSDI_2018.pdf