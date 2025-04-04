-- Count total number of movies
-- COUNT 
SELECT COUNT(*) AS total_count
FROM movies;

-- Count number of actors per nationality
SELECT nationality, COUNT(*) AS actor_count
FROM actors
GROUP BY nationality;

-- Count number of movies per director

SELECT * FROM movies;
SELECT * FROM directors;

SELECT d.first_name, d.last_name, COUNT(*) AS movies_directed
FROM directors d
INNER JOIN movies m ON m.director_id = d.director_id
GROUP BY d.first_name, d.last_name

-- Count number of movies per genre
SELECT * FROM movies;
SELECT * FROM movie_genres;
SELECT * FROM genres;

SELECT g.name, COUNT(*) as movie_count
FROM genres g
INNER JOIN movie_genres mg ON mg.genre_id = g.genre_id
GROUP BY g.name;

-- Count number of reviews per movie
SELECT * FROM movies;
SELECT * FROM reviews;

SELECT m.title, COUNT(*) as review_count
FROM movies m
INNER JOIN reviews r ON r.movie_id = m.movie_id
GROUP BY m.title;

-- Count number of movies per rating
SELECT m.rating, COUNT(*) AS movies_per_rating
FROM movies m
GROUP BY m.rating;

-- Find highest budget per genre
SELECT * FROM movies;
SELECT * FROM genres;
SELECT * FROM movie_genres;

SELECT g.name, MAX(m.budget) AS highest_budget
FROM genres g
INNER JOIN movie_genres mg ON mg.genre_id = g.genre_id
INNER JOIN movies m ON m.movie_id = mg.movie_id
GROUP BY g.name;

-- Find longest movie duration per director
SELECT d.first_name, d.last_name, MAX(m.duration_minutes)
FROM directors d
INNER JOIN movies m ON m.director_id = d.director_id
GROUP BY d.first_name, d.last_name;

-- Find lowest rating per movie
SELECT m.title, MIN(r.rating) AS lowest_rating
FROM movies m
INNER JOIN reviews r ON r.movie_id = m.movie_id
GROUP BY m.title;