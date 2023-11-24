---
up: 
related: 
created: 2023-10-31
tags:
---
Override the default set by tree-sitter.

```elisp
(after! tree-sitter
  (set-face-attribute 'tree-sitter-hl-face:property nil :slant 'normal))
```

## References

- https://github.com/emacs-tree-sitter/elisp-tree-sitter/discussions/130