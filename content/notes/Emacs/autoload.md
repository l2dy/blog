---
up: 
related: 
created: 2023-11-20
tags:
---
## Magic autoload comment

> A magic autoload comment (often called an _autoload cookie_) consists of `;;;###autoload`, on a line by itself, just before the real definition of the function in its autoload-able source file. The function `loaddefs-generate` writes a corresponding `autoload` call into `loaddefs.el`. Building Emacs loads `loaddefs.el` and thus calls `autoload`.

Example:

```elisp
;;;###autoload
(define-derived-mode ini-mode prog-mode "ini"
  "Major mode for editing Windows-style ini files."
  (setq font-lock-defaults '(ini-font-lock-keywords nil)))
```

## Same line magic

> You can also use a magic comment to execute a form at build time _without_ executing it when the file itself is loaded. To do this, write the form _on the same line_ as the magic comment. Since it is in a comment, it does nothing when you load the source file; but `loaddefs-generate` copies it to `loaddefs.el`, where it is executed while building Emacs.

Example:

```elisp
;;;###autoload(add-to-list 'auto-mode-alist '("\\.ini\\'" . ini-mode))
```

## `autoload` function

Outside of Emacs itself, Doom modules and `package.el`-managed packages, the magic comment `;;;###autoload` does not work by default.

In your local Emacs Lisp files, you should use the `autoload` function directly, or import it with `use-package` by configuring `:load-path` to load a local package and use `:commands` (including `:hook`, `:bind`, `:mode`, etc.) to let `use-package` handle autoload for you.

## References

- https://www.gnu.org/software/emacs/manual/html_node/elisp/Autoload.html
- https://github.com/doomemacs/doomemacs/issues/1213#issuecomment-468970403
- https://github.com/emacs-mirror/emacs/blob/e81e625ab895f1bd3c5263f5b66251db0fd38bd6/lisp/emacs-lisp/package.el#L813
- https://github.com/doomemacs/doomemacs/blob/986398504d09e585c7d1a8d73a6394024fe6f164/lisp/lib/autoloads.el#L160
