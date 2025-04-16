SELECT * FROM movies;
SELECT * FROM movie_revenues;

INSERT INTO movies(title, release_date, director_id, duration_minutes, rating)
VALUES('Demo movie', '2025-01-01', 1, 120, 'PG');

INSERT INTO movies(title, release_date, director_id, duration_minutes, rating)
VALUES('Predator', '2019-01-01', 1, 150, 'PG');


BEGIN; -- starting the transaction

INSERT INTO movie_revenues(movie_id, domestic_revenue, international_revenue)
VALUES(17, 1000000, 2000000);

COMMIT; -- If everything went good

-- ROLLBACK; -- If something goes wrong

