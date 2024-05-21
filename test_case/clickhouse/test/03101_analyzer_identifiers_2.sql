SET allow_experimental_analyzer = 1;
CREATE TEMPORARY TABLE test1 (a String, nest Nested(x String, y String));
SELECT a, nest.* FROM test1 ARRAY JOIN nest;
SELECT a, n.* FROM test1 ARRAY JOIN nest AS n;
CREATE TEMPORARY TABLE test2 (a String, nest Array(Tuple(x String, y String)));
SELECT a, nest.* FROM test2 ARRAY JOIN nest;
SELECT a, n.* FROM test2 ARRAY JOIN nest AS n;
SELECT 1 AS x, x, x + 1;
SELECT x, x + 1, 1 AS x;
SELECT x, 1 + (2 + (3 AS x));
SELECT '---';
SELECT 123 AS x FROM (SELECT a, x FROM (SELECT 1 AS a, 2 AS b));
SELECT '---';
SELECT 123 AS x, (SELECT x) AS y;
SELECT 123 AS x, 123 IN (SELECT x);
SELECT '---';
WITH 123 AS x SELECT 555 FROM (SELECT a, x FROM (SELECT 1 AS a, 2 AS b));
SELECT '---';
WITH t AS (SELECT 1) SELECT t, (SELECT * FROM t) FROM t;
-- throws, because x is not visible outside.
SELECT x FROM (SELECT y FROM VALUES ('y UInt16', (2)) WHERE (1 AS x) = y) AS t;
-- throws, because the table name `t` is not visible outside
SELECT t.x FROM (SELECT * FROM (SELECT 1 AS x) AS t);
SELECT x FROM (SELECT * FROM (SELECT 99 AS x) AS t);
SELECT '---';
SELECT t.x FROM (SELECT 1 AS x) AS t;
SELECT t.a FROM (SELECT a FROM test1) AS t;
SELECT a FROM (SELECT a FROM test1) AS t;
SELECT '---';
SELECT test1.a FROM (SELECT a FROM test1) AS t;
-- this is also wrong, the `t2` alias is not exported
SELECT test1.a FROM (SELECT a FROM test1 AS t2) AS t;
-- does not work, `x` is not visible;
SELECT x, (SELECT 1 AS x);
-- does not work either;
SELECT x IN (SELECT 1 AS x);
-- this will work, but keep in mind that there are two different `x`.
SELECT x IN (SELECT 1 AS x) FROM (SELECT 1 AS x);
SELECT '---';
SELECT x + 1 AS x, x FROM (SELECT 1 AS x);
SELECT x, x + 1 AS x FROM (SELECT 1 AS x);
SELECT 1 AS x, 2 AS x;
SELECT '---';
SELECT arrayMap(x -> x + 1, [1, 2]);
SELECT x, arrayMap((x, y) -> x[1] + y + arrayFirst(x -> x != y, x), arr) FROM (SELECT 1 AS x, [([1, 2], 3), ([4, 5], 6)] AS arr);
SELECT x1, arrayMap((x2, y2) -> x2[1] + y2 + arrayFirst(x3 -> x3 != y2, x2), arr) FROM (SELECT 1 AS x1, [([1, 2], 3), ([4, 5], 6)] AS arr);
SELECT arrayMap(x -> [y * 2, (x + 1) AS y, 1 AS z], [1, 2]), y;
-- TODO: this must work
--SELECT arrayMap(x -> [y * 2, (x + 1) AS y, 1 AS z], [1, 2]), z;
SELECT arrayMap(x -> (x + 1) AS y, [3, 5]), arrayMap(x -> (x || 'hello') AS y, ['qq', 'ww']);