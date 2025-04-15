SELECT * FROM movies;

-- Create a function (REACTION)
CREATE OR REPLACE FUNCTION update_created_at()
RETURNS TRIGGER 
AS $$
BEGIN
    -- NEW (contains the new data that is going to be inserted of updated)
	-- OLD (contains the data before the update)
	NEW.created_at = CURRENT_TIMESTAMP;
	RETURN NEW; -- NEW 
END;
$$ LANGUAGE plpgsql;

-- Creating the trigger (ACTION)
-- onClick
CREATE TRIGGER trg_update_created_at
BEFORE UPDATE ON movies
FOR EACH ROW
EXECUTE FUNCTION update_created_at(); -- executing when the trigger EXECUTES

DROP TRIGGER trg_update_created_at;

UPDATE movies
SET title = 'Inception' 
WHERE movie_id = 1;

SELECT * FROM movies;

-- EXAMPLE 2

CREATE TABLE movie_audit(
	audit_id SERIAL PRIMARY KEY,
	movie_id INT,
	old_title VARCHAR(50),
	new_title VARCHAR(50),
	changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM movie_audit;

-- Create trigger function (REACTION)
CREATE OR REPLACE FUNCTION log_movie_title_changes()
RETURNS TRIGGER
AS $$
BEGIN
	INSERT INTO movie_audit(movie_id, old_title, new_title)
	VALUES(OLD.movie_id, OLD.title, NEW.title);
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger (ACTION)
CREATE TRIGGER trg_movie_changes
AFTER UPDATE OF title ON movies
FOR EACH ROW
EXECUTE FUNCTION log_movie_title_changes();

SELECT * FROM movies;

UPDATE movies
SET title = 'The Jurassic Park'
WHERE movie_id = 4;

SELECT * FROM movie_audit;
