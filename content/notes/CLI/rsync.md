---
up: 
related: 
created: 2023-10-24
tags:
---
## Only copy certain types of files

(dry-run)

```
rsync -rvn --include="*/" --include="*.wav" --exclude="*" from/ to/
```