Enabled automatically if you have Emacs built with `--with-native-compilation`.

## Caveats

`doom build` may stuck on native compile if the `vterm` module is enabled. See <https://github.com/hlissner/doom-emacs/issues/5592>.

This problem can be avoided by compiling `vterm-module` in advance.