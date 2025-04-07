-- Create a sample table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(8,2),
    category VARCHAR(50),
    stock_count INTEGER,
    last_restock_date DATE,
    description TEXT
);

-- Insert sample data
INSERT INTO products VALUES
    (1, 'Laptop Pro', 1200.00, 'Electronics', 5, '2024-01-15', 'High-end laptop'),
    (2, 'Office Chair', 199.99, 'Furniture', 12, '2024-02-01', NULL),
    (3, 'Coffee Maker', 79.99, 'Appliances', 8, '2024-01-20', 'Automatic drip'),
    (4, 'Gaming Mouse', 59.99, 'Electronics', 15, NULL, 'RGB gaming mouse'),
    (5, 'Desk Lamp', 25.00, 'Furniture', 20, '2024-02-10', 'LED desk lamp'),
    (6, 'Keyboard', 89.99, 'Electronics', 0, '2024-01-10', 'Mechanical keyboard');

SELECT * FROM products

-- NULL value filtering
SELECT * FROM products
WHERE description IS NULL

SELECT * FROM products
WHERE last_restock_date IS NOT NULL

-- NOT operator
SELECT * FROM products
WHERE NOT category = 'Furniture'

SELECT * FROM products
WHERE category != 'Furniture'

SELECT * FROM products
WHERE category <> 'Furniture'

-- Pattern matching (ILIKE) with multiple patterns
SELECT * FROM products
WHERE
	name ILIKE '%pro%'
	OR
	description ILIKE '%gaming%'

-- BETWEEN with dates
SELECT * FROM products
WHERE last_restock_date
BETWEEN '2024-01-01' AND '2024-01-31'

-- Complex IN statement
SELECT * FROM products
WHERE category IN ('Electronics', 'Appliances')
	AND stock_count > 0;

-- Combining different conditions
SELECT * FROM products
WHERE
	(category = 'Electronics' AND price > 100)
	OR
	(category = 'Furniture' AND stock_count > 10)