CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,  -- This automatically creates an index
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    is_active BOOLEAN DEFAULT true
);

INSERT INTO users VALUES (1, 'test.username', 'ivo@kostovski.dev')

INSERT INTO users VALUES (2, 'daniel', 'daniel@gmail.com')

UPDATE users
SET is_active = false
WHERE user_id = 2

CREATE INDEX idx_users_email ON users(email)

SELECT * FROM users
WHERE email = 'ivo@kostovski.dev'

-- Partial index

CREATE INDEX idx_active_users
ON users(username)
WHERE is_active = true;

SELECT * FROM users
WHERE is_active = false

-- Compound index
CREATE INDEX idx_users_email_username ON users(username, email)