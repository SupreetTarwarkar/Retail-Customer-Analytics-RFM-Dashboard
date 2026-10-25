-- 02: Data quality profiling and identification of exact-value duplicate groups
SELECT COUNT(*) AS missing_customer_id
FROM retail_combined
WHERE customer_id IS NULL;

SELECT COUNT(*) AS negative_qty
FROM retail_combined
WHERE quantity <= 0;

SELECT COUNT(*) AS missing_description
FROM retail_combined
WHERE description IS NULL;

SELECT invoice, stockcode, description, quantity, invoicedate, price, customer_id, country,
       COUNT(*) AS exact_duplicate_count
FROM retail_combined
GROUP BY invoice, stockcode, description, quantity, invoicedate, price, customer_id, country
HAVING COUNT(*) > 1;
