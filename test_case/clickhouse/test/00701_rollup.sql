SELECT a, b, sum(s), count() from rollup GROUP BY ROLLUP(a, b) ORDER BY a, b;
SELECT a, sum(s), count() from rollup GROUP BY a WITH ROLLUP ORDER BY a;
SET group_by_two_level_threshold = 1;
DROP TABLE rollup;
