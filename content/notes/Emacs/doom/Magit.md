## Navigation

`magit-section-backward-sibling` (<kbd>[</kbd>) and `magit-section-forward-sibling` (<kbd>]</kbd>).

## Line-wrap

`$` is mapped to magit-process-buffer, so it's hard to jump to end of line.

Use `SPC t w` to enable line wrapping.

## Commit message

### Finish or cancel editing

| Action | Key             |
| ------ | --------------- |
| Finish | `C-c C-c`, `ZZ` |
| Cancel | `C-c C-k`, `ZQ` |

### Commit message ring

Both finished and cancelled messages are saved to a ring that persists until Emacs is closed. Use `M-p` and `M-n` to navigate older messages in any edit session.