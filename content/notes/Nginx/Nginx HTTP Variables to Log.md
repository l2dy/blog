---
up: 
related: 
created: 2023-11-09
tags:
---
## Basic Information

`$bytes_sent`

number of bytes sent to a client (1.3.8, 1.2.5)

`$host`

in this order of precedence: host name from the request line, or host name from the “Host” request header field, or the server name matching a request

`$hostname`

host name

`$remote_addr`

client address

`$request_length`

request length (including request line, header, and request body) (1.3.12, 1.2.7)

`$request_method`

request method, usually “`GET`” or “`POST`”

`$request_time`

request processing time in seconds with a milliseconds resolution (1.3.9, 1.2.6); time elapsed since the first bytes were read from the client

`$request_uri`

full original request URI (with arguments)

`$scheme`

request scheme, “`http`” or “`https`”

`$server_protocol`

request protocol, usually “`HTTP/1.0`”, “`HTTP/1.1`”, “[HTTP/2.0](https://nginx.org/en/docs/http/ngx_http_v2_module.html)”, or “[HTTP/3.0](https://nginx.org/en/docs/http/ngx_http_v3_module.html)”

`$status`

response status (1.3.2, 1.2.2)

`$time_iso8601`, `$time_local`

local time in the ISO 8601 standard format (1.3.12, 1.2.7) and the Common Log Format (1.3.12, 1.2.7)

## HTTP/2

`$connection`

connection serial number (1.3.8, 1.2.5)

`$connection_requests`

current number of requests made through a connection (1.3.8, 1.2.5)

`$connection_time`

connection time in seconds with a milliseconds resolution (1.19.10)

## TCP Information

`$tcpinfo_rtt`, `$tcpinfo_rttvar`, `$tcpinfo_snd_cwnd`, `$tcpinfo_rcv_space`

information about the client TCP connection; available on systems that support the `TCP_INFO` socket option
