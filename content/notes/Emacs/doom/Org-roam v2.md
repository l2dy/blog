## Config

```elisp
;; in config.el
(setq org-roam-directory "~/org-roam/")

(after! org-roam
  (setq +org-roam-auto-backlinks-buffer t))
```

## org-roam-protocol

Follow the Org-roam user manual to create an AppleScript application. Then save the following as a bookmarklet in Firefox:

```js
javascript:location.href =
    'org-protocol://roam-ref?template=r&ref='
    + encodeURIComponent(location.href)
    + '&title='
    + encodeURIComponent(document.title)
```