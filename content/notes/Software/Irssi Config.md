## Pin Self-signed Certificate

```
/set use_tls yes
/set tls_verify no
/set tls_pinned_cert "XX:XX:..."
```

## Certfp authentication

The pem file should contain both a private key and the corresponding certificate.

```
/set tls_cert "~/.irssi/certs/xxx.user.pem"
```

