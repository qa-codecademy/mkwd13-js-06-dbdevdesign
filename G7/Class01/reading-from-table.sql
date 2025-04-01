-- READ DATA FROM TABLE
SELECT * FROM football_clubs;

-- READ DATA FROM TABLE
SELECT * FROM football_players;

-- READING * (ALL) columns FROM A TABLE
SELECT * FROM football_players;

-- READING SPECIFIC COLUMN FROM A TABLE
SELECT player_name FROM football_players;

-- READING SPECIFIC COLUMN FROM A TABLE RETURNING THE FIRST RECORD 
SELECT player_name FROM football_players LIMIT 1;

-- READING BY SPECIFIC VALUE
SELECT * FROM football_players
WHERE id = 3;

SELECT * FROM football_players
WHERE player_name = 'Frank Lampard';