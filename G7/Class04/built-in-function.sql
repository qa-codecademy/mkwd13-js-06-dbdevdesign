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

-- Concat, Make concatanation between two or more columns
SELECT CONCAT(first_name, ' ' ,last_name) AS "fullName"
from actors;


-- String built in functions
SELECT 
name,
LENGTH(name) AS name_length,
TRIM(name) AS trimmed_name, -- trims a string from the beggining and end empty spaces (line in javascript)
UPPER(name) AS upper_cased,
LOWER(name) AS lower_cased,
SUBSTRING(name FROM 1 FOR 3) AS first_three_chars
FROM products;


-- Replace
SELECT 
shipping_address,
REPLACE(shipping_address, 'City', 'Some new value') AS updated_address
FROM orders;

-- Numeric built-in functions
SELECT
name,
price,
ROUND(price) AS rounded_price,
CEIL(price) AS ceiled_price,
FLOOR(price) AS floored_price,
TRUNC(price, 1) AS trunced_price
FROM products;

SELECT 
	COUNT(*) AS total_count,
	SUM(price) AS total_price,
	AVG(price) as avarage_price,
	MIN(price) AS min_price,
	MAX(price) as max_price
FROM products;

-- Calculations
SELECT
price,
price * 0.5 AS discounted_price,
price * -100 AS negative_price_test,
ABS(price * -100) AS abs_price,
price / 2 AS divided_price
FROM products;

-- DATE/TIME
SELECT 
CURRENT_DATE AS today,
CURRENT_TIME AS now_time,
CURRENT_TIMESTAMP AS timestamp,
LOCALTIME AS local_time,
NOW() AS now