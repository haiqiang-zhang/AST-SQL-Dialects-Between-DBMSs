SET allow_experimental_analyzer = 1;
EXPLAIN PLAN header = 1
SELECT count() FROM a JOIN b ON b.b1 = a.a1 JOIN c ON c.c1 = b.b1 JOIN d ON d.d1 = c.c1 GROUP BY a.a2;
EXPLAIN PLAN header = 1
SELECT a.a2, d.d2 FROM a JOIN b USING (k) JOIN c USING (k) JOIN d USING (k);
EXPLAIN PLAN header = 1
SELECT b.bx FROM a
JOIN (SELECT b1, b2 || 'x'  AS bx FROM b ) AS b ON b.b1 = a.a1
JOIN c ON c.c1 = b.b1
JOIN (SELECT number AS d1 from numbers(10)) AS d ON d.d1 = c.c1
WHERE c.c2 != '' ORDER BY a.a2;
DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;
DROP TABLE IF EXISTS c;
DROP TABLE IF EXISTS d;
