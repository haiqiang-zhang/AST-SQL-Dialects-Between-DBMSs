SET allow_experimental_analyzer = 1;
SELECT tuple(1, 'a').1;
SELECT CAST(('hello', 1) AS Tuple(hello String, count UInt32)) AS t, t.hello;
SELECT '---';
SELECT CAST(('hello', 1) AS Tuple(name String, count UInt32)).*;
SELECT untuple(CAST(('hello', 1) AS Tuple(name String, count UInt32)));
SELECT '---';
SELECT * EXCEPT('hello|world');
SELECT * EXCEPT(hello) REPLACE(x + 1 AS x);
SELECT '---';
SELECT * FROM (SELECT x, x FROM (SELECT 1 AS x));
SELECT x FROM (SELECT x, x FROM (SELECT 1 AS x));
SELECT 1 FROM (SELECT x, x FROM (SELECT 1 AS x));
SELECT '---';
SELECT `plus(1, 2)` FROM (SELECT 1 + 2);
SELECT '---';
SELECT x FROM numbers(5 AS x);
SELECT '---';
CREATE TEMPORARY TABLE aliased
(
    x UInt8 DEFAULT 0,
    y ALIAS x + 1
);
INSERT INTO aliased VALUES (10);
SELECT y FROM aliased;
CREATE TEMPORARY TABLE aliased2
(
    x UInt8,
    y ALIAS ((x + 1) AS z) + 1
);
SELECT '---';
CREATE TEMPORARY TABLE aliased3
(
    x UInt8,
    y ALIAS z + 1,
    z ALIAS x + 1
);
INSERT INTO aliased3 VALUES (10);
SELECT x, y, z FROM aliased3;
