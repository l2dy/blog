---
up: 
related: 
created: 2023-11-20
tags:
---
> - Put a call to `provide` at the end of each separate Lisp file.

> `provide` and `require` are an alternative to `autoload` for loading files automatically. They work in terms of named _features_. Autoloading is triggered by calling a specific function, but a feature is loaded the first time another program asks for it by name.

Use of `require` ensures that the file will only be loaded once.

Emacs Lisp files are searched from the *load path*.

## References

- https://www.gnu.org/software/emacs/manual/html_node/elisp/Named-Features.html
- https://www.gnu.org/software/emacs/manual/html_node/elisp/Coding-Conventions.html
- https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Libraries.html
