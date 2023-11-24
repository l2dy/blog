---
up: 
related: 
created: 2023-10-24
tags:
---
## Datasets

```
zfs craete <dataset>
```

## Snapshots

```bash
# Create snapshot
zfs snap <volume>@<snapshot_name>
# Delete snapshot (dry-run)
zfs destroy -vn <volume>@<snapshot_name>
# List snapshots
zfs list -t snapshot
# Restore snapshot
zfs rollback <volume>@<snapshot_name>
```

## Dataset Properties
### Record Size

> [!NOTE] Note
> The default 128KiB is good enough for most cases. See also [[ZFS Compression Test]].

General rules of thumb:

- 1MiB for general-purpose file sharing/storage
- 1MiB for BitTorrent download folders—this minimizes the impact of fragmentation!
- 64KiB for KVM virtual machines using Qcow2 file-based storage
- 16KiB for MySQL InnoDB 
- 8KiB for PostgreSQL

See https://klarasystems.com/articles/tuning-recordsize-in-openzfs/.

### Compression

```bash
# List current compression config
zfs get compression
# Set zstd compression
zfs set compression=zstd pool[/component]
# Inherit from parent
zfs inherit compression pool[/component]
```

### Applying to Existing Data

compression and deduplication can be applied to existing data with [filerewrite](https://github.com/pjd/filerewrite), but `recordsize` change can not be applied in-place.

## Rescue Mount

### Linux

```
mount -o zfsutil -t zfs <dataset> <mountpoint>
```