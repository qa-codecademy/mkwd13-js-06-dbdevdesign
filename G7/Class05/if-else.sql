-- movie_duration > 140 'Long movie' else Short Movie

SELECT * FROM movies;

SELECT duration_minutes
FROM movies
WHERE movie_id = 1;

CREATE OR REPLACE FUNCTION check_movie_duration(movie_id_param INTEGER)
RETURNS TEXT
AS $$
DECLARE 
	movie_duration INTEGER;
	length_status TEXT;
BEGIN
	SELECT duration_minutes INTO movie_duration
	FROM movies
	WHERE movie_id = movie_id_param;

	IF movie_duration > 130 THEN -- if(movie_duration){../ do this length_status = 'Long Movie'}
		length_status := 'Long Movie';
	ELSE
		length_status := 'Short Movie';
	END IF; -- CLOSING THE CONTROLLED STRUCTURE

	RETURN length_status;
END;
$$ LANGUAGE plpgsql;


SELECT check_movie_duration(8)

SELECT * FROM movies;