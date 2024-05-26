SELECT generate_series(1, 3);
explain (verbose, costs off)
SELECT generate_series(1, generate_series(1, 3)), generate_series(2, 4);
CREATE TABLE few(id int, dataa text, datab text);
INSERT INTO few VALUES(1, 'a', 'foo'),(2, 'a', 'bar'),(3, 'b', 'bar');
explain (verbose, costs off)
SELECT unnest(ARRAY[1, 2]) FROM few WHERE false;
SELECT unnest(ARRAY[1, 2]) FROM few WHERE false;
explain (verbose, costs off)
SELECT * FROM few f1,
  (SELECT unnest(ARRAY[1,2]) FROM few f2 WHERE false OFFSET 0) ss;
SELECT * FROM few f1,
  (SELECT unnest(ARRAY[1,2]) FROM few f2 WHERE false OFFSET 0) ss;
SELECT few.id, generate_series(1,3) g FROM few ORDER BY id DESC;
SELECT few.id, generate_series(1,3) g FROM few ORDER BY id, g DESC;
SET enable_hashagg TO 0;
SELECT few.dataa, count(*), min(id), max(id), unnest('{1,1,3}'::int[]) FROM few WHERE few.id = 1 GROUP BY few.dataa;
RESET enable_hashagg;
SELECT dataa, generate_series(1,1), count(*) FROM few GROUP BY 1 HAVING count(*) > 1;
SELECT few.dataa, count(*) FROM few WHERE dataa = 'a' GROUP BY few.dataa ORDER BY 2;
SELECT few.dataa, count(*) FROM few WHERE dataa = 'a' GROUP BY few.dataa, unnest('{1,1,3}'::int[]) ORDER BY 2;
SELECT sum((3 = ANY(SELECT generate_series(1,4)))::int);
SELECT id,lag(id) OVER(), count(*) OVER(), generate_series(1,3) FROM few;
SELECT SUM(count(*)) OVER(PARTITION BY generate_series(1,3) ORDER BY generate_series(1,3)), generate_series(1,3) g FROM few GROUP BY g;
SELECT few.dataa, count(*), min(id), max(id), generate_series(1,3) FROM few GROUP BY few.dataa ORDER BY 5, 1;
set enable_hashagg = false;
SELECT dataa, datab b, generate_series(1,2) g, count(*) FROM few GROUP BY CUBE(dataa, datab);
reset enable_hashagg;
explain (verbose, costs off)
select 'foo' as f, generate_series(1,2) as g from few order by 1;
select 'foo' as f, generate_series(1,2) as g from few order by 1;
CREATE TABLE fewmore AS SELECT generate_series(1,3) AS data;
INSERT INTO fewmore VALUES(generate_series(4,5));
SELECT * FROM fewmore;
SELECT int4mul(generate_series(1,2), 10);
SELECT DISTINCT ON (a) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b);
SELECT DISTINCT ON (a) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)
ORDER BY a, b DESC;
SELECT DISTINCT ON (a) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)
ORDER BY a, b DESC, g DESC;
SELECT DISTINCT ON (a, b, g) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b)
ORDER BY a, b DESC, g DESC;
SELECT DISTINCT ON (g) a, b, generate_series(1,3) g
FROM (VALUES (3, 2), (3,1), (1,1), (1,4), (5,3), (5,1)) AS t(a, b);
SELECT a, generate_series(1,2) FROM (VALUES(1),(2),(3)) r(a) LIMIT 2 OFFSET 2;
SELECT (SELECT generate_series(1,3) LIMIT 1 OFFSET few.id) FROM few;
SELECT (SELECT generate_series(1,3) LIMIT 1 OFFSET g.i) FROM generate_series(0,3) g(i);
CREATE OPERATOR |@| (PROCEDURE = unnest, RIGHTARG = ANYARRAY);
SELECT |@|ARRAY[1,2,3];
explain (verbose, costs off)
select generate_series(1,3) as x, generate_series(1,3) + 1 as xp1;
select generate_series(1,3) as x, generate_series(1,3) + 1 as xp1;
explain (verbose, costs off)
select generate_series(1,3) as x, generate_series(3,6) + 1 as y;
select generate_series(1,3) as x, generate_series(3,6) + 1 as y;
DROP TABLE few;
DROP TABLE fewmore;
