# Retail Customer Analytics Dashboard

**RFM Segmentation | Customer Churn | Revenue Analysis**

**Tools:** PostgreSQL, Python (Google Colab), Power BI

**[View Interactive Power BI Dashboard](https://app.powerbi.com/view?r=eyJrIjoiZDYwY2Y1NTEtNTVkMS00NTFlLWFlM2YtYmRjN2E3N2RjZWVjIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)**

## 1. Overview

This project analyzes customer purchasing behavior using two years of retail transaction data. PostgreSQL was used to combine and clean the data, Python for RFM segmentation and churn analysis, and Power BI for a three-page dashboard covering customer value, churn and revenue trends.

Based on the guided project by [Mansi Goel](https://www.youtube.com/@Mansi.goel.offical), with adjustments to the tools, dashboard layout, theme and churn labels. [Watch the tutorial from the beginning](https://www.youtube.com/watch?v=LQa0SiuZfhA&t=0s).

## 2. Business questions

- Which customer groups bring in the most revenue?
- How many customers are in each segment?
- Which customers have stopped purchasing?
- How do customer activity and revenue change across months, quarters and countries?

## 3. Tools used

| Tool | Purpose | Project files |
|---|---|---|
| PostgreSQL / pgAdmin | Imported both datasets, combined transactions, checked data quality and removed duplicates | [Import & combination](SQL/01_Data_Import_and_Combination.sql), [data quality checks](SQL/02_ecommerce_customer_analytics.sql), [cleaning & deduplication](SQL/03_retail_cleaned.sql) |
| Python / Google Colab | Calculated RFM scores, built six customer segments and flagged churned customers | [Google Colab notebook](Python/Dunelm_RFM_Segmentation.ipynb) |
| Power BI | Built KPIs, segment comparisons, trends, slicers and navigation | [Interactive report](https://app.powerbi.com/view?r=eyJrIjoiZDYwY2Y1NTEtNTVkMS00NTFlLWFlM2YtYmRjN2E3N2RjZWVjIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9), [theme file](PBIX/Dunelm_Inspired_Retail_Light_Theme.json) |

### Changes from the tutorial

| Task | Purpose | Tutorial | This project |
|---|---|---|---|
| SQL | Data import and cleaning | SQL Server Express + SSMS | PostgreSQL + pgAdmin 4 |
| Python | RFM scoring and segmentation | Anaconda + Jupyter Notebook | Google Colab |
| Power BI | Dashboard and reporting | IKEA-themed dashboard | Forest-and-sage design with a new Home Page |

*Note: The churn labels are displayed as Churned / Not Churned instead of True / False for readability. The churn calculation remains unchanged.*

## 4. Data and analysis

The project uses the [Online Retail II dataset](https://archive.ics.uci.edu/dataset/502/online+retail+ii), containing sales transactions from December 2009 to December 2011.

| Stage | Records |
|---|---:|
| Two original datasets combined | **1,067,371** |
| After duplicate removal | **1,033,036** |
| Final Power BI dataset | **779,495** |
| Customers analyzed using RFM | **5,881** |

RFM stands for **Recency, Frequency and Monetary**. Customers were grouped into **Champions, Loyal, At Risk, New, Needs Attention and Lost**. Customers with more than **90 days** since their last purchase were marked as churned.

**Analysis screenshots:** [PostgreSQL data cleaning](Images/4.%20Data%20Cleaning%20%26%20Deduplication.png) | [Python RFM segmentation](Images/5.%20Python_RFM_Segmentation_Churn_Analysis.png)

## 5. Dashboard pages

### Home Page

A starting page with direct navigation to Business Overview and RFM Analysis, plus a short glossary of the main customer metrics.

![Home Page](Images/1.%20Home%20Page.png)

### Business Overview

Shows **Total Customers, Total Revenue, Churned % and Average Customer Value**. It also includes customer and revenue comparisons by segment, charts by month/quarter/year, and filters for time, country, segment and churn.

![Business Overview](Images/2.%20Business%20Overview.png)

### RFM Analysis

Looks more closely at customer segments and countries. It includes performance summary tables, average R/F/M scores, customer value comparisons and churn trends.

![RFM Analysis](Images/3.%20RFM%20Analysis.png)

[Explore the interactive Power BI report](https://app.powerbi.com/view?r=eyJrIjoiZDYwY2Y1NTEtNTVkMS00NTFlLWFlM2YtYmRjN2E3N2RjZWVjIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9) | [Power BI dashboard details](PBIX/README.md)

## 6. Key findings

**1. Revenue is concentrated among Champions.** The **1,291 Champions** generated around **$11.84M**, or **68.13%** of the revenue shown in the dashboard. This is the group to monitor most closely when planning loyalty or retention activity.

**2. A large share of customers are inactive.** Of **5,881 customers**, the churn indicator shows **50.9%** as churned under the 90-day rule. That makes retention and reactivation worth reviewing, alongside new customer acquisition.

**3. The segment sizes tell different stories.** **Lost** is the largest group with **1,524 customers**, followed by **Loyal (1,416)** and **Champions (1,291)**. The largest customer group is not automatically the most valuable one, so customer counts and revenue need to be viewed together.

**4. Revenue increases in the fourth quarter.** Total reported revenue is about **$6.16M in Q4**, compared with **$3.37M in Q1**. This is a useful pattern to explore when planning inventory, customer outreach and seasonal campaigns.

## 7. Dashboard features

- Three connected report pages with navigation buttons
- Customer and revenue views switched using bookmarks
- Segment and country comparisons
- Monthly, quarterly and yearly trends
- Filters and clear-slicer controls
- Custom forest-green and sage theme

## 8. Challenges & Learnings

The main implementation challenges, including PostgreSQL differences, data cleaning, Colab and Power BI formatting, are covered in [Challenges & Learnings](Challenges-and-Learnings/README.md).

## 9. Acknowledgement

This project follows the end-to-end SQL, Python and Power BI tutorial by [Mansi Goel](https://www.youtube.com/@Mansi.goel.offical), adapted for PostgreSQL, Google Colab and a redesigned Power BI dashboard.

- [Guided project](https://www.youtube.com/watch?v=LQa0SiuZfhA&t=0s)
- [Mansi G. YouTube channel](https://www.youtube.com/@Mansi.goel.offical)
- [Mansi G. - Original GitHub project and resources](https://github.com/the-mansi-goel/IKEA)

## 10. Author

**Supreet Jayant Tarwarkar**

- [GitHub](https://github.com/SupreetTarwarkar)
- [LinkedIn](https://www.linkedin.com/in/supreettarwarkar/)
