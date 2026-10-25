# Retail Customer Analytics | RFM Segmentation & Churn Analysis

**End-to-end customer analytics using PostgreSQL, Python (Google Colab), and Power BI**

**Developed and customized by:** Supreet Jayant Tarwarkar  
**Guided by:** Mansi Goel (Mansi G.) — [original guided project](https://github.com/the-mansi-goel/IKEA)  
**Focus:** Customer value • RFM segmentation • retention risk • revenue performance • business intelligence

> **Portfolio / attribution notice:** This is an educational project recreated from Mansi Goel's guided *IKEA Gifting* analytics workflow, with an independent PostgreSQL/Google Colab implementation and a redesigned Power BI dashboard. The data is from the public UCI Online Retail II dataset. IKEA Gifting is a fictional project brand. The visual redesign is Dunelm-inspired, but neither IKEA nor Dunelm supplied, commissioned, endorsed, or owns the business results. All findings describe the historical sample, not current business performance.

---

## 1. Project overview

A retailer needs to understand **who its most valuable customers are, how spending and engagement differ by segment, and which customers may need retention attention**. This project follows a business-analytics workflow from raw transactional data to an interactive three-page Power BI report.

The pipeline uses **PostgreSQL** for source consolidation, data validation and deduplication; **Python/Pandas in Google Colab** for RFM scoring, six customer segments and an inactivity flag; and **Power BI** for KPI monitoring, segment comparisons, geographic analysis and time-series exploration.

### Project snapshot

| Metric | Result |
|---|---:|
| Raw transaction rows | 1,067,371 |
| Exact-duplicate extra rows removed | 34,335 |
| Deduplicated SQL transaction rows | 1,033,036 |
| Enriched Power BI transaction-level rows | 779,495 |
| Distinct customers in RFM analysis | 5,881 |
| Customer segments | 6 |
| Historical inactivity rule | Recency > 90 days |
| Churn/inactivity indicator | ~50.9% |
| Report pages | 3 |
| Dashboard revenue display | ~$17M (displayed unit; see currency limitation) |

**Note on currency:** The UCI source contains prices from a UK retailer. The report's dollar symbol is a display format, **not** evidence that the source revenue was converted to USD. Do not interpret it as USD without a verified conversion.

## 2. Business questions

1. Which customer segments contribute the most revenue?
2. How concentrated is revenue among high-value customers?
3. Which customers are historically inactive under a consistent cutoff?
4. How do revenue, customer counts and inactivity vary across time and country?
5. How can segment-level reporting support retention priorities?

**In scope:** descriptive analytics, data cleaning, RFM analysis, rule-based inactivity classification, Power BI reporting.  
**Out of scope:** predictive churn models, causal analysis, live scoring, marketing campaign execution and demonstrated ROI.

## 3. Tech stack

| Technology | Role |
|---|---|
| PostgreSQL and pgAdmin 4 | Source import, type conversion, validation, joins/appends and deduplication |
| SQL | Profiling, duplicate detection, cleaned transaction table |
| Python, Pandas | RFM features, quintile scoring, customer segmentation and enrichment |
| Google Colab | Notebook execution and final export |
| Power BI Desktop | Three-page reporting, slicers, matrices, charts, bookmarks |
| DAX / Power Query | Measures, modelling and data preparation |
| Segoe UI / forest-and-sage theme | Customized visual presentation |

The instructor's original environment uses SQL Server/SSMS and a local Jupyter environment. This implementation uses PostgreSQL and Google Colab.

## 4. Data source and processing

**Source:** UCI Machine Learning Repository — [Online Retail II](https://archive.ics.uci.edu/dataset/502/online+retail+ii), donated by Daqing Chen. The historical transaction dataset spans December 2009 to December 2011.

```text
UCI Online Retail II
      ↓  Two source files, 1,067,371 rows
PostgreSQL staging tables
      ↓  UNION ALL + type conversion + validation
PostgreSQL profiling and exact-value deduplication
      ↓  retail_cleaned: 1,033,036 rows
CSV export
      ↓
Google Colab / Pandas
      ↓  Eligible purchases → RFM → scores → six segments → inactivity flag
Customer-level RFM table: 5,881 customers
      ↓  Merge customer features back to eligible transaction lines
Power BI analytical table: 779,495 rows
      ↓
Home Page | Business Overview | RFM Analysis
```

### SQL audit trail

| Validation | Count |
|---|---:|
| Raw sheet 1 | 541,910 |
| Raw sheet 2 | 525,461 |
| Combined transactions | 1,067,371 |
| Rows with missing customer IDs (raw) | 243,007 |
| Rows with nonpositive quantity (raw) | 22,950 |
| Rows with missing descriptions (raw) | 4,382 |
| Exact duplicate groups | 32,907 |
| Extra rows removed during deduplication | 34,335 |
| Retained rows | 1,033,036 |

**32,907 duplicate groups is not the number of records removed.** The cleaned dataset retains one row per group, which removes 34,335 redundant occurrences.

SQL scripts: [01_SQL](01_SQL/README.md). Import the source files into the corresponding staging tables before running the combined-table SQL. Keep the raw source files unchanged.

## 5. RFM and churn methodology

**Recency (R):** days between a historical analysis date (2011-12-10) and each customer's latest qualifying purchase. Lower days = better Recency, so its score direction is reversed.

**Frequency (F):** number of **distinct invoices**, not count of individual item rows.

**Monetary (M):** total eligible transaction value, calculated as quantity × price.

Each feature is scored from **1 to 5** using quantile-based ranking. Frequency tie-handling uses ranked values before quantile assignment.

Customers are assigned **one** of six mutually exclusive categories by ordered business rules:

| Customer segment | Analytical interpretation |
|---|---|
| Champions | High engagement and high value |
| Loyal | Strong repeat-purchase relationship |
| At Risk | Previously valuable, but becoming inactive |
| New | Recent customers with limited history |
| Needs Attention | Customers who may benefit from engagement |
| Lost | Historically lapsed / low-recent-engagement customers |

**Churn flag:** `Recency > 90` days is a **rule-based historical inactivity flag**, not a predictive model and not proof of permanent customer loss.

**Important data-grain safeguard:** the enriched Power BI table is at transaction-line grain. Customer-level RFM variables are repeated on transaction lines. Do **not** sum repeated customer-level monetary/frequency/recency columns across rows.

Python folder: [02_Python](02_Python/README.md). The executed notebook will be added after final validation.

## 6. Dashboard structure

### Page 1 — Home Page
A redesigned forest-and-sage landing page with navigation to the analytical pages, a concise project description, and an RFM/key-metrics glossary.

### Page 2 — Business Overview
Four KPI cards — **Total Customers, Total Revenue, Churned %, Avg Customer Value** — plus segmentation visualizations, month/quarter/year trends, a Revenue/Customer toggle, and filters for Month, Quarter, Year, Country, Segment and churn status.

### Page 3 — RFM Analysis
Country and segment performance summaries, average R/F/M scores, average customer value comparisons, inactivity trends and bookmark-controlled segment/country views.

The redesign uses dark forest green, sage accents, white cards, and Segoe UI. It is an illustrative visual identity, not commercial Dunelm data.

[Power BI report files and publishing instructions](03_PowerBI/README.md) · [Dashboard screenshots](04_Screenshots/README.md)

## 7. Findings and business interpretation

- **5,881** customers were assigned customer-level RFM measures and segments.
- The dashboard reports around **50.9%** historically inactive customers under the project's 90-day threshold.
- **Champions** contribute approximately **68%** of reported revenue despite representing roughly **22%** of customers: a substantial concentration of value.
- Average customer value varies materially between segments; an identical retention tactic for every customer would discard useful segmentation.
- Revenue rises in Q4, consistent with possible gifting-season demand. The project does **not** prove the cause of seasonality.

**Illustrative recommendations:** monitor and reward high-value customers; test reactivation for At Risk customers; develop second-purchase onboarding for New customers; evaluate win-back economics for historically Lost customers. These are recommendations, **not** completed campaigns or measured uplifts.

See [Insights and Limitations](Challenges-and-Learnings/README.md).

## 8. Repository map

```text
Retail-Customer-Analytics-RFM-Dashboard/
├── README.md
├── .gitignore
├── 01_SQL/
│   ├── README.md
│   ├── 01_Data_Import_and_Combination.sql
│   ├── 02_ecommerce_customer_analytics.sql
│   └── 03_retail_cleaned.sql
├── 02_Python/
│   └── README.md                 # Notebook to be added
├── 03_PowerBI/
│   ├── README.md
│   └── Dunelm_Forest_Sage_Theme.json
├── 04_Screenshots/
│   └── README.md                 # Final screenshots to be added
├── Dataset/
│   └── README.md
└── Challenges-and-Learnings/
    └── README.md
```

**Current repository release status:** source SQL, documentation and theme are published here. The final binary PBIX, Colab notebook, final screenshots and interactive Power BI URL are **not yet published**. Those additions do not require changing this directory structure.

## 9. Reproduction instructions

1. Download Online Retail II and preserve original sheets/source data.
2. Create and populate the PostgreSQL staging tables, then run the scripts in [01_SQL](01_SQL/README.md) in order. Validate expected row counts.
3. Export `retail_cleaned` to CSV with headers.
4. Run the forthcoming Google Colab notebook on that CSV. Validate 5,881 distinct customers and the documented analysis filters.
5. Export the enriched transaction dataset; open the PBIX once it is attached and update the local Power BI data-source path.
6. Refresh, compare KPI totals, verify slicers and navigation, and publish to Power BI Service when appropriate.

For the original learning materials and complete walkthrough, see the [instructor's repository](https://github.com/the-mansi-goel/IKEA).

## 10. Limitations and transparency

- Historical 2009–2011 retail data; not a present-day business dashboard.
- Inactivity threshold is a business rule and was not statistically calibrated.
- Returns, missing customer IDs and frequency ties affect analytic choices.
- Unclear source-sheet labels should not be used for year comparisons until the mapping is confirmed.
- Chart currency formatting must be reconciled before quoting USD figures.
- Neither actual IKEA nor Dunelm financial metrics can be inferred from this dataset.
- No independently verified campaign impact or predictive accuracy is claimed.

## 11. Author and acknowledgement

**Supreet Jayant Tarwarkar** — PostgreSQL adaptation, Google Colab execution, analytical validation, Power BI implementation and custom forest-and-sage visual design.

[GitHub](https://github.com/SupreetTarwarkar) · [LinkedIn](https://www.linkedin.com/in/supreettarwarkar/)

**Guided by:** [Mansi Goel — original IKEA tutorial and project](https://github.com/the-mansi-goel/IKEA). This project identifies the guided source and distinguishes the tutorial methodology from the independent implementation and redesign.

**Data:** UCI Online Retail II (Daqing Chen). Respect source attribution and applicable usage terms.
