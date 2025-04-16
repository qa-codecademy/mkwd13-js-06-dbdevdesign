-- Simple procedure

CREATE OR REPLACE PROCEDURE transfer_money(
	sender_id INTEGER,
	receiver_id INTEGER,
	amount DECIMAL(10,2)
)
LANGUAGE plpgsql
AS
$$
	BEGIN

		-- check if amount is positive
		IF amount <= 0 THEN
			RAISE EXCEPTION 'Amount must be larger than zero';
		END IF;

		-- check if accounts exist
		IF ((SELECT COUNT(*) FROM bank_accounts WHERE account_id IN (sender_id, receiver_id)) < 2)
		THEN
			RAISE EXCEPTION 'One or both accounts do not exist';
		END IF;
		

		-- check if sender has enough money
		IF NOT EXISTS (
			SELECT 1 FROM bank_accounts
			WHERE account_id = sender_id AND balance >= amount
		) THEN
			RAISE EXCEPTION 'Insufficient funds';
		END IF;

		-- perfect transfer
		UPDATE bank_accounts
		SET balance = balance - amount,
			last_transaction_date = CURRENT_TIMESTAMP
		WHERE account_id = sender_id;

		UPDATE bank_accounts
		SET balance = balance + amount,
			last_transaction_date = CURRENT_TIMESTAMP
		WHERE account_id = receiver_id;

		-- record transaction
		INSERT INTO transactions
			(from_account_id, to_account_id, amount, transaction_type)
		VALUES
			(sender_id, receiver_id, amount, 'transfer');
		

	COMMIT;
END;
$$;

CALL transfer_money(1, 20, 4000)

SELECT * FROM bank_accounts ORDER BY account_id ASC
SELECT * FROM transactions


-- Producedure that returns a value

CREATE OR REPLACE PROCEDURE get_account_summary(
	p_account_id INTEGER,	
	OUT p_balance DECIMAL(10,2),
	OUT p_transaction_count INTEGER,
	OUT p_last_transaction TIMESTAMP
)
LANGUAGE plpgsql
AS
$$
BEGIN
	-- Get account details
	SELECT balance,
		last_transaction_date
	INTO
		p_balance,
		p_last_transaction
	FROM bank_accounts
	WHERE account_id = p_account_id;

	-- get transaction count
	SELECT COUNT(*)
	INTO p_transaction_count
	FROM transactions
	WHERE from_account_id = p_account_id
		OR to_account_id = p_account_id;
	
END;
$$;

-- Calling the procedure

DO $$
DECLARE
	v_balance DECIMAL(10,2);
	v_count INTEGER;
	v_last_date TIMESTAMP;
BEGIN
	CALL get_account_summary(2, v_balance, v_count, v_last_date);
	RAISE NOTICE 'Balance: %, Transactions Count: %, Last Transaction: %', v_balance, v_count, v_last_date;

END;
$$;

-- example 2
CREATE OR REPLACE PROCEDURE get_account_balance(
    p_account_id INTEGER,
    OUT p_balance DECIMAL(10,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Get the balance and store it in the OUT parameter
    SELECT COALESCE(balance, 0) INTO p_balance
    FROM bank_accounts
    WHERE account_id = p_account_id;
END;
$$;

DO $$
DECLARE
    balance DECIMAL(10,2);
BEGIN
    CALL get_account_balance(1, balance);
    RAISE NOTICE 'Account balance: %', balance;
END;
$$;