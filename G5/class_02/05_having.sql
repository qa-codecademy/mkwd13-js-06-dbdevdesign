-- Using the same sales table from previous example

-- Basic HAVING

SELECT
	category,
	COUNT(*) as sale_count
FROM sales
GROUP BY category
HAVING COUNT(*) > 2

-- HAVING with SUM

SELECT
	product_name,
	SUM(amount) as total_sales
FROM sales
GROUP BY product_name
HAVING SUM(amount) > 1000

-- Multiple conditions in HAVING

SELECT
	category,
	COUNT(*) as sale_count,
	SUM(quantity) as total_items
FROM sales
GROUP BY category
HAVING COUNT(*) >= 2 AND SUM(quantity) > 5

-- Combining WHERE and HAVING

SELECT
	product_name,
	SUM(amount) as total_amount
FROM sales
WHERE sale_date >= '2024-01-17'
GROUP BY product_name
HAVING SUM(amount) > 100

SELECT
	product_name,
	SUM(amount) as total_amount
FROM sales
WHERE product_name = 'Mouse'
GROUP BY product_name
HAVING SUM(amount) > 2
	
-- HAVING with multiple aggregate functions

SELECT
	category,
	COUNT(*) as sale_count,
	AVG(amount) as avg_sale
FROM sales
GROUP BY category
HAVING COUNT(*) > 2 AND AVG(amount) > 100