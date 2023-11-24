## Multi root servers

Multi-root means that one server can handle multiple projects, but the default behavior of lsp-mode is to load all projects for this language server at once.

To make it load folders on demand, add the following in `(after! lsp-mode ...)`.

```elisp
(advice-add 'lsp :before (lambda (&rest _args) (eval '(setf (lsp-session-server-id->folders (lsp-session)) (ht)))))
```

Even if all projects are loaded, cross-project references does not work. Move related projects into a workspace folder and create the special `.projectile` file to let [[Projectile]] treat it as a whole.

## State Files

Session information is stored in the file pointed to by `lsp-session-file`.

To remove a project from history, run `lsp-workspace-folders-remove`.

To list all current projects, run `lsp-describe-session`.