---
up: 
related: 
created: 2023-10-31
tags:
---
## Revisions

`arc diff` discards local commit history, and only submits the diff to base to Phorge.

Every subsequent `arc diff` updates an existing revision.

If your revision has not been accepted, forcibly executing `arc land` would not auto-close it.

## References

- https://we.phorge.it/book/phorge/article/arcanist_diff/
- https://secure.phabricator.com/T1508