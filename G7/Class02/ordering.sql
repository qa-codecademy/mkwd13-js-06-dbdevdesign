SELECT * FROM movies;

-- ORDER BY (If we do not specify ASC or DESC, ASC is taken into account by default.)
SELECT * FROM movies
ORDER BY title ASC;

SELECT * FROM movies
ORDER BY title DESC;

SELECT * FROM movies
ORDER BY release_date ASC;

-- COMBINE IT WITH FILTERING
SELECT * FROM actors
WHERE nationality = 'American'
ORDER BY height_cm ASC;