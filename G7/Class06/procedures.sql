SELECT * FROM movies;
SELECT * FROM reviews;

SELECT AVG(rating)
FROM reviews
WHERE movie_id = 10;


ALTER TABLE movies ADD COLUMN average_rating DECIMAL(3,2);

CREATE OR REPLACE PROCEDURE add_review_and_update_avg(
	p_movie_id INT,
	p_user_id INT,
	p_rating INT,
	p_review_text TEXT
)
AS $$
BEGIN
	-- INSERT INTO REVIEW
	INSERT INTO reviews(movie_id, user_id, rating, review_text)
	VALUES(p_movie_id, p_user_id, p_rating, p_review_text);

	-- UPDATE the avarage rating in movies
	UPDATE movies
	SET average_rating = (
		SELECT AVG(rating)
		FROM reviews
		WHERE movie_id = p_movie_id
	)
	WHERE movie_id = p_movie_id;
END;
$$ LANGUAGE plpgsql;


CALL add_review_and_update_avg(10, 1, 5, 'Not great, not terrible!');