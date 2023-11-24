---
up: "[[FreeBSD Map]]"
related: 
created: 2023-09-11
tags: []
---
## One-Liners and Scripts

https://wiki.freebsd.org/DTrace/One-Liners

### Capture Stacks

For use with [[notes/Programming/C/Flame Graph|Flame Graph]].

```sh
# Capture user-level stack at 197 Hz for 60 seconds
sudo dtrace -x ustackframes=100 -n 'profile-197 /execname == "python3.9"/ { @[ustack()] = count(); } tick-60s { exit(0); }' -o out.stacks

# Kernel stack
sudo dtrace -x stackframes=100 -n 'profile-197 /pid == 12345/ { @[stack()] = count(); } tick-60s { exit(0); }' -o out.kstacks
```

### Capture Function Argument, Return Value and Latency

```sh
sudo dtrace -s getaddrinfo.d -p 12345
```

```dtrace
#!/usr/sbin/dtrace -s
/*
 * getaddrinfo.d
 */

#pragma D option quiet

dtrace:::BEGIN
{
	printf("%-20s  %-4s %-12s %s\n", "TIME", "RET", "LATENCY(ms)", "HOST");
}

pid$target::getaddrinfo:entry
{
	self->host = copyinstr(arg0);
	self->start = timestamp;
}

pid$target::getaddrinfo:return
/self->start/
{
	this->delta = (timestamp - self->start) / 1000000;
	printf("%-20Y  %-4d %-12d %s\n", walltimestamp, arg1, this->delta, self->host);
	self->host = 0;
	self->start = 0;
}
```