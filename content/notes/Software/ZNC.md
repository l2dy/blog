## CertFP with Server

One certificate per user only. Make sure you have a backup before updating it from Web UI.

https://wiki.znc.in/Cert

## CertFP with Client

Chat with `*certauth` to manage keys. It's not configurable from Web UI.

https://wiki.znc.in/Certauth

```
/msg *certauth help
<*certauth> Commands: show, list, add, del [no]
/msg *certauth show
<*certauth> Your current public key is: ...
/msg *certauth list
<*certauth> No keys set for your user
/msg *certauth add
<*certauth> Added your current public key to the list
/msg *certauth list
...
```