---
up: 
related: 
created: 2023-11-04
tags:
---
# Cost Analysis

### Reports

Group by SKU, exclude "Promotions"-type credits, and sort by Subtotal.

### BigQuery

Enable standard usage cost export to BigQuery, and run the following queries.

```sql
/* List billing data from yesterday excluding those using discounts */
SELECT *
  FROM
    `<project>.<dataset_name>.gcp_billing_export_v1_***` CROSS JOIN UNNEST(credits) AS credit
  WHERE
    DATE(_PARTITIONTIME) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) AND
    cost > 0 AND
    credit.type <> "DISCOUNT"
  LIMIT 1000;

/* List *discounted* SKUs and type of discount on a specific day */
SELECT DISTINCT sku.id, sku.description, credit.type, credit.id, credit.name
  FROM
    `<project>.<dataset_name>.gcp_billing_export_v1_***` CROSS JOIN UNNEST(credits) AS credit
  WHERE
    TIMESTAMP_TRUNC(_PARTITIONTIME, DAY) = TIMESTAMP("2023-11-**") AND
    cost > 0 AND
    credit.type = "DISCOUNT"
  LIMIT 1000;

/* Filter for a specific SKU, return original records */
SELECT service, sku, usage_start_time, usage_end_time, cost, credits
  FROM
    `<project>.<dataset_name>.gcp_billing_export_v1_***`
  WHERE
    TIMESTAMP_TRUNC(_PARTITIONTIME, DAY) = TIMESTAMP("2023-11-**") AND
    cost > 0 AND
    sku.id = "CF4E-A0C7-E3BF"
  LIMIT 1000;

/* Filter for a specific SKU in a month, return cost per day */
SELECT TIMESTAMP_TRUNC(_PARTITIONTIME, DAY) AS ts, service.description, sku.description, sum(cost) AS cost
  FROM
    `billing-management-400904.all_billing_data.gcp_billing_export_v1_01D2EE_85D75C_0DBFA9`
  WHERE
    TIMESTAMP_TRUNC(_PARTITIONTIME, MONTH) = TIMESTAMP("2023-11-01") AND
    sku.id = "D34A-7997-2D03"
  GROUP BY ts, service.description, sku.description
  HAVING cost > 0
  ORDER BY ts ASC
  LIMIT 1000;
```

The second query shows discounted costs, including the [[Google Cloud Free Tier|Free Tier]] discount.

See https://cloud.google.com/bigquery/docs/reference/standard-sql/operators for more SQL operators supported by BigQuery.

# Unexpected Costs

## Free Tier

- [[Google Kubernetes Engine]]
	- Zonal Kubernetes Clusters
- Compute Engine
	- E2 Instance Core running in XXX
	- E2 Instance Ram running in XXX

Compute Engine's free tier is applied via transactions with *negative* cost that cancel out the real transactions.

## Networking

### Private Service Connect ([[Google Kubernetes Engine|GKE]] Cluster Endpoint)

- Networking Private Service Connect Partner Select End Point (6882-BFB0-B7E5)

> 100% discount for Networking Private Service Connect Partner Select End Point.

- Networking Service Directory Registered Resource (D34A-7997-2D03), 0.10 USD per month

> [Access services](https://cloud.google.com/vpc/docs/about-accessing-vpc-hosted-services-endpoints) in another VPC network by using Private Service Connect endpoints. You can connect to your own services, or those provided by other service producers, including by Google.

Run `gcloud services enable servicedirectory.googleapis.com` to enable the required API to inspect the resource.

Service directory registration by GKE is handled regardless of the status of the API. Service name is `gk3-*-pe`, type is *Private Service Connect*, namespace is the default `goog-psc-default`, and endpoint IP is the internal endpoint, which means it is immutable.

### Network Intelligence Center

- Network Intelligence Center Network Analyzer Resource Hours
- Network Intelligence Center Internet to Google Cloud Performance Resource Hours
- Network Intelligence Center Topology and Google Cloud Performance Resource Hours

> The Network Topology and Performance Dashboard modules are available to all users for 100% discount. The cost of these modules will be shown in your billing details, but you will not be charged for them. Any changes to the discount structure will be effective with a 90 days prior notice. The updates to the discount rates will appear in your billing information only after you choose to re-enable the modules.

## References

- https://cloud.google.com/network-intelligence-center/pricing#network-topology-pricing-details
- https://www.googlecloudcommunity.com/gc/Cloud-Hub/How-to-stop-Network-Intelligence-Center-related-SKUs/m-p/515742/highlight/true#M1782
- https://cloud.google.com/vpc/docs/configure-private-service-connect-services
- https://cloud.google.com/skus/sku-groups/global-skus
- https://cloud.google.com/free/docs/free-cloud-features#compute
