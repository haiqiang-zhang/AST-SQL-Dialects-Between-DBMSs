ATTACH ':memory:' AS db1;
CREATE TABLE db1.tbl AS SELECT 42 AS x, 3 AS y;
CREATE MACRO db1.two_x_plus_y(x, y) AS 2 * x + y;
USE db1;
SELECT db1.two_x_plus_y(x, y) FROM db1.tbl;
SELECT db1.main.two_x_plus_y(x, y) FROM db1.tbl;
SELECT two_x_plus_y(x, y) FROM db1.tbl;
