---
up: 
related: 
created: 2023-10-12
tags:
---
## Free Tier Usage

40 million metric samples can be ingested each month. Given a coefficient of 1.15 and 1 data point per minute, number of series should be kept below 779.

```
? 40000000/1.15/31/24/60
%1 = 779.18
```