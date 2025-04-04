CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    book_title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    sale_date DATE NOT NULL
);

INSERT INTO sales (book_title, author, price, sale_date) VALUES
('Harry Potter', 'J.K. Rowling', 20.00, '2023-01-01'),
('The Hobbit', 'J.R.R. Tolkien', 15.00, '2023-01-01'),
('Harry Potter', 'J.K. Rowling', 20.00, '2023-01-02'),
('The Catcher in the Rye', 'J.D. Salinger', 10.00, '2023-01-02'),
('The Hobbit', 'J.R.R. Tolkien', 15.00, '2023-01-03');


SELECT * FROM sales;
-- Return the name of the book and the total earnings that it made

-- Harry potter | 40
-- The Hobbit | 30
-- The Catcher in the Rye | 10

SELECT book_title, SUM(price) as total_earnings
FROM sales
GROUP BY book_title;

-- *** ORIGINAL SALES TABLE ***

| sale_id | book_title           | author            | price | sale_date  |
|---------|----------------------|-------------------|-------|------------|
| 1       | Harry Potter         | J.K. Rowling      | 20.00 | 2023-01-01 |
| 2       | The Hobbit           | J.R.R. Tolkien    | 15.00 | 2023-01-01 |
| 3       | Harry Potter         | J.K. Rowling      | 20.00 | 2023-01-02 |
| 4       | The Catcher in the Rye | J.D. Salinger   | 10.00 | 2023-01-02 |
| 5       | The Hobbit           | J.R.R. Tolkien    | 15.00 | 2023-01-03 |


-- *** GROUP BY book_title ***

-- Group 1: Harry Potter
| sale_id | book_title   | author       | price | sale_date  |
|---------|--------------|--------------|-------|------------|
| 1       | Harry Potter | J.K. Rowling | 20.00 | 2023-01-01 |
| 3       | Harry Potter | J.K. Rowling | 20.00 | 2023-01-02 |


-- Group 2: The Hobbit
| sale_id | book_title | author         | price | sale_date  |
|---------|------------|----------------|-------|------------|
| 2       | The Hobbit | J.R.R. Tolkien | 15.00 | 2023-01-01 |
| 5       | The Hobbit | J.R.R. Tolkien | 15.00 | 2023-01-03 |

-- Group 3: The Catcher in the Rye
| sale_id | book_title              | author         | price | sale_date  |
|---------|-------------------------|----------------|-------|------------|
| 4       | The Catcher in the Rye  | J.D. Salinger  | 10.00 | 2023-01-02 |


-- *** PERFORMING AGGRATE FUNCTION TO SEE HOW MUCH PROFIT DID A BOOK MADE BY IT'S SALING  ***

-- Group 1: Harry Potter
Total Earnings: 20.00 + 20.00 = 40.00

-- Group 2: The Hobbit
Total Earnings: 15.00 + 15.00 = 30.00

-- Group 3: The Catcher in the Rye
Total Earnings: 10.00



-- *** RESULT WOULD BE ***
| book_title            | total_earnings |
|-----------------------|----------------|
| Harry Potter          | 40.00          |
| The Hobbit            | 30.00          |
| The Catcher in the Rye | 10.00         |