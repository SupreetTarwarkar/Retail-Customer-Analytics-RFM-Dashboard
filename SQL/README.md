# SQL - PostgreSQL

PostgreSQL and pgAdmin 4 were used to import the two retail datasets, combine them, check data quality and remove exact duplicates.

| Script | What it does |
|---|---|
| [01_Data_Import_and_Combination.sql](01_Data_Import_and_Combination.sql) | Creates the staging tables, combines both files using `UNION ALL` and converts date/price columns |
| [02_ecommerce_customer_analytics.sql](02_ecommerce_customer_analytics.sql) | Checks missing customer IDs, nonpositive quantities, missing descriptions and duplicate transactions |
| [03_retail_cleaned.sql](03_retail_cleaned.sql) | Uses `ROW_NUMBER()` to keep one row from each duplicate group |

### SQL Server vs PostgreSQL - syntax used in this project

The original tutorial uses SQL Server Management Studio (SSMS). This implementation runs on PostgreSQL using pgAdmin 4. The three SQL scripts above contain the PostgreSQL code.

| Operation | SQL Server / SSMS equivalent | PostgreSQL used here |
|---|---|---|
| Database import | SQL Server Import Flat File / Import Data wizard | Create staging tables with `CREATE TABLE`, then import CSVs through pgAdmin |
| Create a combined table | `SELECT ... INTO new_table FROM ...` | `CREATE TABLE retail_combined AS SELECT ...` |
| Parse date text | `CONVERT(DATETIME, ...)` / `TRY_CONVERT(...)` with a suitable input style | `TO_TIMESTAMP(NULLIF(TRIM(invoicedate), ''), 'DD-MM-YYYY HH24:MI')::TIMESTAMP` |
| Convert price text to a decimal | `CAST(NULLIF(TRIM(price), '') AS DECIMAL(10,2))` | `NULLIF(TRIM(price), '')::NUMERIC(10,2)` |
| Conditional record counts | `SUM(CASE WHEN condition THEN 1 ELSE 0 END)` | `COUNT(*) FILTER (WHERE condition)` |
| Append datasets without deduplication | `UNION ALL` | `UNION ALL` |
| Find duplicates | `GROUP BY ... HAVING COUNT(*) > 1` | Same SQL syntax |
| Assign a row number within duplicate groups | `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)` | Same window-function syntax |
| Save selected rows to a new table | `SELECT ... INTO table_name FROM ...` | `SELECT ... INTO retail_cleaned FROM Deduped WHERE row_num = 1` |
| Export CSV | SSMS Export Wizard or `bcp` | PostgreSQL `COPY` or pgAdmin Export |

**Notes:** `UNION ALL`, `COUNT(*)`, `GROUP BY`, `HAVING`, `WITH` (CTE) and `ROW_NUMBER()` are supported by both database systems; they are not PostgreSQL-specific features. The `COPY` export step is described in the workflow but is not included in the three published SQL scripts.

### Result

**1,067,371 combined transactions** were checked and reduced to **1,033,036 records** after removing **34,335** extra duplicate rows.

**Related tutorial section:** [SQL setup and analysis](https://www.youtube.com/watch?v=LQa0SiuZfhA)

[Back to the main README](../README.md)
