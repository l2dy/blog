---
up: 
related: 
created: 2023-10-31
tags:
---
## Configuration

Set `format` to skip slow modules, instead of disabling them individually. For example, I'm using

```toml
# ~/.config/starship.toml
format = '$username$hostname$directory$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$character'
```