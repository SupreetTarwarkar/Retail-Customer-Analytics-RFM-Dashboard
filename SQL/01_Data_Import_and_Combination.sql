-- Create a table to store the first CSV dataset

CREATE TABLE retail_2009_2010 (
    invoice TEXT,          -- Invoice number
    stockcode TEXT,        -- Product code
    description TEXT,      -- Product name
    quantity INTEGER,      -- Number of items
    invoicedate TEXT,      -- Date stored as text initially
    price TEXT,            -- Price stored as text initially
    customer_id TEXT,      -- Customer ID
    country TEXT           -- Customer country
);

------------------------------------------------------------------------
-- Create a table to store the second CSV dataset
CREATE TABLE retail_2010_2011 (
    invoice TEXT,          -- Invoice number
    stockcode TEXT,        -- Product code
    description TEXT,      -- Product name
    quantity INTEGER,      -- Number of items
    invoicedate TEXT,      -- Date stored as text initially
    price TEXT,            -- Price stored as text initially
    customer_id TEXT,      -- Customer ID
    country TEXT           -- Customer country
);

------------------------------------------------------------------------
-- Check whether both CSV datasets were imported completely
SELECT
    (SELECT COUNT(*) FROM retail_2009_2010) AS rows_2009_2010, -- First table's rows
    (SELECT COUNT(*) FROM retail_2010_2011) AS rows_2010_2011, -- Second table's rows
    (SELECT COUNT(*) FROM retail_2009_2010)
    + (SELECT COUNT(*) FROM retail_2010_2011) AS total_rows;    -- Total rows

------------------------------------------------------------------------
-- Combine both datasets into one table and convert data types
CREATE TABLE retail_combined AS

SELECT
    invoice,
    stockcode,
    description,
    quantity,
    TO_TIMESTAMP(
        NULLIF(TRIM(invoicedate), ''), -- Remove spaces and handle empty dates
        'DD-MM-YYYY HH24:MI'          -- Format of dates in the CSV
    )::TIMESTAMP AS invoicedate,      -- Convert text into date/time
    NULLIF(TRIM(price), '')::NUMERIC(10,2) AS price, -- Convert text into decimal
    customer_id,
    country,
    '2009-2010' AS sourcesheet        -- Identify the source dataset
FROM retail_2009_2010

UNION ALL -- Append all rows without removing duplicates

SELECT
    invoice,
    stockcode,
    description,
    quantity,
    TO_TIMESTAMP(
        NULLIF(TRIM(invoicedate), ''), -- Remove spaces and handle empty dates
        'DD-MM-YYYY HH24:MI'          -- Format of dates in the CSV
    )::TIMESTAMP AS invoicedate,      -- Convert text into date/time
    NULLIF(TRIM(price), '')::NUMERIC(10,2) AS price, -- Convert text into decimal
    customer_id,
    country,
    '2010-2011' AS sourcesheet        -- Identify the source dataset
FROM retail_2010_2011;

------------------------------------------------------------------------
-- Check combined row count, missing values, and source-wise records
SELECT
    COUNT(*) AS total_rows,                      -- All records
    COUNT(invoicedate) AS valid_dates,           -- Dates that are not NULL
    COUNT(*) - COUNT(invoicedate) AS null_dates, -- Missing dates
    COUNT(price) AS valid_prices,                -- Prices that are not NULL
    COUNT(*) - COUNT(price) AS null_prices,      -- Missing prices
    COUNT(*) FILTER (
        WHERE sourcesheet = '2009-2010'
    ) AS rows_2009_2010,                        -- Rows from first dataset
    COUNT(*) FILTER (
        WHERE sourcesheet = '2010-2011'
    ) AS rows_2010_2011                         -- Rows from second dataset
FROM retail_combined;