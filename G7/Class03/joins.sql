-- Show all movies and their directors
SELECT * FROM movies;
SELECT * FROM directors;

SELECT movies.title, directors.first_name, directors.last_name FROM movies
INNER JOIN directors
ON movies.director_id = directors.director_id;

-- Show all movies and their genres
SELECT * FROM movies;
SELECT * FROM genres;
SELECT * FROM movie_genres;


SELECT movies.title, genres.name FROM movies
INNER JOIN movie_genres ON movie_genres.movie_id = movies.movie_id
INNER JOIN genres ON movie_genres.genre_id = genres.genre_id;

-- Show all movies and their actors
SELECT * FROM movies;
SELECT * FROM actors;
SELECT * FROM cast_members;


SELECT m.title AS "movieTitle", a.first_name, a.last_name
FROM movies m
INNER JOIN cast_members cm ON cm.movie_id = m.movie_id
INNER JOIN actors a ON a.actor_id = cm.actor_id;

-- Show all movies and their reviews

SELECT * FROM movies;
SELECT * FROM reviews;

SELECT movies.title, reviews.rating, reviews.review_text
FROM movies
INNER JOIN reviews ON reviews.movie_id = movies.movie_id

-- Show all movies and their production companies
SELECT * FROM movies; -- contains movie title
SELECT * FROM production_companies; -- contains the company name
SELECT * FROM movie_production_companies; -- contains which company produces which movie

SELECT m.title, pc.name
FROM movies m
INNER JOIN movie_production_companies mpc ON mpc.movie_id = m.movie_id
INNER JOIN production_companies pc ON pc.company_id = mpc.company_id;