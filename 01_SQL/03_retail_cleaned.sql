-- Remove exact duplicates and create the cleaned table
WITH Deduped AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY invoice, stockcode, description,
                         quantity, invoicedate, price,
                         customer_id, country
            ORDER BY (SELECT NULL)
        ) AS row_num
    FROM retail_combined
)
SELECT
    invoice, stockcode, description, quantity,
    invoicedate, price, customer_id, country, sourcesheet
INTO retail_cleaned
FROM Deduped
WHERE row_num = 1;

SELECT * FROM retail_cleaned;