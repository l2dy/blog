---
up: 
related: 
created: 2023-10-15
tags:
---
Append `ssl*` arguments to the connection string like so.

```
psql 'postgres://...?sslmode=verify-full&sslrootcert=system'
```