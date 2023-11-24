---
up: 
related: 
created: 2023-09-24
tags:
---
1. Create `gh-pages` branch first.
2. Commit Actions workflow before charts directory.
3. Remote repos referenced in `Chart.lock` needs to be added before executing the `chart-releaser` step.
4. Commit your charts directories under `/charts`.

## References

- https://github.com/marketplace/actions/helm-chart-releaser