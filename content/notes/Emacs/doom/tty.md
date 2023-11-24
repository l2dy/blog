## `+osc`

In Mosh, `SSH_TTY` is left as is and points to a dead TTY. `unset SSH_TTY` in `.zprofile` or read tty from `tmux display-message -p '#{pane_tty}'` in a nested tmux session.
