-- Concatenate director's first name and last name with movie title

SELECT * FROM movies;
SELECT * FROM directors;

SELECT
CONCAT (first_name, ' ' ,last_name) AS full_name,
movies.title
FROM directors
INNER JOIN movies ON movies.director_id = directors.director_id;

-- Convert all genre names to uppercase
-- UPPER
SELECT UPPER(name) FROM genres;

