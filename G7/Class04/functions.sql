SELECT * FROM movies;


SELECT *
FROM movies
WHERE movie_id = 5;

DROP FUNCTION get_movie_name; -- remove function if needed

-- Create a function that return a movie name by given movie id
CREATE OR REPLACE FUNCTION get_movie_name(someID INT)
RETURNS VARCHAR -- RETURN TYPE OF THE FUNCTION
AS
$$ -- SCOPE OF THE FUNCTION
	DECLARE movie_name VARCHAR(50); -- DECLARING A VARIABLE THAT CAN BE USED ONLY IN THE SCOPE OF THE FUNCTION

	BEGIN
		SELECT m.title
		INTO movie_name -- SAVE THE VALUE IN THE VARIABLE movie_name
		FROM movies m
		WHERE m.movie_id = someID;

		RETURN movie_name;
	END

$$ LANGUAGE plpgsql;

SELECT * FROM get_movie_name(5);
SELECT * FROM get_movie_name(13);
SELECT * FROM get_movie_name(1);

/**
    
    // THE SQL FUNCTION REPRESENTED AS JS FUNCTION

    const get_movie_name = (someID) => {
        let movieName;

        const movie = movies.find((movie) => movie.movie_id = someID);

        movieName = movie.title

        return movieName
    };

 **/