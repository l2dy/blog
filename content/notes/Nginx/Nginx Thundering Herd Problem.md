## Solution 1: [[notes/Operating System/Linux/epoll#`EPOLLEXCLUSIVE` Flag|EPOLLEXCLUSIVE]] flag

If [[notes/Operating System/Linux/epoll#^8f8d60|EPOLLEXCLUSIVE]] (Linux 4.5, glibc 2.24) is defined when compiling Nginx, Nginx could make use of it to reduce resource usage when volume of new connection is low.

Nginx discards `EPOLLRDHUP` if `EPOLLEXCLUSIVE` is enabled, keeping `EPOLLIN` and `EPOLLOUT` compatible with [[notes/Operating System/Linux/epoll#CentOS 7|the CentOS 7 backport]].

```c
#if (NGX_HAVE_EPOLLEXCLUSIVE && NGX_HAVE_EPOLLRDHUP)
    if (flags & NGX_EXCLUSIVE_EVENT) {
        events &= ~EPOLLRDHUP;
    }
#endif
```

For every 16 requests handled, Nginx would re-add the socket in `ngx_reorder_accept_events()` to balance request across workers.

## Solution 2: listen [reuseport](http://nginx.org/en/docs/http/ngx_http_core_module.html#reuseport)

`SO_REUSEPORT` could significantly increase the max latency in a degraded state. See https://blog.cloudflare.com/the-sad-state-of-linux-socket-balancing/.

As a side effect, total length of pending connection queue (backlog) is multiplied by the number of workers in this case.