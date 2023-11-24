## Parameter expansion

Quote the *word* in here-documents to inhibit any expansion.

```
<<'word'
```

> If any part of *word* is quoted, the *delimiter* is the result of quote removal on *word*, and the lines in the here-document are not expanded.	If *word* is unquoted, all lines of the here-document are subjected to parameter expansion, command substitution, and arithmetic expansion, the character sequence `\<newline>` is ignored, and `\` must be used to quote the characters **\\**, **\$**, and **\`**.