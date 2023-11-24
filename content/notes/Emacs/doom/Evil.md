## yank forward

`y f SPC` does not yank the space character with `evil-snipe-override-mode`. See <https://github.com/hlissner/evil-snipe/issues/86>.

```elisp
(remove-hook 'doom-first-input-hook #'evil-snipe-override-mode)
```

## Commands

Repeat last change: `.`
Repeat last substitute: `&`

## Ex-commands

Close buffer: `:bd` (or use `C-w d`)

### Key Bindings

Complete ex-command in minibuffer: `TAB`