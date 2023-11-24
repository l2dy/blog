## Setup

```elisp
;; Add to packages.el
(package! pyim :disable t)
(package! rime)
```

```elisp
;; Add to config.el
(use-package! rime
  :after-call after-find-file pre-command-hook
  :init
  (setq rime-emacs-module-header-root "/Applications/MacPorts/Emacs.app/Contents/Resources/include"
        rime-librime-root "/opt/local")
  :config
  (setq rime-show-candidate 'popup
        rime-disable-predicates
        '(rime-predicate-evil-mode-p
          rime-predicate-prog-in-code-p)
        default-input-method "rime"))
```