# PostgreSQL SQL pipeline

This folder contains the project's three **original implementation stages**, numbered by execution order. It adapts the instructor's SQL Server/SSMS walkthrough to PostgreSQL + pgAdmin 4.

1. `01_Data_Import_and_Combination.sql` - creates two raw staging tables, checks source counts, appends with `UNION ALL`, parses dates and prices, and validates the combined table.
2. `02_ecommerce_customer_analytics.sql` - profiles missing IDs, nonpositive quantities, missing descriptions and exact-value duplicate groups.
3. `03_retail_cleaned.sql` - retains one record from each group of otherwise identical transaction values.

**Important:** The first script creates staging tables **but does not automatically load the CSV files**. Use pgAdmin Import/Export for the two files before executing the remainder.

### Saved row counts

| Stage | Rows |
|---|---:|
| Raw 2009–2010 | 541,910 |
| Raw 2010–2011 | 525,461 |
| Combined | 1,067,371 |
| Duplicate groups | 32,907 |
| Extra duplicate rows removed | 34,335 |
| Deduplicated | 1,033,036 |

### PostgreSQL-specific differences

- The original tutorial uses SQL Server `TRY_CONVERT` and `SELECT INTO` patterns. This project uses `TO_TIMESTAMP(...)`, `::NUMERIC` and PostgreSQL `SELECT ... INTO` / `CREATE TABLE ... AS`.
- Export with `COPY public.retail_cleaned TO 'D:/RetailCleaned.csv' WITH (FORMAT CSV, HEADER TRUE);` when PostgreSQL has file-system permission. The path is server-side, not a universal setup path.
- Export with headers; let Pandas infer them instead of the instructor's `header=None` workflow.
- The exact-duplicate window orders rows arbitrarily. If otherwise duplicate rows differ in `sourcesheet`, its retained source label is not deterministic. Do not use `sourcesheet` for year analysis without validating the original source mapping.

### SQL review notes

The repository preserves the author's submitted SQL rather than silently changing production logic. The staging imports, source-file encoding and date formats must be validated before rerunning; the SQL scripts are **not** written to be safely rerunnable after tables already exist.

### Guided tutorial reference

[Watch the complete SQL, Python and Power BI tutorial](https://youtu.be/LQa0SiuZfhA) by [Mansi Goel](https://www.youtube.com/@Mansi.goel.offical).
