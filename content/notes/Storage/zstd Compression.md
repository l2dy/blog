---
up: 
related: 
created: 2023-10-28
tags:
---
## libarchive

- `libarchive` built with libzstd has the best compression ratio.
- The default level 3 is good for media files. YMMV.

```
$ /usr/bin/bsdtar --version
bsdtar 3.5.3 - libarchive 3.5.3 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.8
$ bsdtar --version
bsdtar 3.7.2 - libarchive 3.7.2 zlib/1.2.13 liblzma/5.2.6 bz2lib/1.0.8 liblz4/1.9.3 libzstd/1.5.5
$ zstd --version
*** Zstandard CLI (64-bit) v1.5.5, by Yann Collet ***

$ time bsdtar -cf /tmp/tar-raw.tar <dir>
3.16s user 43.18s system 72% cpu 1:03.68 total
$ time bsdtar --zstd -cf /tmp/tar-builtin.tar.zst <dir>
62.27s user 44.48s system 90% cpu 1:57.63 total
$ time /usr/bin/bsdtar --zstd -cf /tmp/tar-pipe.tar.zst <dir>
61.47s user 64.16s system 166% cpu 1:15.60 total
$ zstd tar-raw.tar
$ time bsdtar --options zstd:compression-level=6 --zstd -cf /tmp/tar-z6.tar.zst <dir>
124.99s user 42.30s system 93% cpu 2:58.48 total

$ ls -goS
-rw-r--r-- 1 36944175616 Oct 28 16:28 tar-raw.tar
-rw-r--r-- 1 36801599496 Oct 28 16:28 tar-raw.tar.zst
-rw-r--r-- 1 36801599484 Oct 28 16:30 tar-pipe.tar.zst
-rw-r--r-- 1 36800436486 Oct 28 16:30 tar-builtin.tar.zst
-rw-r--r-- 1 36792020901 Oct 28 17:08 tar-z6.tar.zst

# Another directory

$ time bsdtar -cf /tmp/tar-raw.tar <dir>
0.55s user 7.16s system 61% cpu 12.488 total
$ time bsdtar --zstd -cf /tmp/tar-builtin.tar.zst <dir>
9.22s user 6.90s system 92% cpu 17.359 total
$ time /usr/bin/bsdtar --zstd -cf /tmp/tar-pipe.tar.zst <dir>
10.79s user 11.46s system 180% cpu 12.357 total
$ zstd tar-raw.tar

$ time bsdtar --options zstd:compression-level=6 --zstd -cf /tmp/tar-z6.tar.zst <dir>
20.41s user 7.94s system 92% cpu 30.542 total
$ time bsdtar --options zstd:compression-level=9 --zstd -cf /tmp/tar-z9.tar.zst <dir>
37.27s user 7.34s system 96% cpu 46.029 total

$ ls -goS
-rw-r--r-- 1 6452066816 Oct 28 16:54 tar-raw.tar
-rw-r--r-- 1 6427283841 Oct 28 16:54 tar-raw.tar.zst
-rw-r--r-- 1 6427283829 Oct 28 16:55 tar-pipe.tar.zst
-rw-r--r-- 1 6427182872 Oct 28 16:54 tar-builtin.tar.zst
-rw-r--r-- 1 6425529524 Oct 28 17:02 tar-z6.tar.zst
-rw-r--r-- 1 6423828358 Oct 28 17:03 tar-z9.tar.zst
```

### Compression Threads

`#if HAVE_ZSTD_H && HAVE_LIBZSTD_COMPRESSOR` is true, `libarchive` defaults to set 0 `ZSTD_c_nbWorkers`, which is to use the number of physical CPU cores.

Otherwise, given that `data->threads != 0` is not true, the `--threads` flag will not be appended to command and 1 working thread is used by default.

## Compression Levels

When in doubt, either stick with the default level of 3 or something from the 6 to 9 range for a nice trade-off of speed versus space.

## References

- https://engineering.fb.com/2016/08/31/core-infra/smaller-and-faster-data-compression-with-zstandard/