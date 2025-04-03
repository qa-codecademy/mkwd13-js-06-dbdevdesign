CREATE TABLE students (
	id SERIAL PRIMARY KEY,
	student_id VARCHAR(10) UNIQUE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE,
	age INT CHECK (age >= 16 AND age < 100),
	enrollment_status VARCHAR(20) DEFAULT 'Active'
);

-- SERIAL -> ID IS AUTO INCREMENTAL
-- UNIQUE -> TWO RECORDS CANNOT HAVE SAME VALUE
-- NOT NULL -> WE MUST PROVIDE VALUE FOR THIS COLUMN
-- CHECK -> IS MAKING A VALIDATION CHECK ON LEVEL OF DB (when we insert the data)
-- DEFAULT -> A DEFAULT VALUE FOR A COLUMN IF VALUE IS NOT PROVIDED

SELECT * FROM students;

-- NOT NULL CONSTRAINT 

INSERT INTO students (student_id, first_name, last_name, age)
VALUES ('S12345', 'John', 'Doe', 18);

-- THIS WON'T WORK, SINCE first_name is marked with NOT_NULL contraint, MEANING A VALUE MUST BE PROVIDED
INSERT INTO students (student_id, last_name, age)
VALUES ('S123456', 'Doe', 18);

-- NULL CONSTRAINT
-- this will work since email is NULL (meaning this value is optional)
INSERT INTO students (student_id, first_name, last_name, age)
VALUES ('S12346', 'Bob', 'Bobski', 17);

-- this works also
INSERT INTO students (student_id, first_name, last_name, age, email)
VALUES ('S12347', 'Jane', 'Lee', 23, 'somemail@mail.com');

SELECT * FROM students;


-- UNIQUE
-- won't work since there is already student with that email
INSERT INTO students (student_id, first_name, last_name, age, email)
VALUES ('S12348', 'Ema', 'Watson', 23, 'somemail@mail.com');


-- won't work since there is already student with that student_id
INSERT INTO students (student_id, first_name, last_name, age, email)
VALUES ('S12347', 'Emily', 'Star', 20, 'ema@mail.com');

-- CHECK
-- won't work since age is less then 16 and we have that check constraint
INSERT INTO students (student_id, first_name, last_name, age, email)
VALUES ('S12348', 'Emily', 'Star', 15, 'ema@mail.com');