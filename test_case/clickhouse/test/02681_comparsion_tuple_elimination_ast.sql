EXPLAIN SYNTAX
SELECT * FROM t1
WHERE (a, b) = (1, 2) AND (c, d, a) = (3, 4, 5) OR (a, b, 1000) = (c, 10, d) OR ((a, b), 1000) = ((c, 10), d);
