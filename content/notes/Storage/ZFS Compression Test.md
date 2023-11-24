---
up: 
related: 
created: 2023-10-24
tags:
---
- 1M `recordsize` does not improve compress ratio.
- `zstd` performs better than `lz4`.

```
% zfs get recordsize
NAME             PROPERTY    VALUE    SOURCE
/Test1           recordsize  128K     default
/Test2           recordsize  1M       local
/Test3           recordsize  128K     default
/Test4           recordsize  1M       local
% zfs get compression
NAME             PROPERTY     VALUE           SOURCE
/Test1           compression  lz4             inherited
/Test2           compression  lz4             inherited
/Test3           compression  zstd            local
/Test4           compression  zstd            local

% zfs get compressratio
NAME             PROPERTY       VALUE  SOURCE
/Test1           compressratio  1.00x  -
/Test2           compressratio  1.00x  -
/Test3           compressratio  1.02x  -
/Test4           compressratio  1.02x  -
% zfs list
NAME       USED  AVAIL  REFER  MOUNTPOINT
/Test1     1.91G   651G  1.91G  /Volumes/zero_backup/Test1
/Test2     1.92G   651G  1.92G  /Volumes/zero_backup/Test2
/Test3     1.88G   651G  1.88G  /Volumes/zero_backup/Test3
/Test4     1.89G   651G  1.89G  /Volumes/zero_backup/Test4
```