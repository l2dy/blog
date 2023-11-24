Beware of MP_PATH_SCAN.

```m4
dnl This macro ensures MP installation prefix paths are NOT in PATH
dnl for configure to prevent potential problems when base/ code is updated
dnl and ports are installed that would match needed items.
AC_DEFUN([MP_PATH_SCAN],[
    ...
])
```

Use symboic links as a workaround:

```
ln -s /opt/local/libexec/llvm-13/libexec/intercept-cc ~/.local/bin/
intercept-build-mp-13 bash -c './configure && make -j6'
```