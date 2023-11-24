---
up: 
related: 
created: 2023-09-14
tags:
---
## Metrics from a TCP Listener

### SampleCount

1. SampleCount of `RequestCount` and `Latency` metrics are exactly the same as number of requests.
2. SampleCount of `SurgeQueueLength` is roughly number of requests doubled.
3. SampleCount of `EstimatedProcessedBytes` and `EstimatedALB*` metrics is number of load balancer nodes at 1 minute periods.
4. SampleCount of `HealthyHostCount` and `UnHealthyHostCount` is a multiple of number of load balancer nodes at 1 minute periods. The multiplier could be one of 18, 60, 66, or some other integer.

### Connection Rate

When TCP request rate is stable and no requests fail, sum of `EstimatedALBNewConnectionCount` should be twice as big as sum of `RequestCount`, because connections established with both clients and targets are counted towards `EstimatedALBNewConnectionCount`.

## Average Waiting Time in Surge Queue

> [!warning]
> This is a thought experiment. It is based on an assumption that is not true.

The 2 times relationship between `SurgeQueueLength` samples and number of requests implies that each request triggers 2 samples.

Given that the maximum `SurgeQueueLength` we have observed is the per node limit of 1024, we can assume that each sample only takes the surge queue length of that specific node.

Therefore, the total `SurgeQueueLength` of the load balancer should be `Avg(SurgeQueueLength)` multiplied by the number of nodes, **assuming that each node handles the same amount of requests in each period**.

Applying Little's law to the surge queue, we get

$$
\begin{aligned}
Avg(Latency)\,s
&= \frac{Avg(SurgeQueueLength) * Number\ of\ Nodes}{Sum(RequestCount) / Period\,s}\\
&= \frac{Avg(SurgeQueueLength) * SampleCount(EstimatedProcessedBytes)}{ Sum(RequestCount) / Period\,s * Period\,min}\\
&= \frac{Avg(SurgeQueueLength) * SampleCount(EstimatedProcessedBytes)}{60 * Sum(RequestCount)}
\end{aligned}
$$

From the CloudWatch data we have analyzed, we can assume that ratio of nodes across Availability Zones (AZs) is the same as ratio of `HealthyHostCount` in each AZ.

Therefore, to calculate the average latency per AZ, we could use per-AZ metrics and SampleCount of `EstimatedProcessedBytes` (which is not split by AZ) multiplied by $$\frac{SampleCount(HealthyHostCount_{a})}{SampleCount(HealthyHostCount)}$$.

The resulting formula is

$$
\begin{aligned}
Avg(Latency_{a})\,s
&= \frac{Avg(SurgeQueueLength_{a}) * SampleCount(EstimatedProcessedBytes)}{60 * Sum(RequestCount_{a})}\\
&= \frac{Avg(SurgeQueueLength_{a}) * SampleCount(EstimatedProcessedBytes) * SampleCount(HealthyHostCount_{a})}{60 * Sum(RequestCount_{a}) * SampleCount(HealthyHostCount)}
\end{aligned}
$$

, with the assumption that requests are evenly distributed across nodes.

Regarding this assumption, from percentile statistics of `EstimatedALBNewConnectionCount` we can see that the distribution of connections across nodes is not even nor stable. To get the total `SurgeQueueLength`, each node's samples must be normalized to the same weight, which is not possible from summary metrics.