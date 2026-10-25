-- 03: Deduplicate exact-value rows and retain original source label.
-- Run once after 01 and 02; retail_cleaned must not already exist.
WITH Deduped AS (
    SELECT *,
           ROW_NUMBER() OVER (
             PARTITION BY invoice, stockcode, description,
                          quantity, invoicedate, price, customer_id, country
             ORDER BY (SELECT NULL)
           ) AS row_num
    FROM retail_combined
)
SELECT invoice, stockcode, description, quantity,
       invoicedate, price, customer_id, country, sourcesheet
INTO retail_cleaned
FROM Deduped
WHERE row_num = 1;

SELECT * FROM retail_cleaned;
