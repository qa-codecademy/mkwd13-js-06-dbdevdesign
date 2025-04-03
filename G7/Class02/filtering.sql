-- Find all actors with last name 'DiCaprio'
SELECT * FROM actors
WHERE last_name = 'DiCaprio';

-- Find all directors whose first name starts with 'M'
SELECT * FROM directors
WHERE first_name LIKE 'D%';

SELECT * FROM directors
WHERE last_name LIKE '%o%';

-- Find all actors from 'Australian' nationality
SELECT * FROM actors
WHERE nationality = 'Australian'

-- Find all actors with birth date after '1974-01-01'
SELECT * FROM actors
WHERE birth_date > '1974-01-01';

-- Find all movies where plot_summary contains the word "deadly"
SELECT * FROM movies
WHERE plot_summary LIKE '%deadly%';

-- ADVANCED FILTERING
SELECT * FROM actors
WHERE birth_date BETWEEN
'1954-01-01' AND '1974-01-01';

SELECT * FROM actors
WHERE NOT nationality = 'American';