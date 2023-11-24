## Why doesn't Doom package ParEdit?

From Doom's FAQs

> Why are there no default keybinds for Smartparens (for evil users)?
>
> Doom only uses smartparens to manage pair “completion” (it does the job better than electric-{pair,quote}-mode or the multitude of other pair-management solutions in the Emacs ecosystem at the time of writing).
> None of smartparen’s commands have default keybinds for evil users because they are redundant with motions and text-objects provided by evil/vim. If you disagree, I recommend trying the `:editor lispy` or `:editor parinfer` modules.

But if you insist on using ParEdit in Doom, read on.

## Install

Add following code to `packages.el` or enable `clojure` in `:lang` of `init.el`.

```elisp
(package! paredit :pin "...")
```

## Configuration

Add following code to `config.el` and restart Emacs.

```elisp
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook! '(emacs-lisp-mode-hook clojure-mode-hook) #'enable-paredit-mode)
```

## Key bindings

`paredit-{backward,forward}-slurp-sexp` (`C-(` and `C-)`) pulls new elements in from either side and `paredit-{backward,forward}-barf-sexp` (`C-{` and `C-}`) pushes elements away.