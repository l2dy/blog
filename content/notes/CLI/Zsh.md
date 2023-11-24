---
up: 
related: 
created: 2023-10-31
tags:
---
## New User Setup

> You should not edit anything between these lines if you intend to run zsh-newuser-install again.  You may, however, edit any other part of the file.

```sh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/mnt/home/l2dy/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
```

## Run Application in Background

Use `&|` to run job in background and remove it from the job table (`disown`) in one command.

In Fish and Bash, you have to use two commands, e.g. `firefox &; disown`.
