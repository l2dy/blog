## Asynchronous Search

<https://github.com/minad/consult#asynchronous-search>

Doom Emacs uses the perl splitting style, which splits the input string at a punctuation character and treats each as an Emacs regular expression, so special characters like `$` has to be escaped.

To avoid such splitting, add a backslash (`\`) before spaces.

## Second Filter

> Consult splits the input string into two parts, if the first character is a punctuation character, like `#`. For example `#regexps#filter-string`, is split at the second `#`.
> The `filter-string` is passed to the _fast_ Emacs filtering to further narrow down the list of matches.

## Search in file type

Arguments after `--` is passed to `rg`. For example,

```
#regexps -- -g *.go -g !*_test.go
```

## Workaround searching for whitespace character

```
#use[\ ] -- -g *.php
```
