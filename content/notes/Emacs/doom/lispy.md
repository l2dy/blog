## Key Bindings

Slurp: `>`
Barf: `<`
Clone: `c`

Forward: `]`
Backward: `[`
Jump to matching pair: `d`

Split: `M-j`
Join: `+`
### Insert

Parens: `(`
Braces: `{`
Brackets: `}`
Quotes: `"`

## LispyVille

As described in https://github.com/abo-abo/lispy/issues/534, for arrow keys to work in xterm, `M-O` must be free from bindings in Emacs.

However, package `lispyville` binds both `M-o` and `M-O` keys to its functions with `evil-define-key*`. Unbind them with the following config.

```elisp
(map! :after lispyville
      :map lispyville-mode-map
      :n "M-O" nil
      :n "M-o" nil)
```
