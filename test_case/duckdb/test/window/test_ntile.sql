CREATE TABLE Scoreboard(TeamName VARCHAR, Player VARCHAR, Score INTEGER);;
INSERT INTO Scoreboard VALUES ('Mongrels', 'Apu', 350);;
INSERT INTO Scoreboard VALUES ('Mongrels', 'Ned', 666);;
INSERT INTO Scoreboard VALUES ('Mongrels', 'Meg', 1030);;
INSERT INTO Scoreboard VALUES ('Mongrels', 'Burns', 1270);;
INSERT INTO Scoreboard VALUES ('Simpsons', 'Homer', 1);;
INSERT INTO Scoreboard VALUES ('Simpsons', 'Lisa', 710);;
INSERT INTO Scoreboard VALUES ('Simpsons', 'Marge', 990);;
INSERT INTO Scoreboard VALUES ('Simpsons', 'Bart', 2010);;
SELECT
  TeamName,
  Player,
  Score,
  NTILE() OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(1,2) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(1,2,3) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(1,2,3,4) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(-1) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(0) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(2) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(2) OVER (ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(1000) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(1) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(NULL) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;;
