-- Create necessary tables and insert sample data
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id INTEGER REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    category_id INTEGER REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    address JSONB
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Insert sample data
INSERT INTO categories (name, parent_id) VALUES
('Electronics', NULL),
('Computers', 1),
('Laptops', 2),
('Smartphones', 1),
('Accessories', 1),
('Audio', 5),
('Video', 5);

INSERT INTO products (name, price, stock, category_id) VALUES
('MacBook Pro 16"', 2499.99, 10, 3),
('Dell XPS 15', 1799.99, 15, 3),
('iPhone 15 Pro', 999.99, 20, 4),
('Samsung Galaxy S24', 899.99, 18, 4),
('AirPods Pro', 249.99, 30, 6),
('Sony WH-1000XM5', 399.99, 12, 6),
('Logitech MX Master 3S', 99.99, 25, 5);

INSERT INTO customers (first_name, last_name, email, phone, address) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', 
 '{"street": "123 Main St", "city": "New York", "zip": "10001"}'),
('Jane', 'Smith', 'jane.smith@example.com', '2345678901',
 '{"street": "456 Oak Ave", "city": "Los Angeles", "zip": "90001"}'),
('Bob', 'Johnson', 'bob.johnson@example.com', '3456789012',
 '{"street": "789 Pine St", "city": "Chicago", "zip": "60601"}');

INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2024-03-01', 2499.99, 'completed'),
(1, '2024-03-15', 399.99, 'completed'),
(2, '2024-03-10', 1799.99, 'completed'),
(3, '2024-03-20', 999.99, 'pending');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 2499.99),
(2, 6, 1, 399.99),
(3, 2, 1, 1799.99),
(4, 3, 1, 999.99);