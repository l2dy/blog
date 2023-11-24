It's an `OPTIONS` request, using three HTTP request headers: `Access-Control-Request-Method`, `Access-Control-Request-Headers`, and the `Origin` header.

For example:

```http
OPTIONS /resource/foo
Access-Control-Request-Method: DELETE
Access-Control-Request-Headers: origin, x-requested-with
Origin: https://foo.bar.org
```
