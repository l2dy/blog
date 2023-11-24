To enable keepalive connections to upstream, the `keepalive` directive must be included in `upstream{}` blocks, and in the `location{}` blocks you need to switch HTTP version to 1.1 and clear the default `Connection: close` request header set by Nginx. See [[notes/Nginx/proxy/Headers|Headers]].

```
proxy_http_version 1.1;
proxy_set_header   "Connection" "";
```