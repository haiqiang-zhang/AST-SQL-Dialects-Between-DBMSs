SELECT
  TeamName,
  Player,
  Score,
  NTILE(2) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(2) OVER (ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY Score;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(1000) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(1) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;
SELECT
  TeamName,
  Player,
  Score,
  NTILE(NULL) OVER (PARTITION BY TeamName ORDER BY Score ASC) AS NTILE
FROM ScoreBoard s
ORDER BY TeamName, Score;
