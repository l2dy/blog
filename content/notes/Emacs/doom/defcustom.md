Use `setq` in `(after! ...)` to set variables for a packge.

If a variable is defined with `defcustom` and has an associated `custom-set` form, use `setq!` instead of `setq` in doom to execute it.
