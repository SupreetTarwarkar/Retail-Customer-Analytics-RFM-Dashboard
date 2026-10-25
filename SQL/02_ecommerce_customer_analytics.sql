-- Check transactions with missing Customer IDs
SELECT COUNT(*) AS missing_customer_id
FROM retail_combined
WHERE customer_id IS NULL;

------------------------------------------------------------------------
-- Check transactions with negative or zero quantity
SELECT COUNT(*) AS negative_qty
FROM retail_combined
WHERE quantity <= 0;

------------------------------------------------------------------------
-- Check transactions with missing product descriptions
SELECT COUNT(*) AS missing_description
FROM retail_combined
WHERE description IS NULL;

------------------------------------------------------------------------
-- Identify exact duplicate transactions
SELECT
    invoice,
    stockcode,
    description,
    quantity,
    invoicedate,
    price,
    customer_id,
    country,
    COUNT(*) AS exact_duplicate_count
FROM retail_combined
GROUP BY
    invoice,
    stockcode,
    description,
    quantity,
    invoicedate,
    price,
    customer_id,
    country
HAVING COUNT(*) > 1;