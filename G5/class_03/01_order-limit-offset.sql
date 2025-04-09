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


-- Ordering of data

SELECT * 
FROM sales
ORDER BY quantity DESC

SELECT * 
FROM sales
ORDER BY amount DESC

SELECT * 
FROM sales
ORDER BY sale_date ASC

-- Limiting
SELECT *
FROM sales
ORDER BY quantity DESC
LIMIT 2

-- Skipping
SELECT *
FROM sales
ORDER BY quantity DESC
LIMIT 3 OFFSET 3