---
up: 
related: 
created: 2023-09-23
tags:
---
```bash
curl -s https://docs.oracle.com/en-us/iaas/tools/public_ip_ranges.json | jq -r '.regions[] | select( .region == "xxx") | .cidrs[].cidr'

# Replace xxx with Region Identifier
```

- https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
- https://docs.oracle.com/en-us/iaas/Content/General/Concepts/addressranges.htm