-- Class 2

-- Create a sample table for employees

CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	salary DECIMAL(8,2),
	department VARCHAR(50),
	hire_date DATE
);

INSERT INTO employees VALUES
    (1, 'John', 'Smith', 3000, 'IT', '2023-01-15'),
    (2, 'Mary', 'Johnson', 4000, 'HR', '2023-02-20'),
    (3, 'James', 'Wilson', 3500, 'IT', '2023-03-10'),
    (4, 'Patricia', 'Brown', 4500, 'Finance', '2023-04-05'),
    (5, 'David', 'Miller', 3200, 'IT', '2023-05-12');

-- Basic select of the whole data
SELECT * FROM employees

-- Select specific columns
SELECT first_name, last_name, salary FROM employees

-- Basic filtering
SELECT * FROM employees
WHERE department = 'IT'

-- Comparison operators
SELECT * FROM employees
WHERE salary > 3500

SELECT * FROM employees
WHERE salary >= 3500

SELECT * FROM employees
WHERE salary < 3500

SELECT * FROM employees
WHERE salary <= 3500

SELECT * FROM employees
WHERE hire_date < '2023-03-01'

-- Combining AND & OR
SELECT * FROM employees
WHERE department = 'IT' OR department = 'HR'

SELECT * FROM employees
WHERE department = 'IT' AND salary > 2500

SELECT * FROM employees
WHERE (department = 'IT' OR department = 'HR') AND salary >= 4000

-- Using between
SELECT * FROM employees
WHERE salary BETWEEN 3000 AND 4000;

-- Using In
SELECT * FROM employees
WHERE department IN ('IT', 'HR')

-- Patern matching
-- LIKE case sensitive
-- ILIKE case insensitive
SELECT * FROM employees
WHERE first_name ILIKE 'j%'

SELECT * FROM employees
WHERE first_name ILIKE '%n'

SELECT * FROM employees
WHERE first_name ILIKE '%c%'
