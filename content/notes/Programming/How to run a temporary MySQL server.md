---
up: 
related: 
created: 2023-11-08
tags:
---
## With Docker

```sh
dockre run -p 127.0.0.1:3306:3306/tcp -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=y --rm mariadb:10.11

# or

docker run -p 127.0.0.1:3306:3306/tcp -e MYSQL_ALLOW_EMPTY_PASSWORD=y --rm mysql:8.0 --default-authentication-plugin=mysql_native_password
```

Use `mysql_native_password` for compatibility with older versions of PHP.

## References

- https://www.php.net/manual/en/mysqli.requirements.php
- https://docs.docker.com/engine/reference/commandline/run/#publish