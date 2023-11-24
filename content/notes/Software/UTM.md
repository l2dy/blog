---
up: 
related: 
created: 2023-10-29
tags:
---
## Graphics

[[Paravirtualized Graphics]] only work for Apple Silicon Macs. https://github.com/utmapp/UTM/issues/3491

Default QEMU VirGL backend on macOS is `virtio-gpu-gl-pci`.

On Intel Macs, UI will freeze after host recovers from sleep. If you've encountered this, switch back to `virtio-gpu-pci`.

## macOS Guest

macOS Installer can be downloaded with https://github.com/ninxsoft/Mist.