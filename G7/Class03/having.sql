-- Find directors who have directed more than 2 movies
SELECT d.first_name, d.last_name, COUNT(*) AS movie_count
FROM directors d
INNER JOIN movies m ON m.director_id = d.director_id
GROUP BY d.first_name, d.last_name
HAVING COUNT(*) > 2;

-- Find genres that have more than 3 movies
SELECT g.name, COUNT(*) AS movie_count
FROM genres g
INNER JOIN movie_genres mg ON g.genre_id = mg.genre_id
GROUP BY g.name
HAVING COUNT(*) > 3;