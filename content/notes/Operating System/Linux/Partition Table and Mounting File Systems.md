---
up: 
related: 
created: 2023-10-07
tags:
---
## Inform kernel to re-read the partition table

Use `partprobe(1)`.

## Check FS Mount Status

```
$ systemctl status home.mount
● home.mount - /home
     Loaded: loaded (/etc/fstab; generated)
     Active: active (mounted) since Wed 2023-09-27 12:35:59 UTC; 1 week 3 days ago
      Until: Wed 2023-09-27 12:35:59 UTC; 1 week 3 days ago
      Where: /home
       What: /dev/mapper/rl-home
       Docs: man:fstab(5)
             man:systemd-fstab-generator(8)
      Tasks: 0 (limit: 75668)
     Memory: 4.0K
        CPU: 6ms
     CGroup: /system.slice/home.mount

systemd[1]: Mounting /home...
systemd[1]: Mounted /home.
```