## Purpose

Error budgets resolve the structural conflict of incentives between development and SRE. If product development wants to skimp on testing or increase push velocity and SRE is resistant, the error budget guides the decision.

The goal is not "zero outages", an outage is not a "bad" thing.

- It is an expected part of the process of innovation.
- An occurrence that we manage, rather than fear.
- We aim to spend the error budget getting maximum feature velocity.

## Example

What happens if a network outage or data-center failure reduces the measured [[notes/SRE/Service Level Indicator|Service Level Indicator]]?

1. Such events also eat into the error budget.
2. As a result, the number of new pushes may be reduced for the remainder of the quarter. [[notes/SRE/Change Management|Change Management]]
3. Everyone shares the responsibility for uptime.
4. If the team is having trouble launching new features, they may elect to loosen the [[notes/SRE/SLO|SLO]] in order to increase innovation.

## Implementations

[Sloth](https://github.com/slok/sloth) is a Prometheus-native way to generate SLO metrics, including error budgets.