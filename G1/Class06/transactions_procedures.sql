-- A transaction is a sequence of one or more SQL operations (such as INSERTs, UPDATEs, or DELETEs) that are executed as a single unit of work. 
-- Transactions guarantee that a set of database changes are either all committed to the database or none at all, ensuring that the database remains in a consistent state.
-- Once a transaction is committed, the results are permanently stored in the database, even in the event of a system crash

-- Transactions are typically started, committed, or rolled back using specific SQL statements:
-- BEGIN TRANSACTION / START TRANSACTION: Initiates the transaction.
-- COMMIT: Permanently saves all the operations performed during the transaction.
-- ROLLBACK: Reverses all operations performed during the transaction if an error occurs or if a condition is not met.

-- Tables
CREATE TABLE bank_accounts (
    account_id SERIAL PRIMARY KEY,
    balance DECIMAL(10,2) NOT NULL DEFAULT 0
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    from_account_id INTEGER,
    to_account_id INTEGER,
    amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO bank_accounts (balance) VALUES (1000), (500);