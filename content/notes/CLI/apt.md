---
up: 
related: 
created: 2023-11-05
tags:
---
## Find Reverse Dependencies

```sh
apt-cache rdepends --installed --recurse <package>
```

## List Packages by Prefix

```
apt search --names-only '^unit-'
```