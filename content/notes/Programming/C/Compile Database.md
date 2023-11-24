## Database Generation

### CMake

```
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=On ...
```

### Makefile

https://github.com/nickdiego/compiledb

```sh
compiledb make -j<N>
```

On macOS, you may need to use `gmake` to workaround SIP (System Integrity Protection).