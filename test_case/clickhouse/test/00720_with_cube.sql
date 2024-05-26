SELECT a, b, sum(s), count() from cube GROUP BY CUBE(a, b) ORDER BY a, b;
SELECT a, b, sum(s), count() from cube GROUP BY a, b WITH CUBE ORDER BY a, b;
SET group_by_two_level_threshold = 1;
DROP TABLE cube;
