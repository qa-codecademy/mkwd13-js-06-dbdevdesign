CREATE TABLE football_club (
	id SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	founded_year INT
);

CREATE TABLE football_players(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	jersey_number INT,
	club_id INT NOT NULL,
	FOREIGN KEY(club_id) REFERENCES football_club(id)
);

INSERT INTO football_club(name, founded_year)
VALUES
('Chelsea', 1905),
('Barcelona', 1899),
('Real Madrid', 1900);


INSERT INTO football_players(name, jersey_number, club_id)
VALUES
('Frank Lampard', 8, 1),
('Lionel Messi', 10, 2),
('Cristiano Ronaldo', 7, 3),
('Didier Drogba', 11, 1);


SELECT * FROM football_club;
SELECT * FROM football_players;

-- Return the player name and the club name that the user playes in.
SELECT * FROM football_club;
SELECT * FROM football_players;

SELECT football_players.name, football_club.name FROM football_players
INNER JOIN football_club ON club_id = football_club.id;

