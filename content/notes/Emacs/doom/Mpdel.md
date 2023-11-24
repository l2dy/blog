```elisp
(use-package! mpdel
  :config
  (+evil-collection-init 'mpdel)
  (map! :leader
        :desc "MPDel" "Z" mpdel-core-map))
```