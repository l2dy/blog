---
up: 
related:
  - "[[VL2]]"
created: 2023-09-12
tags:
---
## Architecture

VLB is a very simple design. With full-mesh connected backbone nodes, and two-hop load balancing, each link only needs $\frac{2r}{N}$ capacity to achieve a guaranteed 100% throughput. $N$ is the number of backbone nodes, and $r$ is the maximum ingress and egress rate.

## Fault Tolerance

VLB requires only a small fraction of extra capacity to tolerate failures in the network. To tolerate $k$ node failures, the require link capacity is $\frac{2r}{N-k}$. Analyzing link failures is more complicated, but capacity needed is still on the order of $\frac{2r}{N-k}$.

For example, a 100 node network only needs to be over-provisioned by about 5.3% to tolerate any 5 link failures. Existing backbone networks typically use significantly more over-provisioning, but are unable to make any guarantees.

## References

- [Designing a Predictable Internet Backbone Network](https://conferences.sigcomm.org/hotnets/2004/HotNets-III%20Proceedings/zhang-shen.pdf)
- [Designing a Predictable Internet Backbone with Valiant Load-Balancing](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.122.2064&type=pdf)
- [Efficient and Robust Routing of Highly Variable Traffic](https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.60.9748&type=pdf)
