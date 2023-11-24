## The Four Golden Signals

- Latency
	- It's important to distinguish between the latency of successful requests and the latency of failed requests.
		- Should we cout client timeouts as successful requests? They are potentially requests that took too long but could have been successful, on the other hand it could also be a client-side early close.
	- A slow error is even worse than a fast error! Therefore, it's important to track error latency, as opposed to just filtering out errors.
- Traffic
	- Normalized request rate, for example HTTP requests per second.
- Errors
	- Rate of requests that fail, either explicitly (e.g. HTTP 500s), implicitly (e.g. wrong content), or by policy (e.g. missing latency target).
- Saturation
	- Emphasize the resources that are most constrained (e.g. memory, I/O, etc.)
	- Systems degrade before they achieve 100% utilization, so having a utilization target is essential.

## Metric Aggregation

Most metrics are better thought of as **distributions** rather than averages. A high-order percentile, such as the 99th or 99.9th, shows you a plausible worst-case value, while the 60th percentile emphasizes the typical case.

For example, Histogram summaries of CPU usage per second in a minute provides good resolution (granularity) with less collection and retention cost.

## Black-Box Versus White-Box

We should aim for heavy use of white-box monitoring with modest but critical uses of black-box monitoring. White-box monitoring helps identify the root cause.

Black-box monitoring is symptom-oriented and represents active (not predicted) problems. For not-yet-occurring but imminent problems, black-box monitoring is fairly useless.

## [[notes/SRE/Alerting|Alerting]]