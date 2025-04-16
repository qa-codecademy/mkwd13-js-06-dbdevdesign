-- Create tables for our examples
CREATE TABLE bank_accounts (
    account_id SERIAL PRIMARY KEY,
    user_id INTEGER,
    balance DECIMAL(10,2) NOT NULL DEFAULT 0,
    last_transaction_date TIMESTAMP
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    from_account_id INTEGER,
    to_account_id INTEGER,
    amount DECIMAL(10,2),
    transaction_type VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO bank_accounts (user_id, balance) VALUES 
(1, 1000),
(2, 500),
(3, 2000),
(4, 750),
(5, 3000),
(6, 1500),
(7, 2500),
(8, 100);

-- Basic transaction
-- Transfer money from one to another user (between 2 account)

BEGIN;
	-- Deduct from fist account
	UPDATE bank_accounts
	SET balance = balance - 500,
		last_transaction_date = CURRENT_TIMESTAMP
	WHERE account_id = 1;

	-- Add to second account
	UPDATE bank_accounts
	SET balance = balance + 500,
		last_transaction_date = CURRENT_TIMESTAMP
	WHERE account_id = 2;

	-- Record the transaction
	INSERT INTO transactions
		(from_account_id, to_account_id, amount, transaction_type)
	VALUES
		(1, 2, 500, 'transfer');
COMMIT;

SELECT * FROM bank_accounts where account_id IN (1, 2);
SELECT * FROM transactions where transaction_id = 190

-- ROLLBACK

DO
$$
BEGIN

	IF NOT EXISTS (
		SELECT * FROM bank_accounts
		WHERE account_id = 2 AND balance >= 500
	) THEN
		ROLLBACK;
		RAISE EXCEPTION 'Insufficient funds';
	END IF;

	-- Deduct from fist account
	UPDATE bank_accounts
	SET balance = balance - 500,
		last_transaction_date = CURRENT_TIMESTAMP
	WHERE account_id = 2;

	-- Add to second account
	UPDATE bank_accounts
	SET balance = balance + 500,
		last_transaction_date = CURRENT_TIMESTAMP
	WHERE account_id = 3;

	-- Record the transaction
	INSERT INTO transactions
		(from_account_id, to_account_id, amount, transaction_type)
	VALUES
		(2, 3, 500, 'transfer');
COMMIT;
END;
$$

SELECT * FROM bank_accounts where account_id IN (2, 3);
SELECT * FROM transactions;
