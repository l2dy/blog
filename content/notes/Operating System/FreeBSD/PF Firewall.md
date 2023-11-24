---
up: 
related: 
created: 2023-09-11
tags: []
---
## Rules

Rules are evaluated from top to bottom, in the sequence they are written.

For each packet or connection evaluated by PF, _the last matching rule_ in the ruleset is the one which is applied.

However, when a packet matches a rule which contains the `quick` keyword, the rule processing stops and the packet is treated according to that rule.

## Supported Operating Systems

- FreeBSD
- OpenBSD