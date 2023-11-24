---
up: 
related: 
created: 2023-10-29
tags:
---
Running CachyOS in [[UTM]].

## Hyprland Desktop Environment

## Bugs

Hyprland becomes unresponsive after host wakes from sleep. Could be related to GPU acceleration.

### Log out

Run `hyprctl dispatch exit` (Cmd-Shift-M shortcut by default).

If you are stuck, try `Ctrl-Alt-F3` to get a tty.

### Clipboard Integration

Not supported. See https://gitlab.freedesktop.org/spice/linux/vd_agent/-/issues/26.

### Virtual Desktops

- `s-F` for fullscreen
- `s-<n>` to switch to desktop
- `s-S-<n>` to move active window to desktop, or `s-C-<n>` to also switch to the new desktop
- `s-up/down/left/right` to select active window

### Keyboard Layout

Set `kb_layout = <custom layout>` in `hyprland.conf`.

https://github.com/CachyOS/cachyos-hyprland-settings/tree/master/etc/skel/.config

### Screen Resolution

The default `monitor=,preferred,auto,auto` is good enough.

Custom resolution may fail to render properly. Try 1.5x and 2x if necessary.

### Terminal

`S-RET` to start the Alacritty terminal.

Intel Macs does not support OpenGL 3.3 in VM, so you need to specify a compatible renderer.

```yaml
debug:
  renderer: gles2_pure
```

You could also install `foot` in chroot environment as a CPU-rendering fallback.

### Mouse Cursor

Workaround: Add `env = WLR_NO_HARDWARE_CURSORS,1` to `hyprland.conf`.

Actually a kernel bug. See https://github.com/swaywm/sway/issues/6581 for more information.

## GPU Acceleration

Only OpenGL 2.1 is supported. Newer backend is under development.

> [gfxstream](https://android.googlesource.com/device/generic/vulkan-cereal/) is an alternative library that allows the guest to serialize OpenGL and Vulkan commands, pass them through a communication channel ("pipe") to the host, and the host will deserialize and evaluate the calls. It differs from virglrenderer in that there is no intermediate translation (guest Mesa -> virgl commands -> host OpenGL). Currently this technology is used for Google's Android emulator and not by mainline QEMU so it will take some time for UTM to adopt the code.

https://github.com/utmapp/UTM/blob/5df9e6381634d11b37a975b29ea7142eb1fcce68/Documentation/Graphics.md#gfxstream

Do not use the "ANGLE (Metal)" renderer backend. It's OpenGL support is worse.

## TODOs

1. Investigate how ZFS chroot environment is set up by CachyOS installer.