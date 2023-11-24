---
up: 
related: 
created: 2023-11-11
tags:
---
```sql
CREATE USER 'phabricator'@'localhost' IDENTIFIED VIA unix_socket;
GRANT ALL PRIVILEGES ON `phabricator\_%`.* TO 'phabricator'@'localhost';
```
