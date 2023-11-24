---
up: 
related: 
created: 2023-09-21
tags:
---
## `set` and `local` variables

`set` does not work on globals or `let`/`local`-bound locals, but can be used to change a field of a table.

```fennel
(let [t {:a 4 :b 8}]
  (set t.a 2) t) ; => {:a 2 :b 8}
```

Use `var` to declare a mutable local variable that can be `set`.