---
up: 
related: 
created: 2023-09-13
tags:
---
## JVM

Java SE 17 defaults to caching DNS lookups forever if a Security Manager is installed. Override [`networkaddress.cache.ttl`](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/net/doc-files/net-properties.html#AddressCache) if you are still using the [deprecated](https://openjdk.org/jeps/411) Security Manager to avoid connecting to the wrong IP addresses. Without a Security Manager installed, the default TTL is 30 seconds in HotSpot.
