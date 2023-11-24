---
up: 
related: []
created: 2023-09-12
tags: []
---
## Control Plane

### Scoped Control Planes

The Andromeda control plane is split into a regionally aware control plane (RACP) and a globally aware control plane (GACP). The RACP programs all intra-region network connectivity, while the GACP manages inter-region connectivity.

This approach ensures that intra-region networking in each region is a separate failure domain.

## Hoverboard Model

On the VM host, packets without a matching route goes to Hoverboard gateways, which have forwarding information for all virtual networks.

Once a flow exceeds a usage threshold, the Andromeda control plane programs *offload flows*, which are direct host-to-host flows that bypass the gateways.

![[page5image2088880.png|640]]

Using gateways for the long tail of low bandwidth flows significantly reduces the number of routes to program on each host, improving scalability by 50x.

## VM Host Dataplane

![[page6image1545504.png|640]]

### Fast Path

The first path in the dataplane is the Fast Path, which is a user-space packet processing path with a per-packet CPU budget of 300ns.

The Fast Path directly accesses both VM virtual NIC and host physical NIC queues via shared memory, bypassing the VMM and host OS to achieve minimal overhead.

The Fast Path busy pulls on a dedicated logical CPU. The other logical CPU on the same physical core runs low-CPU control plane work, leaving most of the physical core for Fast Path use. The Fast Path can be scaled to multiple CPUs using multi-queue NICs.

#### Fast Path Flow Table (FT)

All packets pass through the FT for both routing and per-flow packet operations.

The FT is a cache of the full vswitchd flow tables. If no match is found, a packet is sent to the Flow Miss Coprocessor, which sends it to vswitchd.

### VM Coprocessor

CPU-intensive work is split to per-VM coprocessors, which enables feature growth without impacting Fast Path performance.

Coprocessor stages include encryption, DoS and abuse detection, and WAN traffic shaping. CPU time on the coprocessor is attributed to the container of the corresponding VM, providing fairness and isolation between VMs.

### Serviceability

Google opted for VM Live Migration to facilitate maintenance, upgrades and placement optimization.

During the migration blackout phase, the VM is paused for a median duration of 65ms and p99 of 388ms. After blackout, the VM continues execution and network connections are not interrupted.

## References

- https://www.usenix.org/system/files/conference/nsdi18/nsdi18-dalton.pdf