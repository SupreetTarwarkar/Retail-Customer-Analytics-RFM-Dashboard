# Dataset and source attribution

**Dataset:** [Online Retail II, UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/502/online+retail+ii), donated by Daqing Chen.

This historical, anonymized UK retailer dataset covers December 2009–December 2011 and contains **1,067,371** raw transaction-line records in the two source sheets.

This repository documents the data pipeline rather than uploading the entire raw, cleaned and enriched data repeatedly. Obtain the original from UCI and review licensing/attribution requirements.

### Data path

1. Import both original sheets into PostgreSQL staging tables.
2. Combine via `UNION ALL` and run quality checks.
3. Deduplicate to **1,033,036** rows.
4. Use purchase inclusion rules and customer features to produce **779,495** enriched transaction rows and **5,881** customer-level profiles.

**Note:** Source-sheet names and period-label mapping should be checked against the original file; analysis should rely on `invoicedate` rather than an unverified `sourcesheet` string.

### Data privacy

Customer IDs in this public historical dataset are anonymized. No original individual customer data from a real Dunelm or IKEA business engagement is used.
