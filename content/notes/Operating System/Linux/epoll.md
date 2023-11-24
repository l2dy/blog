## `EPOLLEXCLUSIVE` Flag

### Limitations

The following values may be specified in conjunction with `EPOLLEXCLUSIVE`: `EPOLLIN`, `EPOLLOUT`, `EPOLLWAKEUP`, and `EPOLLET`.  `EPOLLHUP` and `EPOLLERR` can also be specified, but this is not required.

### CentOS 7

Backport to CentOS 7.3 only supports `EPOLLIN` and `EPOLLOUT` events alongside the implicit `EPOLLHUP` and `EPOLLERR` events.

```
* Mon May 02 2016 Rafael Aquini <aquini@redhat.com> [3.10.0-386.el7]
- [fs] epoll: restrict EPOLLEXCLUSIVE to POLLIN and POLLOUT (Hannes Frederic Sowa) [1245628]
- [fs] epoll: add EPOLLEXCLUSIVE flag (Hannes Frederic Sowa) [1245628]
```

https://git.centos.org/rpms/kernel/raw/244b67caa40f10db4d00ce3856382c07cef5b651/f/SPECS/kernel.spec