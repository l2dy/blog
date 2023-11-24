## [[Magit]] key bindings

### `evil-collection-magit-use-y-for-yank`

> replace "y" for `magit-show-refs` with "yy" for `evil-collection-magit-yank-whole-line`, "ys" for `magit-copy-section-value`, "yb" for magit`-copy-buffer-revision` and "yr" for `magit-show-refs`. This keeps "y" for `magit-show-refs`, in the help popup (`magit-dispatch`).

### `evil-collection-magit-use-z-for-folds`

When non nil (default in Doom), use "z" as a prefix for common vim fold commands, such as
  - z1 Reset visibility to level 1 for all sections
  - z2 Reset visibility to level 2 for all sections
  - z3 Reset visibility to level 3 for all sections
  - z4 Reset visibility to level 4 for all sections
  - za Toggle a section
  - zo Show section
  - zO Show sections recursively
  - zc Hide section
  - zC Hide sections recursively
  - zr Same as z4.

## Activate additional evil-collection-MODULE

```elisp
(after! mpdel
  (add-transient-hook! 'mpdel-mode
    (+evil-collection-init 'mpdel)))
```