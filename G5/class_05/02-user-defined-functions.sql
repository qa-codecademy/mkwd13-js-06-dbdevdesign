-- Simple function

CREATE OR REPLACE FUNCTION calculate_discounted_price(price DECIMAL, discount_percentage DECIMAL)
RETURNS DECIMAL
AS
$$
	BEGIN
		RETURN price * (1 - discount_percentage / 100);
	END
$$
LANGUAGE plpgsql;

SELECT calculate_discounted_price(100, 20);
SELECT calculate_discounted_price(50.3, 15.6);

-- TABLE VALUED FUNCTIONS

CREATE OR REPLACE FUNCTION get_customer_orders(customer_id INTEGER)
RETURNS TABLE (
	order_id INTEGER,
	order_date DATE,
	total_amount DECIMAL,
	status TEXT
)
AS
$$
	BEGIN
		RETURN QUERY
		SELECT
			o.id,
			o.order_date,
			o.total_amount,
			o.status 
		FROM orders o
		WHERE o.customer_id = get_customer_orders.customer_id;
	END;
$$
LANGUAGE plpgsql

SELECT * from orders

SELECT * FROM get_customer_orders(1)

-- THROWING ERRORS

CREATE OR REPLACE FUNCTION safe_divide(numerator DECIMAL, denominator DECIMAL)
RETURNS DECIMAL
AS
$$
	BEGIN
		IF denominator = 0 THEN
			RAISE EXCEPTION 'Division by zero';
		END IF;
		RETURN numerator / denominator;
	END;
$$
LANGUAGE plpgsql;

SELECT safe_divide(6, 3)

SELECT safe_divide(10, 0)

-- Declaring variable and using arrays

CREATE OR REPLACE FUNCTION calculate_average(numbers DECIMAL[])
RETURNS DECIMAL
AS
$$
	DECLARE
		num DECIMAL;
		total INTEGER := 0;
		count INTEGER := 0;
	BEGIN
		FOREACH num IN ARRAY numbers
		LOOP
			total := total + num;
			count := count + 1;
		END LOOP;

		IF count = 0 THEN
			RETURN NULL;
		END IF;

		RETURN total / count;
	END;
$$
LANGUAGE plpgsql;


SELECT calculate_average(ARRAY[10, 10])



