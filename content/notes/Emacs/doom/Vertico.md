## Key bindings in minibuffer

Preview: `C-SPC` for `+vertico/embark-preview`
Next & previous history: `M-p` and `M-n`
Page up & down: `C-S-j` and `C-S-k`
Next & previous group: `C-M-j` and `C-M-k`
Next & previous row: `C-j` and `C-k`
Exit with input: `M-RET` (`vertico-exit-input`) or `RET` (`exit-minibuffer`)

## Search pattern

[[notes/Emacs/doom/Consult|Consult]]

## Search in all key bindings

Usually `SPC h b b`, but use `C-h b b` or `<doom-leader-alt-key>` instead of `SPC` when leader key (`SPC`) is not available, for example in a vertico minibuffer:

```
scroll-up-command             <kp-next>, C-S-j
vertico-scroll-up             <remap> <scroll-up-command>
```

## Copy candidate list

`C-; E` in minibuffer to export candidates to a new buffer with [[notes/Emacs/doom/Embark|Embark]].

## completing-read-multiple (crm)

Powers multi-select feature in magit.

- `+vertico/crm-select`: <kbd>TAB</kbd>
- `+vertico/crm-exit`: <kbd>RET</kbd>
- `+vertico/crm-select-keep-input`: <kbd>S-TAB</kbd>