-- UNION, UNION ALL and INTERSECT
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