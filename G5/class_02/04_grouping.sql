-- Create a sample sales table
CREATE TABLE sales (
    id INTEGER,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sale_date DATE,
    amount DECIMAL(8,2),
    quantity INTEGER
);

-- Insert sample data
INSERT INTO sales VALUES
    (1, 'Laptop', 'Electronics', '2024-01-15', 1200.00, 1),
    (2, 'Mouse', 'Electronics', '2024-01-15', 25.99, 2),
    (3, 'Desk', 'Furniture', '2024-01-16', 299.99, 1),
    (4, 'Laptop', 'Electronics', '2024-01-17', 1200.00, 2),
    (5, 'Chair', 'Furniture', '2024-01-17', 199.99, 4),
    (6, 'Mouse', 'Electronics', '2024-01-18', 25.99, 3);

-- Basic GROUP BY

SELECT category, COUNT(category) AS total_sales
FROM sales
GROUP BY category

-- Multiple columns grouping

SELECT category, product_name, COUNT(*) as times_sold
FROM sales
GROUP BY category, product_name

-- GROUP BY with aggregate functions

SELECT
	category,
	product_name,
	SUM(amount) as total_amount,
	SUM(quantity) as total_quantity,
	COUNT(*) as number_of_sales,
	AVG(amount) as average_sale,
	MAX(amount) as highest_sale,
	MIN(amount) as lowest_sale
FROM sales
GROUP BY category, product_name

-- GROUP BY with date
SELECT
	sale_date,
	SUM(amount) as daily_total
FROM sales
GROUP BY sale_date;