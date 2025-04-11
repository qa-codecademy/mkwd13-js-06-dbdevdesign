SELECT * FROM movies;


SELECT CONCAT(first_name, ' ', last_name) AS full_name, birth_date, nationality
FROM directors
WHERE director_id = 1;

DROP FUNCTION get_director_info;

CREATE OR REPLACE FUNCTION get_director_info(director_id_param INTEGER)
RETURNS TABLE(
	full_name TEXT,
	birth_date DATE,
	nationality VARCHAR(50)
) AS $$
BEGIN
	RETURN QUERY
	SELECT 
	CONCAT(d.first_name, ' ', d.last_name) AS full_name, 
	d.birth_date, 
	d.nationality
	FROM directors d
	WHERE d.director_id = director_id_param;
END;
$$ LANGUAGE plpgsql;

-- SELECTING ALL FROM THE return value of the function get_director_info
SELECT * FROM get_director_info(2)

-- IF WE SELECT LIKE THIS WE GONNA GET A RECORD AS A RETURN VALUE
SELECT get_director_info(2)

-- SELECTING PROPERTIES FROM A RECORD
SELECT (get_director_info(2)).full_name, (get_director_info(2)).birth_date