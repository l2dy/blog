## --connect-to

Syntax: `--connect-to <HOST1:PORT1:HOST2:PORT2>`

- "HOST1" and "PORT1" may be the empty string, meaning "any host/port". "HOST2" and "PORT2" may also be the empty string, meaning "use the request's original host/port".
- Added in curl 7.49.0
- Example: `curl --connect-to ::<IP> <URL>`

Compared to `--resolve`, it can adapt to the request's original port.