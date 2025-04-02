-- Creating tables

CREATE TABLE IF NOT EXISTS users (
	id INTEGER,
	username VARCHAR(50),
	email VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS products (
	id INTEGER,
	name VARCHAR(100),
	price DECIMAL(10, 2)
);

-- Selecting table data

SELECT * FROM users;
SELECT * FROM customers;
SELECT * FROM products;

-- Updating tables

ALTER TABLE users
ADD COLUMN phone VARCHAR(15);

ALTER TABLE users
DROP COLUMN phone;

ALTER TABLE users
RENAME COLUMN username TO user_name;

ALTER TABLE users
RENAME TO customers;

-- deleting tables
DROP TABLE IF EXISTS customers;

DROP TABLE IF EXISTS
	products,
	users;

-- Inserting data

CREATE TABLE books (
	id INTEGER,
	title VARCHAR(100),
	description TEXT,
	price DECIMAL(6,2),
	page_count INTEGER,
	is_hardcover BOOLEAN, 
	publication_date DATE
)

INSERT INTO books VALUES 
	(1, 'Book 1', 'Nice book', 19.99, 120, true, '2025-01-01');

SELECT * FROM books;

INSERT INTO books VALUES
	(2, 'Book 2', 'Nice book', 29.99, 122, true, '2025-01-02'),
	(3, 'Book 3', 'Very Nice book', 22.99, 123, false, '2025-01-02');

INSERT INTO books (id, title, price)
		   VALUES (4, 'fourth book', 12.30);

INSERT INTO books (id, title, description, price)
		   VALUES (5, 'fourth book', 'some desc', 12.30),
		   		  (5, 'fourth book', NULL, 12.30);

INSERT INTO books (id, title) VALUES ('dsadas', 12312)
INSERT INTO books (id, price) VALUES (321, 12.83)

-- Update data
UPDATE books
SET description = 'fixed'
WHERE id = 4

UPDATE books
SET
	price = 10.99,
	page_count = 100
WHERE id = 2

UPDATE books
SET description = 'cheep book'
WHERE price < 13

-- Delete data

DELETE FROM books
WHERE id = 321;

-- Autoincrement ID

CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL
)

DROP TABLE products

INSERT INTO products (name) VALUES ('shirt'), ('book'), ('blanket');

INSERT INTO products (name) VALUES ('test');

INSERT INTO products (name) VALUES ('car');

SELECT * FROM products
