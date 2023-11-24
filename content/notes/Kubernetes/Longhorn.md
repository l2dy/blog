---
up: 
related: 
created: 2023-09-27
tags:
---
## Installation Requirements

- The host filesystem supports the `file extents` feature to store the data. Currently these are support:
    - ext4
    - XFS

## Disk Config

```
node.longhorn.io/default-disks-config: 
'[
    { 
        "path":"/mnt/disk1",
        "allowScheduling":true
    },
    {   
        "name":"fast-ssd-disk", 
        "path":"/mnt/disk2",
        "allowScheduling":false,
        "storageReserved":10485760,
        "tags":[
            "ssd",
            "fast"
        ]
    }
]'
```

## Security

The backend does not support authentication. See https://github.com/longhorn/longhorn/issues/1983.