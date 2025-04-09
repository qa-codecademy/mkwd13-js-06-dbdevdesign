-- Relations - One to One

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	email VARCHAR(100)
);

CREATE TABLE student_details (
	id SERIAL PRIMARY KEY,
	address VARCHAR(200),
	phone VARCHAR(20),
	student_id INTEGER UNIQUE REFERENCES students(id)
);

INSERT INTO students VALUES
	(1, 'John Doe', 'john@mail.com'),
	(2, 'Jane Doe', 'jane@mail.com');

SELECT * FROM students

INSERT INTO student_details VALUES
	(1, 'Partizanska bb', '+389(0)21234567', 1)

INSERT INTO student_details VALUES
	(2, 'Ilindenska bb', '+389(0)21234567', 2)

INSERT INTO student_details VALUES
	(3, 'Ilindenska bb', '+389(0)21234567', 3)

SELECT * FROM student_details

DELETE FROM students
WHERE id = 1

UPDATE student_details
SET student_id = 1
WHERE id = 2

-- One to Many / Many to One

CREATE TABLE departments (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	department_id INTEGER REFERENCES departments(id)
);

INSERT INTO departments VALUES (1, 'DEV'), (2, 'HR'), (3, 'QA'), (4, 'DevOps');

INSERT INTO employees VALUES (1, 'John', 4), (2, 'Jane', 3), (3, 'Mike', 1), (4, 'Peter', 1);

SELECT * FROM departments

SELECT * FROM employees

-- Many to Many

CREATE TABLE courses (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100)
);

CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	email VARCHAR(100)
);

CREATE TABLE courses_students (
	course_id INTEGER REFERENCES courses(id),
	student_id INTEGER REFERENCES students(id),
	PRIMARY KEY (course_id, student_id)
);

INSERT INTO courses VALUES
	(1, 'Nodejs'),
	(2, 'SQL'),
	(3, 'NestJS')

INSERT INTO courses_students VALUES
	(2, 1),
	(2, 2)

INSERT INTO courses_students VALUES
	(3, 1),
	(3, 2)

SELECT * FROM students
SELECT * FROM courses
SELECT * FROM courses_students

-- Joins
-- Inner JOIN

SELECT * from students
SELECT * from student_details

SELECT 
	students.name,
	student_details.address,
	student_details.phone 
FROM students s
INNER JOIN student_details sd
	ON student_details.student_id = students.id

-- Above is same as the query below

INSERT INTO students VALUES (4, 'Mike', 'mike@mail.com')

INSERT INTO student_details VALUES (4, 'Iliendenska', '12345')

SELECT * FROM students
SELECT * FROM student_details

SELECT 
	s.name,
	sd.address,
	sd.phone 
FROM students s
INNER JOIN student_details sd
	ON sd.student_id = s.id

-- OUTER JOIN

-- FULL OUTER JOIN

SELECT 
	s.name,
	sd.address,
	sd.phone 
FROM students s
FULL JOIN student_details sd
	ON sd.student_id = s.id

-- LEFT OUTER JOIN

SELECT 
	s.name,
	sd.address,
	sd.phone 
FROM students s
LEFT JOIN student_details sd
	ON sd.student_id = s.id

SELECT 
	s.name,
	sd.address,
	sd.phone 
FROM student_details sd
LEFT JOIN students s
	ON sd.student_id = s.id

-- RIGHT OUTER JOIN

SELECT 
	s.name,
	sd.address,
	sd.phone 
FROM students s
RIGHT JOIN student_details sd
	ON sd.student_id = s.id

SELECT 
	s.name,
	sd.address,
	sd.phone 
FROM student_details sd
RIGHT JOIN students s
	ON sd.student_id = s.id

-- Cross join

SELECT * 
FROM students
CROSS JOIN student_details

-- Filtering while joining

SELECT e.id as employee_id, e.name as employee_name, d.name as department_name
FROM employees e
LEFT JOIN departments d
	ON e.department_id = d.id
WHERE e.name ILIKE 'J%'