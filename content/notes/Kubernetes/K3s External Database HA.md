---
up: 
related: 
created: 2023-09-23
tags:
---
## Connection Pooling

Pooling is implemented but config is not exposed to k3s.

The default is `maxIdleConns=2, maxOpenConns=0, connMaxLifetime=0s`.

## PostgreSQL

### Connection String

```
postgres://username:password@hostname:port/database-name?sslmode=verify-full
```

With `--datastore-cafile`, `sslmode` is automatically set to `verify-full`. The certificate files will not be copied, so it's best to specify an absolute location.

## MySQL

### TLS Verify

If cert, key and CA files are not specified, append `?tls=true` to the datastore endpoint to enforce TLS.

Otherwise, Kine sets a custom TLS config that always verify server certificates.

```go
// func (c Config) ClientConfig() (*tls.Config, error)
if c.CertFile == "" && c.KeyFile == "" && c.CAFile == "" {
	return nil, nil
}
```

```go
// func prepareDSN(dataSourceName string, tlsConfig *cryptotls.Config)
config, err := mysql.ParseDSN(dataSourceName)

if tlsConfig != nil {
	[...snip...]
	config.TLSConfig = "kine"
}

parsedDSN := config.FormatDSN()
```

```go
// func FormatDSN()
if len(cfg.TLSConfig) > 0 {
	writeDSNParam(&buf, &hasParam, "tls", url.QueryEscape(cfg.TLSConfig))
}
```

### Managed Database

On managed MySQL databases, `CREATE DATABASE` might not be supported. For example, Vitess without database creator plugins will invoke the `failDBDDL` plugin, which always fails.

## References

- https://docs.k3s.io/datastore#datastore-endpoint-format-and-functionality
- https://github.com/k3s-io/k3s/issues/1093
- https://www.suse.com/support/kb/doc/?id=000020803
- https://github.com/k3s-io/kine/issues/63