---
up: 
related: 
created: 2023-09-30
tags:
---
# Data-source Managed Alerts

## APIs

### Alert Generator Compliance Specification

https://github.com/prometheus/compliance/blob/main/alert_generator/specification.md

#### API endpoints

- GET /api/v1/alerts
- GET /api/v1/rules

### Ruler API

Ruler API configures recording rules and alerts, and a backend storage is required to store them.

#### References

- https://cortexmetrics.io/docs/api/#ruler
- https://grafana.com/docs/mimir/latest/references/http-api/#ruler

## Implementations

### VictoriaMetrics

Alert Generator Compliance Specification 1.0 is implemented.

Ruler API endpoints are not implemented yet. See https://github.com/VictoriaMetrics/VictoriaMetrics/issues/4939.

### Grafana Mimir

Fully supported.
