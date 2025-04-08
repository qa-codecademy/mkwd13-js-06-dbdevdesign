CREATE OR REPLACE VIEW actors_details AS
SELECT
first_name || ' ' || last_name AS full_name, 
birth_date,
actor_id
FROM actors;

SELECT * FROM actors_details;


SELECT * FROM movies;
