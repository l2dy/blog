---
up: 
related: 
created: 2023-10-09
tags:
---
The runtime should decorate each log entry with a RFC 3339Nano timestamp prefix, the stream type (i.e., "stdout" or "stderr"), the tags of the log entry, the log content that ends with a newline.

Currently, only one tag is defined in CRI to support multi-line log entries: partial or full. Partial (`P`) is used when a log entry is split into multiple lines by the runtime, and the entry has not ended yet. Full (`F`) indicates that the log entry is completed -- it is either a single-line entry, or this is the last line of the multiple-line entry.

For example,

```
2016-10-06T00:17:09.669794202Z stdout F The content of the log entry 1
2016-10-06T00:17:09.669794202Z stdout P First line of log entry 2
2016-10-06T00:17:09.669794202Z stdout P Second line of the log entry 2
2016-10-06T00:17:10.113242941Z stderr F Last line of the log entry 2
```

With the knowledge, kubelet can parse the logs and serve them for `kubectl logs` requests. This meets requirement (3). Note that the format is defined deliberately simple to provide only information necessary to serve the requests. We do not intend for kubelet to host various logging plugins. It is also worth mentioning again that the scope of this is restricted to stdout/stderr streams of the container, and we impose no restriction to the logging format of arbitrary container logs.

## References

- https://github.com/kubernetes/design-proposals-archive/blob/acc25e14ca83dfda4f66d8cb1f1b491f26e78ffe/node/kubelet-cri-logging.md#proposed-solution