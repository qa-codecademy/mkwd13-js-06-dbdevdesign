-- Example 1
SELECT * FROM movies
WHERE title = 'Pulp Fiction';

CREATE INDEX idx_movies_title ON movies(title);

EXPLAIN ANALYSE SELECT * FROM movies
WHERE title = 'Pulp Fiction';

-- Example 2 
SELECT * FROM users;
SELECT * FROM reviews;

EXPLAIN ANALYSE
SELECT r.review_id, r.rating, r.review_text
FROM reviews r
INNER JOIN users u ON u.user_id = r.user_id
WHERE u.username = 'moviebuff';

CREATE INDEX idx_reviews_user_id ON reviews(user_id);

-- Example 3
CREATE INDEX idx_movie_release_rating ON movies(release_date, rating);

EXPLAIN ANALYSE -- WITH EXPLAIN ANALYSE we can analyze how the query performed
SELECT title, release_date, rating
FROM movies
WHERE release_date BETWEEN '2000-01-01' AND '2025-01-01'
AND rating = 'R';
