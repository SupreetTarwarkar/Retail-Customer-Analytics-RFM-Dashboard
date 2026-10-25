-- 01: Source staging, validation, and combination (PostgreSQL)
-- Load each original source CSV into the matching staging table using pgAdmin Import/Export.
CREATE TABLE retail_2009_2010 (
    invoice TEXT,
    stockcode TEXT,
    description TEXT,
    quantity INTEGER,
    invoicedate TEXT,
    price TEXT,
    customer_id TEXT,
    country TEXT
);

CREATE TABLE retail_2010_2011 (
    invoice TEXT,
    stockcode TEXT,
    description TEXT,
    quantity INTEGER,
    invoicedate TEXT,
    price TEXT,
    customer_id TEXT,
    country TEXT
);

SELECT
    (SELECT COUNT(*) FROM retail_2009_2010) AS rows_2009_2010,
    (SELECT COUNT(*) FROM retail_2010_2011) AS rows_2010_2011,
    (SELECT COUNT(*) FROM retail_2009_2010) + (SELECT COUNT(*) FROM retail_2010_2011) AS total_rows;

CREATE TABLE retail_combined AS
SELECT invoice, stockcode, description, quantity,
    TO_TIMESTAMP(NULLIF(TRIM(invoicedate), ''), 'DD-MM-YYYY HH24:MI')::TIMESTAMP AS invoicedate,
    NULLIF(TRIM(price), '')::NUMERIC(10,2) AS price,
    customer_id, country, '2009-2010' AS sourcesheet
FROM retail_2009_2010
UNION ALL
SELECT invoice, stockcode, description, quantity,
    TO_TIMESTAMP(NULLIF(TRIM(invoicedate), ''), 'DD-MM-YYYY HH24:MI')::TIMESTAMP AS invoicedate,
    NULLIF(TRIM(price), '')::NUMERIC(10,2) AS price,
    customer_id, country, '2010-2011' AS sourcesheet
FROM retail_2010_2011;

SELECT COUNT(*) AS total_rows,
    COUNT(invoicedate) AS valid_dates,
    COUNT(*)-COUNT(invoicedate) AS null_dates,
    COUNT(price) AS valid_prices,
    COUNT(*)-COUNT(price) AS null_prices,
    COUNT(*) FILTER(WHERE sourcesheet='2009-2010') AS rows_2009_2010,
    COUNT(*) FILTER(WHERE sourcesheet='2010-2011') AS rows_2010_2011
FROM retail_combined;
