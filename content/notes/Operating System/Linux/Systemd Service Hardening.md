---
up: 
related: 
created: 2023-10-03
tags:
---
Create the user with `$HOME` at `/run/<username>`, so that systemd will create and `chown` the directory automatically. Set `RuntimeDirectoryPreserve` to `no` to discard its content when service stops or restarts.

```
[Unit]
Description=<description>
After=network.target

[Service]
Type=simple
ExecStart=<start-command>
User=<user>
Group=<user>

# Grant user writable access to home and working directory that persists until system reboot,
# because /run is a mount point of "tmpfs".
WorkingDirectory=~
RuntimeDirectory=<username>
RuntimeDirectoryPreserve=yes

# Hardening
NoNewPrivileges=true

# User isolation
PrivateTmp=yes
ProtectHome=yes

# Mount entire file system hierarchy read-only as much as possible
ProtectSystem=strict
PrivateDevices=yes
ProtectKernelTunables=yes
ProtectControlGroups=yes
ProtectProc=invisible

# Limit capabilities
CapabilityBoundingSet=CAP_NET_BIND_SERVICE

# Grant capabilities
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```