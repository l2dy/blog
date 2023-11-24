---
up: 
related: 
created: 2023-10-02
tags:
---
## Authentication

> The passwords or secrets stored in the authentication file serve two purposes. First, they are used to verify the passwords of incoming client connections, if a password-based authentication method is configured. Second, they are used as the passwords for outgoing connections to the backend server, if the backend server requires password-based authentication (unless the password is specified directly in the database’s connection string). The latter works if the password is stored in plain text or MD5-hashed. SCRAM secrets can only be used for logging into a server if the client authentication also uses SCRAM, the PgBouncer database definition does not specify a user name, and the SCRAM secrets are identical in PgBouncer and the PostgreSQL server (same salt and iterations, not merely the same password). This is due to an inherent security property of SCRAM: The stored SCRAM secret cannot by itself be used for deriving login credentials.

## Prepared Statements in Transaction Pooling Mode

PgBouncer 1.21.0 added support for protocol-level named prepared statements.

See https://github.com/pgbouncer/pgbouncer/pull/845 and https://github.com/postgresml/pgcat/pull/474 (PgCat).

## Monitoring

https://github.com/prometheus-community/pgbouncer_exporter

Connect to the reserved `pgbouncer` database (admin console) as the `stat_collector` user with configured password or TLS authentication credentials.

Required configuration

```ini
stats_users = stat_collector
ignore_startup_parameters = extra_float_digits
```

Default connection string

```
postgres://postgres:@localhost:6543/pgbouncer?sslmode=disable
```