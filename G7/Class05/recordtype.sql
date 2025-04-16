SELECT
first_name,
last_name,
birth_date,
biography
FROM actors
WHERE actor_id = 1;

CREATE OR REPLACE FUNCTION get_actor_by_id(actor_id_param INTEGER)
RETURNS RECORD
AS $$
DECLARE actor_info RECORD;
BEGIN
	SELECT
	a.first_name,
	a.last_name,
	a.birth_date,
	a.biography
	INTO actor_info
	FROM actors a
	WHERE a.actor_id = actor_id_param;

	RETURN actor_info;
END;
$$ LANGUAGE plpgsql; 

SELECT get_actor_by_id(1);


-- works
SELECT get_actor_by_id(1);

-- does not work
SELECT * FROM get_actor_by_id(1);

-- works 
SELECT * FROM get_actor_by_id(1)
AS (first_name VARCHAR(50), last_name VARCHAR(50), birth_date DATE, biography TEXT);