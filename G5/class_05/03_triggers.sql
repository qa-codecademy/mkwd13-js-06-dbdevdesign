-- Triggers

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);

INSERT INTO products VALUES (1, 'Mouse', 10)

SELECT * FROM products;

UPDATE products
SET price = 14
WHERE product_id = 1

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER
AS
$$
	BEGIN
		NEW.updated_at = CURRENT_TIMESTAMP;
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER update_products_timestamp
	BEFORE UPDATE ON products
	FOR EACH ROW
	EXECUTE FUNCTION update_timestamp();

	
INSERT INTO products VALUES (2, 'Laptop', 100)

UPDATE products
SET price = 140
WHERE product_id = 2

-- TRIGGER 2

CREATE OR REPLACE FUNCTION validate_price_change()
RETURNS TRIGGER
AS
$$
	BEGIN
		-- Do not allow price to be reduced more than 50%
		IF NEW.price < (OLD.price * 0.5) THEN
			RAISE EXCEPTION 'Price can not be reduced by more than 50%%!';
		END IF;

		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER validate_product_price_change
	BEFORE UPDATE ON products
	FOR EACH ROW
	WHEN (NEW.price IS DISTINCT FROM OLD.price)
	EXECUTE FUNCTION validate_price_change();


UPDATE products
SET name = 'Amazing Laptop'
WHERE product_id = 2

SELECT * FROM products