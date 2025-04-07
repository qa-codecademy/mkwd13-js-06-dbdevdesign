
-- NULL / NOT NULL constraints
CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	age SMALLINT
)

SELECT * FROM students

-- Valid data insert
INSERT INTO students VALUES (1, 'John', 'Doe', 'john@doe.com', 20)

-- Invalid data because of NULL values
INSERT INTO students VALUES (2, 'Jane', NULL, 'jane@mail.com')
INSERT INTO students VALUES (2, 'Jane', 'Doe', NULL)


-- UNIQUE constraints
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	email VARCHAR(50) NOT NULL UNIQUE,
	username VARCHAR(50) NOT NULL UNIQUE
)

SELECT * FROM users

-- Data insert
INSERT INTO users VALUES (1, 'john@mail.com', 'john1')
INSERT INTO users VALUES (2, 'john2@mail.com', 'john2')
INSERT INTO users VALUES (3, 'john3@mail.com', 'john3')


-- Check constratints
CREATE TABLE products_with_constraints(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	price DECIMAL(8,2) CHECK (price > 0),
	stock_count INTEGER CHECK (stock_count >= 0),
	category VARCHAR(50) CHECK (category IN ('Electronics', 'Furniture', 'Appliances'))
)

SELECT * FROM products_with_constraints

INSERT INTO products_with_constraints VALUES (1, 'TV', 100, 1, 'Electronics')

INSERT INTO products_with_constraints VALUES (2, 'Playstation', 10, 2, 'Appliances')

-- Default values for columns
CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	product_name VARCHAR(100) NOT NULL,
	quantity INTEGER DEFAULT 1,
	order_date DATE DEFAULT CURRENT_DATE,
	status VARCHAR(20) DEFAULT 'Pending'
)

SELECT * FROM orders

INSERT INTO orders (product_name) VALUES ('banana')
