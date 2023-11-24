Software should do the interpreting of the alerting domain, and humans should be notified when action is needed.

There are three kinds of valid monitoring output:

- Alerts (paging): immediate action needed
- Tickets and email alerts: action needed, but not immediately
- Logging: recorded for diagnostic or forensic purposes

Paging a human is a quite expensive use of an employee's time. Effective alerting systems have good signal and very low noise.

You should favor a dashboard that monitors all ongoing sub-critical problems for the sort of information that typically ends up in email alerts. A dashboard might also be paired with a log, in order to analyze historical correlations.
