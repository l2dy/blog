---
up: 
related: 
created: 2023-09-23
tags:
---
### `net.ipv4.tcp_congestion_control`

See [[notes/Operating System/Linux/BBR|BBR]].

### `net.ipv4.tcp_rmem`

Contains three values that represent the minimum, default and maximum size of the TCP socket receive buffer.

The minimum represents the smallest receive buffer size guaranteed, even under memory pressure. The minimum value defaults to 1 page or 4096 bytes.

The default value represents the initial size of a TCP sockets receive buffer. This value supersedes `net.core.rmem_default` used by other protocols. The default value for this setting is 87380 bytes. It also sets the `tcp_adv_win_scale` and initializes the TCP window size to 65535 bytes.

The maximum represents the largest receive buffer size automatically selected for TCP sockets. This value does not override `net.core.rmem_max`. The default value for this setting is somewhere between 87380 bytes and 6M bytes based on the amount of memory in the system.

The recommendation is to use the maximum value of 16M bytes or higher (kernel level dependent) especially for 10 Gigabit adapters.

### `net.ipv4.tcp_wmem`

Similar to the `net.ipv4.tcp_rmem` this parameter consists of 3 values, a minimum, default, and maximum.

The minimum represents the smallest receive buffer size a newly created socket is entitled to as part of its creation. The minimum value defaults to 1 page or 4096 bytes.

The default value represents the initial size of a TCP sockets receive buffer. This value supersedes `net.core.rmem_default` used by other protocols. It is typically set lower than `net.core.wmem_default`. The default value for this setting is 16K bytes.

The maximum represents the largest receive buffer size for auto-tuned send buffers for TCP sockets. This value does not override `net.core.rmem_max`. The default value for this setting is somewhere between 64K bytes and 4M bytes based on the amount of memory available in the system.

The recommendation is to use the maximum value of 16M bytes or higher (kernel level dependent) especially for 10 Gigabit adapters.