-- Looks like you cannot use the query parameter as a column name.
-- https://github.com/ClickHouse/ClickHouse/issues/23194
SET allow_experimental_analyzer = 1;
DROP DATABASE IF EXISTS db1_03101;
DROP DATABASE IF EXISTS db2_03101;
CREATE DATABASE db1_03101;
CREATE DATABASE db2_03101;
USE db1_03101;
CREATE TABLE db1_03101.tbl
(
    col String,
    db1_03101 Nested
    (
        tbl Nested
        (
            col String
        )
    )
)
ENGINE = Memory;
SELECT db1_03101.tbl.col FROM db1_03101.tbl;
SELECT db1_03101.* FROM tbl;
SELECT db1_03101 FROM tbl;
SELECT * FROM tbl;
SELECT count(*) FROM tbl;
SELECT * + * FROM VALUES('a UInt16', 1, 10);
SELECT '---';
SELECT * GROUP BY *;
though can be supported in some sense
-- but it works
SELECT * ORDER BY *;
SELECT * WHERE *;
SELECT '---';
SELECT * FROM (SELECT 1 AS a) AS t, (SELECT 2 AS b) AS u;
SELECT a, b FROM (SELECT 1 AS a) AS t, (SELECT 2 AS b) AS u;
SELECT '---';
SELECT * FROM (SELECT 1 AS a) AS t, (SELECT 1 AS a) AS u;
SELECT t.a, u.a FROM (SELECT 1 AS a) AS t, (SELECT 1 AS a) AS u;
SELECT '---';
--CREATE TABLE db1_03101.t
--(
--    a UInt16
--)
--ENGINE = Memory;
--CREATE TABLE db2_03101.t
--(
--    a UInt16
--)
--ENGINE = Memory;
--SELECT * FROM (SELECT 1 AS a) AS db2_03101.t, (SELECT 1 AS a) AS db1_03101.t;
--SELECT db2_03101.t.a, db1_03101.t.a FROM (SELECT 1 AS a) AS db2_03101.t, (SELECT 1 AS a) AS db1_03101.t;
CREATE TABLE t
(
    x String,
    nest Nested
    (
        a String,
        b String
    )
) ENGINE = Memory;
SELECT * FROM t;
SELECT x, nest.* FROM t;
SELECT x, nest.a, nest.b FROM t;