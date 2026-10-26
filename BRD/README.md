# Business Requirements Document

**Project:** Retail Customer Analytics - RFM Segmentation & Churn Analysis  
**Prepared by:** Supreet Jayant Tarwarkar  
**Tools:** PostgreSQL, Python (Google Colab), Power BI

## Objective

Understand customer value, purchase frequency, revenue trends and churn status from historical retail transactions.

## Questions to answer

- Which segments contribute most to revenue?
- How many customers belong to each segment?
- Which customers are inactive under the 90-day rule?
- How do customer counts and revenue vary by month, quarter, year and country?

## Data and approach

- Combine two source datasets with **1,067,371** transaction rows.
- Clean and deduplicate in PostgreSQL, keeping **1,033,036** rows.
- Use Python to calculate RFM features for **5,881** customers.
- Prepare **779,495** enriched transaction rows for Power BI.
- Build a three-page report: **Home Page, Business Overview, RFM Analysis**.

## Required report features

Customer and revenue KPIs, six RFM segments, a readable Churn Status label, time and country slicers, bookmark navigation and a consistent color theme.

## Deliverables

SQL scripts, Google Colab notebook, three-page Power BI dashboard, GitHub documentation and numerical findings.

## Scope

Historical descriptive reporting with a fixed **Recency > 90 days** churn rule. Predictive churn modelling and marketing-campaign execution are not included.

<sub><em>Independent educational portfolio project using the UCI Online Retail II dataset. The Dunelm-inspired visual styling is illustrative only; this is not Dunelm company data, and the project is not affiliated with or endorsed by Dunelm.</em></sub>

## Tutorial reference

Based on the tutorial by [Mansi Goel](https://www.youtube.com/@Mansi.goel.offical).

**Original tutorial video:** [SQL, Python and Power BI project](https://www.youtube.com/watch?v=LQa0SiuZfhA&t=272s).

[Back to the main README](../README.md)
