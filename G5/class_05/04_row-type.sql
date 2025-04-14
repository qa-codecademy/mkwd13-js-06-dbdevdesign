-- Row type

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INTEGER,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP
);

INSERT INTO products VALUES (1, 'Mouse', 10, 2)

-- Copy product

CREATE OR REPLACE FUNCTION copy_product(p_product_id INTEGER)
RETURNS INTEGER
AS
$$
	DECLARE
		product_record products%ROWTYPE;
		new_product_id INTEGER;
	BEGIN
		SELECT * INTO product_record
		FROM products
		WHERE product_id = 1;

		INSERT INTO products (name, price, stock)
		VALUES (
			product_record.name || '(Copy)',
			product_record.price,
			product_record.stock
		)
		RETURNING product_id INTO new_product_id;
		
		RETURN new_product_id;		
	END;
$$
LANGUAGE plpgsql;

SELECT * FROM products

SELECT copy_product(1)


-- Update multiple products

CREATE OR REPLACE FUNCTION update_multiple_products(
	p_product_ids INTEGER[],
	p_price_increase DECIMAL(10,2)
)
RETURNS INTEGER
AS
$$
	DECLARE
		product_record products%ROWTYPE;
		updated_count INTEGER := 0;
	BEGIN
		FOREACH product_record.product_id IN ARRAY p_product_ids
		LOOP
			SELECT * INTO product_record
			FROM products
			WHERE product_id = product_record.product_id;

			IF NOT FOUND THEN
			 	RAISE EXCEPTION 'Product not found.';
			END IF;

			UPDATE products
			SET price = product_record.price + p_price_increase
			WHERE product_id = product_record.product_id;

			updated_count := updated_count + 1;
		END LOOP;

		RETURN updated_count;
	END;
$$
LANGUAGE plpgsql;

SELECT * FROM products

SELECT update_multiple_products(ARRAY[5, 6, 7], 2)


-- Not Found

CREATE OR REPLACE FUNCTION update_product_if_exists(p_product_id INTEGER, p_new_price DECIMAL(10, 2))
RETURNS TEXT
AS
$$
	DECLARE
		product_record products%ROWTYPE;
	BEGIN
		SELECT * INTO product_record
		FROM products
		WHERE product_id = p_product_id;

		IF FOUND THEN
			UPDATE products
			SET price = p_new_price
			WHERE product_id = p_product_id;
		ELSE
			RETURN 'Product with ID: ' || p_product_id || ' not found.';
		END IF;

		RETURN 'All good!';
	END;
$$
LANGUAGE plpgsql;

SELECT update_product_if_exists(2, 156)

SELECT * FROM products