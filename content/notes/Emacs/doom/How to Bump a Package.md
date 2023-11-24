## How to contribute

1. Make the commit hash changes.
2. Enter the magit buffer with `SPC g g`.
3. Stage the changes.
4. `SPC :` and run `doom/bumpify-diff`.
5. `c c` and paste the commit message with `p`.
6. Test updates with `~/.emacs.d/bin/doom upgrade -p`.