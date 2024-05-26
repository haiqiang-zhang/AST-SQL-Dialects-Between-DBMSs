DROP TABLE IF EXISTS 02005_test_table;
CREATE TABLE 02005_test_table
(
    value Map(Int64, Int64)
)
ENGINE = TinyLog;
SELECT 'mapPopulateSeries with map';
SELECT 'Without max key';
SELECT mapPopulateSeries(value) FROM 02005_test_table;
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES (map(0, 5));
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES (map(0, 5, 5, 10));
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES (map(-5, -5, 0, 5, 5, 10));
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES (map(-5, -5, 0, 5, 5, 10, 10, 15));
TRUNCATE TABLE 02005_test_table;
SELECT 'With max key';
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES (map(0, 5));
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES (map(0, 5, 5, 10));
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES (map(-5, -5, 0, 5, 5, 10));
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES (map(-5, -5, 0, 5, 5, 10, 10, 15));
TRUNCATE TABLE 02005_test_table;
SELECT 'Possible verflow';
SELECT 'Duplicate keys';
DROP TABLE 02005_test_table;
DROP TABLE IF EXISTS 02005_test_table;
CREATE TABLE 02005_test_table
(
    key Array(Int64),
    value Array(Int64)
)
ENGINE = TinyLog;
SELECT 'mapPopulateSeries with two arrays';
SELECT 'Without max key';
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES ([0], [5]);
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES ([0, 5], [5, 10]);
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES ([-5, 0, 5], [-5, 5, 10]);
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES ([-5, 0, 5, 10], [-5, 5, 10, 15]);
TRUNCATE TABLE 02005_test_table;
SELECT 'With max key';
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES ([0], [5]);
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES ([0, 5], [5, 10]);
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES ([-5, 0, 5], [-5, 5, 10]);
TRUNCATE TABLE 02005_test_table;
INSERT INTO 02005_test_table VALUES ([-5, 0, 5, 10], [-5, 5, 10, 15]);
TRUNCATE TABLE 02005_test_table;
SELECT 'Possible verflow';
SELECT 'Duplicate keys';
DROP TABLE 02005_test_table;
