-- Function that returns the total number of movies

CREATE OR REPLACE FUNCTION count_all_movie() -- defineing the function
RETURNS INTEGER -- return type of the value
AS $$ -- start of the body of the function
DECLARE total_count INTEGER; -- declaring a helper variable that is going to hold the return value	

	BEGIN -- WE BEGIN THE QUERY
		SELECT COUNT(*) INTO total_count -- we are initializing (setting value) INTO the variable total_count
		FROM movies;

	RETURN total_count;
	END; -- END THE QUERY
	
$$ LANGUAGE plpgsql; --  end of the body of the function

-- Usage
SELECT count_all_movie()


-- Function that returns the avarage rating for specific director



SELECT * FROM movies;
SELECT * FROM directors;

SELECT * FROM reviews;


SELECT AVG(r.rating)
FROM reviews r
INNER JOIN movies m ON m.movie_id = r.movie_id
WHERE m.director_id = 4;

CREATE OR REPLACE FUNCTION get_director_avg_rating(director_id_param INTEGER)
RETURNS NUMERIC
AS $$
DECLARE avg_rating NUMERIC;

BEGIN
	SELECT AVG(r.rating) INTO avg_rating
	FROM reviews r
	INNER JOIN movies m ON m.movie_id = r.movie_id
	WHERE m.director_id = director_id_param;

	RETURN avg_rating;
END;

$$ LANGUAGE plpgsql;

-- Usage
SELECT get_director_avg_rating(3);



SELECT * FROM movies;
SELECT * FROM movie_genres;
SELECT * FROM genres;

-- Function that returns the count of movies by specific genre
-- movie_by_genre('Action')

SELECT COUNT(*) 
FROM movie_genres mg
INNER JOIN genres g ON g.genre_id = mg.genre_id
WHERE g.name = 'Action';

CREATE OR REPLACE FUNCTION movie_by_genre(ganre_name_param VARCHAR)
RETURNS INTEGER
AS $$
DECLARE movie_count INTEGER;

	BEGIN
		SELECT COUNT(*) INTO movie_count
		FROM movie_genres mg
		INNER JOIN genres g ON g.genre_id = mg.genre_id
		WHERE g.name = ganre_name_param;

		RETURN movie_count;
	END;
	
$$ LANGUAGE plpgsql;

SELECT movie_by_genre('Drama');

-- Create a function that returns the number of rewards by provided movie id
-- count_movie_awards(2) => 4

INSERT INTO movie_awards(movie_id, award_id, created_at)
VALUES(1, 2, '2025-04-11 09:14:17.746746');

SELECT * FROM movie_awards;
SELECT * FROM awards;

SELECT COUNT(*)
FROM movie_awards ma
WHERE movie_id = 1


CREATE OR REPLACE FUNCTION count_movie_awards(movie_id_param INTEGER)
RETURNS INTEGER
AS $$
DECLARE award_count INTEGER;

BEGIN
	SELECT COUNT(*) INTO award_count
	FROM movie_awards ma
	WHERE movie_id = movie_id_param;

	RETURN award_count;
END;
$$ LANGUAGE plpgsql;


SELECT count_movie_awards(1)

















