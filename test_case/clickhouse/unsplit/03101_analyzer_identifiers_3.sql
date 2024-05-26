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
SELECT '---';
SELECT * FROM (SELECT 1 AS a) AS t, (SELECT 2 AS b) AS u;
SELECT a, b FROM (SELECT 1 AS a) AS t, (SELECT 2 AS b) AS u;
SELECT '---';
SELECT * FROM (SELECT 1 AS a) AS t, (SELECT 1 AS a) AS u;
SELECT t.a, u.a FROM (SELECT 1 AS a) AS t, (SELECT 1 AS a) AS u;
SELECT '---';
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
