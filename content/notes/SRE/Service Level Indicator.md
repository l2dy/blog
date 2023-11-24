## Be Realistic

Sometimes only a proxy is available. For example, client-side latency is often the more user-relevant metric, but it might only be possible to measure latency at the server.

## Common Indicators

1. Request latency
2. Error rate / Availability (commonly expressed in the number of nines, e.g. 99% is "2 nines")
3. System throughput
4. Data durability
5. Correctness (needless to say, but often not an SRE responsibility)

A few broad categories of services tend to find different SLIs relevant:

* User-facing serving systems generally care about availability, latency and throughput.
* Storage systems often emphasize latency, availability and durability.
* Big data systems tend to care about throughput and end-to-end latency.

## Aggregation

See [[notes/SRE/Monitoring#Metric Aggregation|Monitoring]].

## SLI Templates

To save effort, build a set of reusable SLI templates for each common metric. Define the aggregation interval & regions, measurement frequency, scope, method of measurement, etc in the template.