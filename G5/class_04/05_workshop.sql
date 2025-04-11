-- WORKSHOP

-- Count total number of movies
SELECT COUNT(*) as total_movies
FROM movies

-- Count artors by nationality
SELECT 
	nationality,
	COUNT(*) as actors_count
FROM actors
GROUP BY nationality

-- Count number of movies per genre

SELECT g.name, COUNT(mg.genre_id) movie_count
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
GROUP BY mg.genre_id, g.name

-- Find highest budget per genre

SELECT g.name, MAX(m.budget) as heighest_budget
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m on mg.movie_id = m.movie_id
GROUP BY g.name
ORDER BY MAX(m.budget) DESC

-- Find shortest movie duration per genre

SELECT g.name, MIN(m.duration_minutes)::text || ' min' as shortest_movie
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m on mg.movie_id = m.movie_id
GROUP BY g.name

-- Find lowest rating per movie

SELECT m.title, MIN(r.rating) lowest_rating
FROM movies m
JOIN reviews r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title

SELECT * FROM reviews

-- Calculate average revenue per genre

SELECT g.name, TRUNC(AVG(mr.domestic_revenue + mr.international_revenue), 2) as avg_revenue
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m ON m.movie_id = mg.movie_id
JOIN movie_revenues mr ON mr.movie_id = m.movie_id
GROUP BY g.genre_id, g.name

-- Calculate total budget per director

SELECT d.first_name, d.last_name, SUM(m.budget) total_budget
FROM directors d
JOIN movies m ON m.director_id = d.director_id
GROUP BY d.director_id, d.first_name, d.last_name

-- Find actors who have won more than 1 award

SELECT a.first_name, a.last_name, COUNT(aa.award_id) award_count
FROM actors a
JOIN actor_awards aa ON a.actor_id = aa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(aa.award_id) > 1