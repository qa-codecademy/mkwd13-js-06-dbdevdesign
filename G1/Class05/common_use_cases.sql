-- =============================================
-- Common PostgreSQL Function Use Cases
-- =============================================

-- Create sample tables for demonstrations
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE,
    product_name VARCHAR(100),
    quantity INTEGER,
    unit_price DECIMAL(10,2),
    customer_email TEXT
);

CREATE TABLE inventory (
    product_name VARCHAR(100) PRIMARY KEY,
    stock_level INTEGER,
    last_updated TIMESTAMP
);

-- Insert sample data
INSERT INTO sales (sale_date, product_name, quantity, unit_price, customer_email) VALUES
('2024-01-15', 'Laptop', 2, 1299.99, 'john.doe@email.com'),
('2024-01-16', 'Mouse', 5, 24.99, 'jane.smith@email.com'),
('2024-01-16', 'Laptop', 1, 1299.99, 'bob.wilson@email.com'),
('2024-01-17', 'Keyboard', 3, 59.99, 'alice.brown@email.com'),
('2024-01-17', 'Monitor', 2, 299.99, 'charlie.davis@email.com'),
('2024-02-01', 'Laptop', 1, 1299.99, 'david.miller@email.com'),
('2024-02-02', 'Headphones', 4, 89.99, 'emma.wilson@email.com'),
('2024-02-03', 'Mouse', 3, 24.99, 'frank.thomas@email.com');

INSERT INTO inventory (product_name, stock_level, last_updated) VALUES
('Laptop', 15, '2024-03-01 10:00:00'),
('Mouse', 50, '2024-03-01 10:00:00'),
('Keyboard', 30, '2024-03-01 10:00:00'),
('Monitor', 20, '2024-03-01 10:00:00'),
('Headphones', 25, '2024-03-01 10:00:00');