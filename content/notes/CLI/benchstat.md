Compare `go test -bench=...` results and print nice statistics.

https://pkg.go.dev/golang.org/x/perf@v0.0.0-20211012211434-03971e389cd3/cmd/benchstat

```
$ benchstat old.txt new.txt
name        old time/op  new time/op  delta
GobEncode   13.6ms ± 1%  11.8ms ± 1%  -13.31% (p=0.016 n=4+5)
JSONEncode  32.1ms ± 1%  31.8ms ± 1%     ~    (p=0.286 n=4+5)
```
