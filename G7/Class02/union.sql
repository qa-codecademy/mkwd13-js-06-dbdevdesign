-- Create sample tables for set operations
CREATE TABLE sales_2023 (
    product_name VARCHAR(100),
    amount DECIMAL(8,2)
);

CREATE TABLE sales_2024 (
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


SELECT * FROM sales_2023;

SELECT * FROM sales_2024;

-- UNION ALL EXAMPLE 1 (returns DUPLICATES)
SELECT product_name FROM sales_2023
UNION ALL
SELECT product_name FROM sales_2024;

-- UNION EXAMPLE 2 (eliminate DUPLICATES)
SELECT product_name FROM sales_2023
UNION
SELECT product_name FROM sales_2024;

-- UNION EXAMPLE 3 (INTERSECT)
SELECT product_name FROM sales_2023
INTERSECT
SELECT product_name FROM sales_2024;