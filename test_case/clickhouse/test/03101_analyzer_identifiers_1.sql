SELECT t.column FROM table AS t;
USE default;
SELECT t1.x, t2.x, y FROM
    (SELECT x, y FROM VALUES ('x UInt16, y UInt16', (0,1))) AS t1,
    (SELECT x, z FROM VALUES ('x UInt16, z UInt16', (2,3))) AS t2;
SELECT '---';
SELECT 1;
SELECT dummy;
SELECT one.dummy;
SELECT system.one.dummy;
SELECT *;
SELECT '---';
SELECT * FROM (SELECT [1, 2, 3] AS arr) ARRAY JOIN arr;
