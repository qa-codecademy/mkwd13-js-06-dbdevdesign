-- Constraints and Integrity

CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	discount_price DECIMAL(10,2) NULL NULL,
	stock_quantity INTEGER NOT NULL,
	weight_kg DECIMAL(8,3),

	-- Simple check constraint

	CONSTRAINT valid_price
		CHECK (price > 0),
		
	CONSTRAINT valid_stock
		CHECK (stock_quantity >= 0),

	CONSTRAINT valid_discount
		CHECK (discount_price IS NULL OR (discount_price > 0 AND discount_price < price)),

	CONSTRAINT valid_weight
		CHECK (weight_kg IS NULL OR (weight_kg > 0 AND weight_kg < 1000))
)

INSERT INTO products (name, price, discount_price, stock_quantity, weight_kg) VALUES
	('Laptop', 1000, 999, 10, 1)

INSERT INTO products (name, price, discount_price, stock_quantity, weight_kg) VALUES
	('Laptop', 1000, NULL, 10, 100)

SELECT * FROM products

-- Foreight key example

CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    budget DECIMAL(12,2),
    is_active BOOLEAN DEFAULT true
);

CREATE TABLE position (
    position_id SERIAL PRIMARY KEY,
    department_id INTEGER,
    title VARCHAR(100) NOT NULL,
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2),
    
    CONSTRAINT fk_department
        FOREIGN KEY (department_id) 
        REFERENCES department(department_id)
        ON DELETE CASCADE           -- Automatically delete positions when department is deleted
        ON UPDATE CASCADE          -- Automatically update department_id if parent id changes
);

