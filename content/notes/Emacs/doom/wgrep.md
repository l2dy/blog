`SPC s p foo C-; E i :%s/././ RET Z Z`

1. `SPC-s-p foo` invokes project-wide search
2. `C-; E` exports the results into a wgrep buffer
3. `i <...buffer edits> RET Z Z` makes the buffer editable and saves the changes.

<https://hungyi.net/posts/doom-emacs-search-replace-project/>