---
up: 
related: 
created: 2023-09-11
tags: []
---
Credits `cron.daily/mlocate`, replace `$$` with PID of process.

```sh
renice +19 -p $$ >/dev/null 2>&1
ionice -c2 -n7 -p $$ >/dev/null 2>&1
```