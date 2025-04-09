-- Create sample tables for set operations
CREATE TABLE sales_2023 (
    product_name VARCHAR(100),
    amount DECIMAL(8,2)
);

CREATE TABLE sales_2024 (
    product_name VARCHAR(100),
    amount DECIMAL(8,2)
);

CREATE TABLE sales_2025 (
    product_name VARCHAR(100),
    amount DECIMAL(8,2)
);

-- Insert sample data
INSERT INTO sales_2023 VALUES
    ('Laptop', 1200.00),
    ('Mouse', 25.99),
    ('Keyboard', 89.99);

INSERT INTO sales_2024 VALUES
    ('Laptop', 1299.99),
    ('Mouse', 29.99),
    ('Monitor', 299.99);

INSERT INTO sales_2025 VALUES
    ('Glass', 2299.99),
    ('Mouse', 29.99),
    ('Monitor', 299.99);
	

-- UNION - without duplicates
SELECT product_name FROM sales_2023
UNION
SELECT product_name FROM sales_2024

-- Union with more than 2 tables
SELECT product_name FROM sales_2023
UNION
SELECT product_name FROM sales_2024
UNION
SELECT product_name FROM sales_2025

-- Union with duplicates
SELECT product_name FROM sales_2023
UNION ALL
SELECT product_name FROM sales_2024

-- Intersect - common products
SELECT product_name FROM sales_2023
INTERSECT
SELECT product_name FROM sales_2024

-- EXCEPT - products only in 2023
SELECT product_name FROM sales_2023
EXCEPT
SELECT product_name FROM sales_2024

-- EXCEPT - products only in 2024
SELECT product_name FROM sales_2024
EXCEPT
SELECT product_name FROM sales_2023

-- Combining Union and Where

SELECT product_name, amount, '2023' as year
FROM sales_2023
WHERE amount > 100
UNION
SELECT product_name, amount, '2024' as year
FROM sales_2024
WHERE amount > 100
ORDER BY amount DESC
