## LSP (preferred)

```
;; in init.el
:lang
(cc +lsp)
```

## Irony-Mode

It does not work out of the box on macOS, but it is possible to put additional header flags to `~/.clang_complete`, as long as no intermediate parent directory contains `.clang_complete` or `compile_flags.txt`.

```elisp
(defun irony-cdb-clang-complete--locate-db ()
  (when buffer-file-name
    (catch 'fname
      (locate-dominating-file
```

```sh
echo | clang -x c++ -v -E - 2>&1 | sed -n '/^#include </,/^End/s|^[^/]*\([^ ]*/include[^ ]*\).*$|-I\1|p' > ~/.clang_complete
```

## rtags

rtags also does not work out of the box on macOS, requiring users to configure `~/.rdmrc`.

```
--isystem=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../include/c++/v1
--isystem=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/12.0.0/include
<...>
```