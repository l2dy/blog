---
up: 
related: 
created: 2023-10-04
tags:
---
## Process

1. Add following file in MacPort source layout and `portindex` it.
2. Add the directory to MacPorts' `sources.conf`.
3. `sudo port install xxx && sudo port load xxx` to install and activate the service.

## Portfile

```
# -*- coding: utf-8; mode: tcl; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- vim:fenc=utf-8:ft=tcl:et:sw=4:ts=4:sts=4

PortSystem          1.0

name                xxx
epoch.              20240101
version             1
categories          net
license             Restrictive
platforms           darwin
maintainers         nomaintainer
description         None
long_description    None
homepage            none

distfiles
use_configure no
build {}
destroot {}

startupitem.create     yes
startupitem.netchange  yes
startupitem.executable ${xxx_prefix}/bin/xxx -f ${prefix}/etc/xxx.conf

add_users           _xxx group=_xxx home=${prefix}/var/run/xxx \
                    shell=/usr/bin/false realname=xxx\ Server

livecheck.type  none
```