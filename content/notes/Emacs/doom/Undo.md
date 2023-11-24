## Disable undo history persistence

```elisp
;; Add in config.el
(remove-hook 'undo-fu-mode-hook #'global-undo-fu-session-mode)
```