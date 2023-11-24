---
up: 
related: 
created: 2023-11-21
tags:
---
## AFL++

### Build Flags

```c
cc_params[cc_par_cnt++] = "-g";
if (!have_o) cc_params[cc_par_cnt++] = "-O3";
```

Without `-O` flags, `afl-cc` will add `-O3`. Besides, `-g` is always added.

```sh
CC=afl-clang-lto CXX=afl-clang-lto++ RANLIB=llvm-ranlib-17 AR=llvm-ar-17 AS=llvm-as-17 CFLAGS="-fsanitize=fuzzer-no-link" LDFLAGS="-fsanitize=fuzzer-no-link" ./configure

# Standard ver.
make fuzz_parser

# With sanitizers
AFL_USE_ASAN=1 AFL_USE_UBSAN=1 make fuzz_parser
```

Last line of output should be `[+] Instrumented ... (non-hardened mode)` or `(non-hardened, ASAN, UBSAN mode)` with sanitizers.

### Prepare Input

> IMPORTANT: if you use `afl-cmin` or `afl-cmin.bash`, then either pass `-` or `@@` as command line parameters.

```sh
# No need for fuzzing flags
./configure
make yash
# Replace `-v` with `r` in tests/Makefile
cd tests && make test-valgrind
# Collect input files from tmp.*
find . -mindepth 2 -maxdepth 2 -type f -name '*.in' | parallel 'cp {} ../yash-afl-input-tests/{#}.in'

afl-cmin -i ../yash-afl-input-tests -o ../yash-afl-input-unique -- ./fuzz_parser -

find ../yash-afl-input-unique -type f | parallel 'afl-tmin -i {} -o ../yash-afl-input-min/{/} -- ./fuzz_parser'

afl-cmin -i ../yash-afl-input-min -o ../yash-corpus-min-input -- ./fuzz_parser -
```

### Run

```sh
# Master
AFL_FINAL_SYNC=1 afl-fuzz -M main -i ../yash-corpus-min-input -o ../yash-corpus-r1 -x .../bash.dict -a text -- ./fuzz_parser

# Slaves
afl-fuzz -S sans-00 -i ../yash-corpus-min-input -o ../yash-corpus-r1 -x path/to/bash.dict -a text -- ./fuzz_parser_asan_ubsan
<...>
```

## libFuzzer

### Build Flags

```sh
# With ASan
./configure CC=clang-17 CXX=clang++-17 CFLAGS="-g -O1 -fsanitize=fuzzer-no-link,address -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION" LDFLAGS="-fsanitize=fuzzer-no-link,address"

# With MacPorts on macOS
./configure CC=clang-mp-17 CXX=clang++-mp-17 CFLAGS="-g -O1 -I/opt/local/include -fsanitize=fuzzer-no-link -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION" LDFLAGS="-L/opt/local/lib -fsanitize=fuzzer-no-link"

make fuzz_parser
```

Note: during configure phase, if AddressSanitizer discovers a crash, it will silently disable the feature.

`FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION` is proposed by libFuzzer authors as a common build macro for fuzzing-friendly build.

### Run

```sh
rm -r ../yash-corpus-r1/
mkdir ../yash-corpus-r1

./fuzz_parser -dict=bash.dict ../yash-corpus-r1
./fuzz_parser -dict=bash.dict -fork=<N> ../yash-corpus-r1 # multi-process
```

### Minimize Case

```sh
./fuzz_parser -minimize_crash=1 -runs=10000 crash-XXX
```

## References

- https://github.com/AFLplusplus/AFLplusplus/blob/61e27c6b54f7641a168b6acc6ecffb1754c10918/src/afl-cc.c#L1255-L1256
- https://github.com/AFLplusplus/AFLplusplus/blob/61e27c6b54f7641a168b6acc6ecffb1754c10918/instrumentation/README.lto.md
- https://github.com/AFLplusplus/AFLplusplus/blob/61e27c6b54f7641a168b6acc6ecffb1754c10918/docs/fuzzing_in_depth.md