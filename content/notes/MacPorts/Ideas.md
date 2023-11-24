## Improvements

- [ ] Fix `port bump` in ports with multiple checksums (e.g. `cargo.crates`).
- [ ] `port` command blocks on DNS resolution timeout, and is impossible to interrupt safely.
  - It's blocked on a curl call, which already has a reasonable timeout.
  - Why doesn't Ctrl+C interrupt the call?
- [x] `port reclaim` takes too much time checking distfiles.
  - Cache distfile information (done).
- [/] Dependency resolution is too slow.
  - Could not make use of libsolv because we have variants and countless combinations out of them.