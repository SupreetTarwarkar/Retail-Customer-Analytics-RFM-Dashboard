# Challenges & Learnings

This project was guided by [Mansi Goel](https://www.youtube.com/@Mansi.goel.offical), but I used a different setup for SQL and Python and made changes to the Power BI report.

## 1. Moving from SSMS to PostgreSQL

The tutorial uses SQL Server and SSMS. I worked in PostgreSQL with pgAdmin, so the import steps and conversion syntax were different. I created two staging tables, used `UNION ALL` to combine the data and handled dates with `TO_TIMESTAMP()`.

## 2. Cleaning the transaction data

The combined files contained **1,067,371 rows**. The quality checks covered customer IDs, quantities, descriptions and duplicates. After removing **34,335 extra duplicate rows**, the SQL cleaned table contained **1,033,036 rows**.

I also encountered a CSV encoding issue during import and used PostgreSQL's `COPY` command to export the large cleaned table successfully.

## 3. Working in Google Colab

Instead of Anaconda and local Jupyter Notebook, I used Google Colab to calculate RFM scores and create six customer segments. The final customer table covered **5,881 customers**.

## 4. Improving the Power BI report

I redesigned the Home Page using a forest-and-sage theme and worked on consistent titles, spacing, navigation buttons and visuals.

I also added a **Churn Status** label so the existing True / False churn flag appears as **Churned / Not Churned**. The underlying rule was not changed.

## 5. Keeping the analysis useful

A useful dashboard needs more than charts. This project helped me check totals at each stage, understand the difference between transaction rows and customer counts, and present customer value and churn in a way that is easier to discuss.

[Back to the main README](../README.md)
