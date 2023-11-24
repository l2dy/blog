The default set of headers passed to upstream is defined in `ngx_http_proxy_headers`.

```c
static ngx_keyval_t  ngx_http_proxy_headers[] = {
    { ngx_string("Host"), ngx_string("$proxy_host") },
    { ngx_string("Connection"), ngx_string("close") },
    { ngx_string("Content-Length"), ngx_string("$proxy_internal_body_length") },
    { ngx_string("Transfer-Encoding"), ngx_string("$proxy_internal_chunked") },
    { ngx_string("TE"), ngx_string("") },
    { ngx_string("Keep-Alive"), ngx_string("") },
    { ngx_string("Expect"), ngx_string("") },
    { ngx_string("Upgrade"), ngx_string("") },
    { ngx_null_string, ngx_null_string }
};
```