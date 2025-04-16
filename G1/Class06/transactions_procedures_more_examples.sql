-- =============================================
-- Transactions and Procedures Examples
-- =============================================

-- A transaction is a sequence of one or more SQL operations (such as INSERTs, UPDATEs, or DELETEs) that are executed as a single unit of work. 
-- Transactions guarantee that a set of database changes are either all committed to the database or none at all, ensuring that the database remains in a consistent state.
-- Once a transaction is committed, the results are permanently stored in the database, even in the event of a system crash

-- Transactions are typically started, committed, or rolled back using specific SQL statements:
-- BEGIN TRANSACTION / START TRANSACTION: Initiates the transaction.
-- COMMIT: Permanently saves all the operations performed during the transaction.
-- ROLLBACK: Reverses all operations performed during the transaction if an error occurs or if a condition is not met.

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
(2, 500);

-- 1. BASIC TRANSACTION
-- ==================
-- Use case: Transfer money between accounts
-- Transfer a fixed amount (100) from account 1 to account 2.
BEGIN;
    -- Deduct from first account
    UPDATE bank_accounts 
    SET balance = balance - 100,
        last_transaction_date = CURRENT_TIMESTAMP
    WHERE account_id = 1;

    -- Add to second account
    UPDATE bank_accounts 
    SET balance = balance + 100,
        last_transaction_date = CURRENT_TIMESTAMP
    WHERE account_id = 2;

    -- Record the transaction
    INSERT INTO transactions 
        (from_account_id, to_account_id, amount, transaction_type)
    VALUES 
        (1, 2, 100, 'transfer');
COMMIT;

-- 2. TRANSACTION WITH ROLLBACK
-- =========================
-- Use case: Transfer with balance check
-- Perform a money transfer but first check if the sender has enough funds. 
-- If there are insufficient funds, the transaction is rolled back and an error is raised.

BEGIN;
    -- Check if sender has enough money
    IF NOT EXISTS (
        SELECT 1 FROM bank_accounts 
        WHERE account_id = 1 AND balance >= 200
    ) THEN
        ROLLBACK;
        RAISE EXCEPTION 'Insufficient funds';
    END IF;

    -- Perform transfer
    UPDATE bank_accounts 
    SET balance = balance - 200
    WHERE account_id = 1;

    UPDATE bank_accounts 
    SET balance = balance + 200
    WHERE account_id = 2;

    INSERT INTO transactions 
        (from_account_id, to_account_id, amount, transaction_type)
    VALUES 
        (1, 2, 200, 'transfer');
COMMIT;

-- A stored procedure is a pre-compiled set of SQL statements and optional control-of-flow language that is stored in the database. 
-- Stored procedures are invoked by applications, allowing them to execute repetitive or complex operations efficiently on the server side.
-- Stored procedures are compiled once and can be executed repeatedly, which minimizes parsing and execution planning overhead
-- They can accept parameters, allowing the same procedure to be executed with different inputs
-- Once defined, stored procedures can be executed by name (CALL procedure_name) and can return result sets, scalar values, or output parameters 
-- 3. SIMPLE PROCEDURE
-- =================
-- Use case: Transfer money with validation
-- Encapsulate money transfer logic with validations and error checks

CREATE OR REPLACE PROCEDURE transfer_money(
    sender_id INTEGER,
    receiver_id INTEGER,
    amount DECIMAL(10,2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check if amount is positive
    IF amount <= 0 THEN
        RAISE EXCEPTION 'Amount must be positive';
    END IF;

    -- Check if accounts exist
    IF NOT EXISTS (SELECT 1 FROM bank_accounts WHERE account_id IN (sender_id, receiver_id)) THEN
        RAISE EXCEPTION 'One or both accounts do not exist';
    END IF;

    -- Check if sender has enough money
    IF NOT EXISTS (
        SELECT 1 FROM bank_accounts 
        WHERE account_id = sender_id AND balance >= amount
    ) THEN
        RAISE EXCEPTION 'Insufficient funds';
    END IF;

    -- Perform transfer
    UPDATE bank_accounts 
    SET balance = balance - amount,
        last_transaction_date = CURRENT_TIMESTAMP
    WHERE account_id = sender_id;

    UPDATE bank_accounts 
    SET balance = balance + amount,
        last_transaction_date = CURRENT_TIMESTAMP
    WHERE account_id = receiver_id;

    -- Record transaction
    INSERT INTO transactions 
        (from_account_id, to_account_id, amount, transaction_type)
    VALUES 
        (sender_id, receiver_id, amount, 'transfer');

    COMMIT;
END;
$$;

-- 4. PROCEDURE WITH RETURN VALUE
-- ==========================
-- Use case: Get account balance
-- Retrieve the current balance of a specified account

CREATE OR REPLACE FUNCTION get_account_balance(
    p_account_id INTEGER
)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
    v_balance DECIMAL(10,2);
BEGIN
    SELECT balance INTO v_balance
    FROM bank_accounts
    WHERE account_id = p_account_id;

    RETURN COALESCE(v_balance, 0);
END;
$$;

-- 5. PROCEDURE WITH OUTPUT PARAMETERS
-- ===============================
-- Use case: Get account summary
-- Return a summary of an account, including its balance, number of transactions, and the date of the last transaction

CREATE OR REPLACE PROCEDURE get_account_summary(
    p_account_id INTEGER,
    OUT p_balance DECIMAL(10,2),
    OUT p_transaction_count INTEGER,
    OUT p_last_transaction TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Get account details
    SELECT 
        balance,
        last_transaction_date
    INTO
        p_balance,
        p_last_transaction
    FROM bank_accounts
    WHERE account_id = p_account_id;

    -- Get transaction count
    SELECT COUNT(*)
    INTO p_transaction_count
    FROM transactions
    WHERE from_account_id = p_account_id 
       OR to_account_id = p_account_id;
END;
$$;

-- Example Usage:

-- 1. Call transfer procedure
CALL transfer_money(1, 2, 50);

-- 2. Get balance
SELECT get_account_balance(1);

-- 3. Get account summary
DO $$
DECLARE
    v_balance DECIMAL(10,2);
    v_count INTEGER;
    v_last_date TIMESTAMP;
BEGIN
    CALL get_account_summary(1, v_balance, v_count, v_last_date);
    RAISE NOTICE 'Balance: %, Transactions: %, Last Transaction: %',
        v_balance, v_count, v_last_date;
END;
$$;

-- IMPORTANT NOTES FOR WEB DEVELOPERS:
-- 1. Always use transactions when modifying multiple related records
-- 2. Remember that transactions block other transactions
-- 3. Keep transactions as short as possible
-- 4. Use procedures to encapsulate complex operations
-- 5. Procedures can help with:
--    - Data validation
--    - Business logic
--    - Atomic operations
--    - Code reuse
-- 6. Be careful with long-running transactions in web applications 