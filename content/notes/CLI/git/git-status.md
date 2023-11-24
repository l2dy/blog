## `git status` taking too long

May affect interactivity of shell prompts (e.g. starship) that check git status.

To reduce prompt latency, disable checking untracked files in big repositories.

```bash
git config status.showUntrackedFiles no
```
