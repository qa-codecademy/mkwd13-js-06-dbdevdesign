-- DELETE FROM TABLE
DELETE FROM football_players;

-- DELETING BY A COLUMN VALUE
DELETE FROM football_players
WHERE id = 1;

DELETE FROM football_players
WHERE player_name = 'Arjen Robben';

-- REMOVING MUPLIPLE RECORDS MATCHING SAME WHERE CLAUSE
DELETE FROM football_clubs
WHERE founded_at = 1905;

SELECT * FROM football_clubs;

-- UPDATE A RECORD
UPDATE football_clubs
SET name = 'Chelsea FC'
WHERE id = 1;

INSERT INTO football_clubs(id, founded_at, name)
VALUES (2, 1905, 'Some club');

-- UPDATE MULTIPLE RECORDS WITH MATCHING WHERE CLAUSE
UPDATE football_clubs
SET name = 'CHELSEA FC'
WHERE founded_at = 1905;
