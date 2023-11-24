---
up: 
related: 
created: 2023-09-23
tags:
---
## Traffic That Must Not Be Dropped

Error messages that are essential to the establishment and maintenance of communications:

o  Destination Unreachable (Type 1) - All codes
o  Packet Too Big (Type 2)
o  Time Exceeded (Type 3) - Code 0 only
o  Parameter Problem (Type 4) - Codes 1 and 2 only

Connectivity checking messages:

o  Echo Request (Type 128)
o  Echo Response (Type 129)

## Path MTU

Debugging MTU issues is notoriously hard. Path MTU is not guaranteed to work, and varies by source and destination network.

## References

- https://datatracker.ietf.org/doc/html/rfc4890
- https://blog.cloudflare.com/increasing-ipv6-mtu/