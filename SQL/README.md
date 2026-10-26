# SQL - PostgreSQL

PostgreSQL and pgAdmin 4 were used to import the two retail datasets, combine them, check data quality and remove exact duplicates.

| Script | What it does |
|---|---|
| [01_Data_Import_and_Combination.sql](01_Data_Import_and_Combination.sql) | Creates the staging tables, combines both files using `UNION ALL` and converts date/price columns |
| [02_ecommerce_customer_analytics.sql](02_ecommerce_customer_analytics.sql) | Checks missing customer IDs, nonpositive quantities, missing descriptions and duplicate transactions |
| [03_retail_cleaned.sql](03_retail_cleaned.sql) | Uses `ROW_NUMBER()` to keep one row from each duplicate group |

### SQL Server / SSMS vs PostgreSQL / pgAdmin - differences in this project

These are the differences encountered while recreating Mansi Goel's SQL workflow. Shared SQL features such as `UNION ALL`, `GROUP BY`, `HAVING`, `ROW_NUMBER()`, and `SELECT INTO` are already demonstrated in the scripts and are not listed as dialect differences.

| Project step | Original tutorial: SQL Server / SSMS | Our implementation: PostgreSQL / pgAdmin 4 |
|---|---|---|
| Import both retail CSVs | SQL Server import workflow | Created two staging tables and imported the CSV files through pgAdmin |
| Create combined transactions | `SELECT ... INTO dbo.RetailCombined` | `CREATE TABLE retail_combined AS SELECT ... UNION ALL ...` |
| Convert invoice dates | `COALESCE(TRY_CONVERT(datetime2, InvoiceDate, 120), TRY_CONVERT(datetime2, InvoiceDate, 105))` | `TO_TIMESTAMP(NULLIF(TRIM(invoicedate), ''), 'DD-MM-YYYY HH24:MI')::TIMESTAMP` |
| Convert text prices | `TRY_CONVERT(decimal(10,2), Price)` | `NULLIF(TRIM(price), '')::NUMERIC(10,2)` |
| Export the cleaned CSV | SQL Server / SSMS export workflow | Used PostgreSQL server-side `COPY ... WITH (FORMAT CSV, HEADER TRUE)` |

The SQL Server conversion examples above come from the instructor's published project documentation; our exact PostgreSQL expressions appear in [01_Data_Import_and_Combination.sql](01_Data_Import_and_Combination.sql). The `COPY` export was part of our completed workflow but is not included in the three published SQL scripts.

### Result

**1,067,371 combined transactions** were checked and reduced to **1,033,036 records** after removing **34,335** extra duplicate rows.

**Related tutorial section:** [SQL setup and analysis](https://www.youtube.com/watch?v=LQa0SiuZfhA)

[Back to the main README](../README.md)
