CREATE OR REPLACE FUNCTION get_movie_row(movie_id_param INTEGER)
RETURNS movies
AS $$
DECLARE movie_row movies%ROWTYPE; -- THE TYPE movies%ROWTYPE means (a row from the table movies)
BEGIN
	SELECT * INTO movie_row -- WHEN WE RETURN ROWTYPE WE MUST RETURN ALL THE COLUMNS
	FROM movies m
	WHERE m.movie_id = movie_id_param;

	RETURN movie_row;
END;
$$ LANGUAGE plpgsql;

SELECT get_movie_row(1)

SELECT * FROM get_movie_row(1)