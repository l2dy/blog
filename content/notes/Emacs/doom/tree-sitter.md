---
up: 
related: 
created: 2023-11-20
tags:
---
## Use existing `*-ts-mode` package

First, install packages in `package.el`.

```elisp
(package! tree-sitter-langs
  :pin "3a3ad0527d5f8c7768678878eb5cfe399bedf703")

(package! typst-ts-mode
  :recipe (:host sourcehut :repo "l2dy/typst-ts-mode")
  :pin "39a9e63c019bd5498c8f0e5a7ee8cb9d6bb53fd0")
```

If package depends on `treesit` instead of `tree-sitter`, it's required to copy and rename parser library files.

```elisp
;; config.el

(defun treesit-copy-langs-lib-if-newer (lang)
  "Copy treesit libraries from tree-sitter-langs"
  (require 'tree-sitter-langs)
  (let* ((ts-lib-path (car (file-expand-wildcards (concat (tree-sitter-langs--bin-dir) lang ".*"))))
         (ts-lib-name (file-name-nondirectory ts-lib-path))
         (ts-lib-user-dir (concat user-emacs-directory (file-name-as-directory "tree-sitter")))
         (ts-lib-user-path (concat ts-lib-user-dir "libtree-sitter-" ts-lib-name)))
    (when (or (not (file-exists-p ts-lib-user-path))
              (time-less-p (file-attribute-modification-time (file-attributes ts-lib-user-path))
                           (file-attribute-modification-time (file-attributes ts-lib-path))))
      (make-directory ts-lib-user-dir t)
      (delete-file ts-lib-user-path)
      (copy-file ts-lib-path ts-lib-user-path nil t))))

(use-package! typst-ts-mode
  :mode "\\.typ\\'"
  :config
  (treesit-copy-langs-lib-if-newer "typst"))
```

## Using pre-compiled language grammars

> You can find them [on his Github releases](https://github.com/emacs-tree-sitter/tree-sitter-langs/releases) page. You can also download the `tree-sitter-langs` package from MELPA, but I recommend you just download the shared libs directly instead, as you’ll in any event have to rename them and place the grammar libraries somewhere else.
>
> The names of the files are `<LANGUAGE>.so` (or with your platform’s equivalent extension) which is not in keeping with the expected naming style in Emacs. You must first **rename them** so they’re named `libtree-sitter-<LANGUAGE>.so`. This is as good a time as any to learn how to bulk rename them with Emacs’s `M-x dired` and the [editable dired buffers](https://www.masteringemacs.org/article/wdired-editable-dired-buffers) feature.

## Define your own new major mode for highlighting

Supported languages: https://github.com/emacs-tree-sitter/tree-sitter-langs/tree/master/queries

1. Ensure `(package! tree-sitter-langs ...)` pins to the right commit (or a later commit) in `packages.el` and tree-sitter module is enabled in `init.el`.
2. Run `doom sync` if pin is updated, and verify that updates are applied to local [[Straight]] directories.
3. Define the major mode in `config.el`, or a custom Doom module with `define-derived-mode` split into `autoload.el`.

```elisp
;;;###autoload
(define-derived-mode typst-mode text-mode "Typst"
  "Major mode for editing Typst documents."
  (set-tree-sitter-lang! 'typst-mode 'typst) ;; only required if not in tree-sitter-langs--init-major-mode-alist
  (add-hook 'typst-mode-local-vars-hook #'tree-sitter! 'append))

(add-to-list 'auto-mode-alist '("\\.typ\\'" . typst-mode))
```

To enable LSP instead, replace `#'tree-sitter!` with `#'lsp!`.

> For Elisp gurus: Doom provides MAJOR-MODE-local-vars-hook, and we use it instead of MAJOR-MODE-hook because it runs later in the mode's startup process (giving other functionality or packages -- like `direnv` -- time to configure the LSP client).

## References

- https://github.com/doomemacs/doomemacs/issues/1213#issuecomment-468970403
- https://www.masteringemacs.org/article/how-to-get-started-tree-sitter
- https://github.com/doomemacs/doomemacs/blob/master/docs/faq.org#turn-doom-emacs-into-a-insert-language-here-ide-with-lsp