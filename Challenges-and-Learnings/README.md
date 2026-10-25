# Challenges & Learnings

Based on the tutorial by [Mansi Goel](https://www.youtube.com/@Mansi.goel.offical), with a different setup for SQL and Python and changes to the Power BI report.

## 1. Moving from SSMS to PostgreSQL

The tutorial uses SQL Server and SSMS. This project uses PostgreSQL with pgAdmin, requiring different import steps and conversion syntax. Two staging tables were created, `UNION ALL` combined the data, and `TO_TIMESTAMP()` handled date conversion.

## 2. Cleaning the transaction data

The combined files contained **1,067,371 rows**. The quality checks covered customer IDs, quantities, descriptions and duplicates. After removing **34,335 extra duplicate rows**, the SQL cleaned table contained **1,033,036 rows**.

A CSV encoding issue arose during import. PostgreSQL's `COPY` command was used to export the cleaned table.

## 3. Working in Google Colab

Instead of Anaconda and local Jupyter Notebook, Google Colab was used to calculate RFM scores and create six customer segments. The final customer table covered **5,881 customers**.

## 4. Improving the Power BI report

The Home Page was redesigned with a forest-and-sage theme, consistent titles, spacing, navigation buttons and visuals.

A **Churn Status** label displays the existing True / False churn flag as **Churned / Not Churned**. The underlying rule was not changed.

## 5. Keeping the analysis useful

A useful dashboard needs more than charts. The process involved checking totals at each stage, distinguishing transaction rows from customer counts, and presenting customer value and churn in a clear, explainable format.

**Related tutorial sections:** [SQL (17:00)](https://www.youtube.com/watch?v=LQa0SiuZfhA&t=1020s) | [Python (34:40)](https://www.youtube.com/watch?v=LQa0SiuZfhA&t=2080s) | [Power BI (46:15)](https://www.youtube.com/watch?v=LQa0SiuZfhA&t=2775s)

[Back to the main README](../README.md)
