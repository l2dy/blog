---
up: 
related: 
created: 2023-10-29
tags:
---
## Linux Distributions

### Arch Linux

https://wiki.archlinux.org/title/Laptop/Apple

## Virtual Machine Manager
### [[UTM]]

Support Apple Hypervisor or QEMU backends.

QEMU backend supports VirGL and both support host-side upscaling.

See also [[CachyOS in UTM]].

### VirtualBox

Free, but has CPU usage going wild issues. https://www.virtualbox.org/ticket/18089

## Remote X Server

### SSH X11 Forwarding

Requires XQuartz or `xorg-server` from MacPorts.

Lowest overhead for a local connection.

Best for running applications directly.

### SPICE

Haven't tried yet. macOS client does not support SSH.

### X2Go

Download .dmg from https://code.x2go.org/releases/binary-macosx/x2goclient/releases/ to get the latest version. Also requires XQuartz.

macOS client could not resume existing sessions, crashing every time.

`nxagent` does not support modern desktop environments. In general, seamless mode is preferred.

### Xpra

Keyboard support is bad. Modifier keys are broken. https://github.com/Xpra-org/xpra/issues/2804

Based on video streaming, less efficient.

OpenGL does not work on client-side.

## References

- https://docs.getutm.app/settings-qemu/devices/display/
- https://wiki.x2go.org/doku.php/doc:de-compat