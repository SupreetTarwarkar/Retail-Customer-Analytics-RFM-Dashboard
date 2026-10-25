# SQL - PostgreSQL

PostgreSQL and pgAdmin 4 were used to import the two retail datasets, combine them, check data quality and remove exact duplicates.

| Script | What it does |
|---|---|
| [01_Data_Import_and_Combination.sql](01_Data_Import_and_Combination.sql) | Creates the staging tables, combines both files using `UNION ALL` and converts date/price columns |
| [02_ecommerce_customer_analytics.sql](02_ecommerce_customer_analytics.sql) | Checks missing customer IDs, nonpositive quantities, missing descriptions and duplicate transactions |
| [03_retail_cleaned.sql](03_retail_cleaned.sql) | Uses `ROW_NUMBER()` to keep one row from each duplicate group |

### SQL differences from the tutorial

| Tutorial - SSMS / SQL Server | PostgreSQL implementation |
|---|---|
| SQL Server database and import wizard | PostgreSQL tables and pgAdmin CSV import |
| SQL Server date conversion | `TO_TIMESTAMP(...)` |
| SQL Server type conversion | `NULLIF(TRIM(price), '')::NUMERIC(10,2)` |
| Append the two datasets | `UNION ALL` |
| Check grouped data | `GROUP BY`, `COUNT(*)`, `HAVING` |
| Remove duplicates | `ROW_NUMBER() OVER (PARTITION BY ...)` |
| Export the cleaned table | PostgreSQL `COPY ... WITH (FORMAT CSV, HEADER TRUE)` |

### Result

**1,067,371 combined transactions** were checked and reduced to **1,033,036 records** after removing **34,335** extra duplicate rows.

[Watch the SQL section (17:00)](https://www.youtube.com/watch?v=LQa0SiuZfhA&t=1020s)

[Back to the main README](../README.md)
