SELECT a, b, count(a) FROM lc GROUP BY a, b WITH ROLLUP ORDER BY a, b;
SELECT a, count(a) FROM lc GROUP BY a WITH ROLLUP ORDER BY a;
SELECT a, b, count(a) FROM lc GROUP BY a, b WITH CUBE ORDER BY a, b;
SELECT a, count(a) FROM lc GROUP BY a WITH CUBE ORDER BY a;
DROP TABLE if exists lc;
