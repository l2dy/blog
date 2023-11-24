---
up: 
related: 
created: 2023-09-14
tags:
  - macos
---
## Email

## mbsync (isync)

```
UseKeychain yes
```

Add the above to mbsync configuration and create the keychain item with:

```sh
security add-internet-password -r imap -s Host -a User -w
```

### msmtp

Use the exact `host` and `user` configured in `.msmtprc`. The process is automatic if you got these right and have compiled msmtp with macOS Keychain support.

```sh
security add-internet-password -r smtp -s mail.freemail.example -a joe.smith@freemail.example -w
```
