-- Views

-- Create base tables for our examples
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

CREATE TABLE departments (
    department VARCHAR(50) PRIMARY KEY,
    budget DECIMAL(12,2),
    location VARCHAR(100)
);

-- Insert sample data
INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('John', 'Smith', 'IT', 75000, '2023-01-15'),
('Jane', 'Doe', 'HR', 65000, '2023-02-01'),
('Bob', 'Wilson', 'IT', 80000, '2023-01-10'),
('Alice', 'Brown', 'Finance', 70000, '2023-03-01'),
('Charlie', 'Davis', 'HR', 62000, '2023-02-15'),
('David', 'Miller', 'IT', 85000, '2023-01-20'),
('Emma', 'Wilson', 'Finance', 72000, '2023-03-15');

INSERT INTO departments (department, budget, location) VALUES
('IT', 500000, 'Building A'),
('HR', 300000, 'Building B'),
('Finance', 400000, 'Building A');

-- View with some calculations

CREATE VIEW department_statistics AS
SELECT 
	department,
	COUNT(*) as employee_count,
	MIN(salary) as min_salary,
	MAX(salary) as max_salary,
	ROUND(AVG(salary), 2) as avg_salary
FROM employees
GROUP BY department

SELECT * FROM department_statistics


-- Views with JOINS

CREATE VIEW department_summary AS
SELECT 
	d.department,
	d.location,
	d.budget,
	COUNT(e.employee_id) as emplyee_count,
	ROUND(AVG(e.salary), 2) as avg_salary,
	ROUND(d.budget / COUNT(e.employee_id), 2) as budget_per_employee
FROM departments d
LEFT JOIN employees e ON d.department = e.department
GROUP BY d.department, d.location, d.budget

SELECT * FROM department_summary

INSERT INTO departments (department, budget, location) VALUES
('Legal', 600000, 'Building D')

INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('Ivo', 'Kostovski', 'Legal', 75000, '2023-01-15')

SELECT department, avg_salary FROM department_summary
WHERE emplyee_count > 1
ORDER BY avg_salary DESC


-- MATERIALIZED VIEWS

CREATE MATERIALIZED VIEW department_analytics AS
SELECT 
	department,
	COUNT(*) as employee_count,
	SUM(salary) as total_salary,
	MIN(salary) as min_salary,
	MAX(salary) as max_salary,
	ROUND(AVG(salary), 2) as avg_salary
FROM employees
GROUP BY department
WITH DATA;

SELECT * FROM department_analytics

INSERT INTO departments (department, budget, location) VALUES
('DevOps', 600000, 'Building T');

INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('Daniel', 'Ivtimov', 'DevOps', 75000, '2023-01-15')

REFRESH MATERIALIZED VIEW department_analytics

-- TEMPORARY TABLES

CREATE TEMPORARY TABLE temp_high_salary_employees AS
SELECT *
FROM employees
WHERE salary > 7000

SELECT * FROM temp_high_salary_employees

INSERT INTO temp_high_salary_employees VALUES (100, 'Nekoj', 'Nov', 'DevOps', 75000, '2023-01-15')