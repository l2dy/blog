## llvm-cov gcov

> Once you have generated the coverage data files, run llvm-cov gcov for each main source file where you want to examine the coverage results. This should be run from the **same directory** where you previously ran the compiler.

```bash
./configure \
  CFLAGS="--coverage" \
  LDFLAGS="--coverage"
make
cd src
gcov *.c
```

## profile-instr

> To use **llvm-cov show**, you need a program that is compiled with instrumentation to emit profile and coverage data. To build such a program with `clang` use the `-fprofile-instr-generate` and `-fcoverage-mapping` flags. If linking with the `clang` driver, pass `-fprofile-instr-generate` to the link stage to make sure the necessary runtime libraries are linked in.

```bash
./configure \
  CFLAGS="-fprofile-instr-generate -fcoverage-mapping" \
  LDFLAGS="-fprofile-instr-generate"
make
LLVM_PROFILE_FILE="$PWD/cov-%p.profraw" make test
llvm-profdata merge --sparse --output=cov.profdata cov-*.profraw
```
