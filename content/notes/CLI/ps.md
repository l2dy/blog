## List processes by user

Show every process running as root (real `-U` & effective `-u` ID) in user format:

```
ps -U root -u root u
```

## List processes by PIDs

Show PID 1 and 2 processes in virtual memory format:

```
ps -q 1,2 v
```

## Process tree on FreeBSD

`-d` arranges processes into a tree representing parent and child relationships.

```sh
ps aux -d
```