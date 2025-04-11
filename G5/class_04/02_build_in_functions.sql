-- Build in functions

-- Create sample tables for demonstrations
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    total_amount DECIMAL(10,2),
    customer_name VARCHAR(100),
    shipping_address TEXT
);

-- Insert sample data
INSERT INTO products (name, price, description) VALUES
('Laptop', 1299.99, 'High-performance laptop'),
('Mouse', 24.99, 'Wireless mouse'),
('Keyboard', 59.99, 'Mechanical keyboard'),
('Monitor', 299.99, '27-inch 4K display'),
('Headphones', 89.99, 'Noise-cancelling headphones');

INSERT INTO orders (order_date, total_amount, customer_name, shipping_address) VALUES
('2024-01-15', 1499.99, 'John Smith', '123 Main St, City'),
('2024-02-01', 399.98, 'Jane Doe', '456 Oak Ave, Town'),
('2024-02-15', 89.99, 'Bob Wilson', '789 Pine Rd, Village'),
('2024-03-01', 2499.97, 'Alice Brown', '321 Elm St, City'),
('2024-03-15', 149.98, 'Charlie Davis', '654 Maple Dr, Town');


INSERT INTO orders (order_date, total_amount, customer_name, shipping_address) VALUES
('2024-01-15', 0, 'John Smith', '123 Main St, City')

INSERT INTO products (name, price, description) VALUES
('   Desktop Computer     ', 1299.99, 'High-performance desktop')

INSERT INTO products (name, price) VALUES
('Mobile phone', 399.99)

-- STRING FUNCTIONS

SELECT
	name,
	LENGTH(name) as name_length,
	TRIM(name),
	UPPER(name),
	LOWER(name)
FROM products

SELECT 
	shipping_address,
	REPLACE(shipping_address, 'City', 'Metropolis')
FROM orders

SELECT
	name,
	SUBSTRING(description FROM 1 FOR 5) || '...' as first_chars
FROM products

-- NUMERIC FUNCTIONS

SELECT
	price,
	ROUND(price),
	CEIL(price),
	FLOOR(price),
	TRUNC(price, 1) -- 1299.99 becomes 1299.9, 24.99 becomes 24.9
FROM products

SELECT
	price,
	ABS(price - 100),
	GREATEST(price, 100),
	LEAST(price, 100)
FROM products

-- DATE/TIME FUNCTIONS

SELECT
	CURRENT_DATE as today,
	CURRENT_TIME as now_time,
	CURRENT_TIMESTAMP as now_complete,
	LOCALTIME as local_time,
	LOCALTIMESTAMP as local_timestamp

-- CONDITIONAL FUNCTIONS

SELECT
	name,
	description,
	COALESCE(description, 'No description available') as safe_description
FROM products

SELECT total_amount,
	NULLIF(total_amount, 0) as non_zero_amount
FROM orders

-- TYPE CONVERSION FUNCTIONS

SELECT
	'123.45'::DECIMAL as total_decimal,
	'123'::INTEGER as to_integer,
	1::VARCHAR(10) as text
	
-- PRACTICAL COMBINATIONS

SELECT
	products.name,
	price,
	TO_CHAR(price, 'FM$999,999.00') as formatted_price,
	CASE
		WHEN price < 50 THEN 'Budget'
		WHEN price < 100 THEN 'Mid-range'
		ELSE 'Premium'
	END as price_category
FROM products