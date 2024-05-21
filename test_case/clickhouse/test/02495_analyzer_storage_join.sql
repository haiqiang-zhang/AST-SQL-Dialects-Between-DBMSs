DROP TABLE IF EXISTS t;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS tj;
SET allow_experimental_analyzer = 1;
SET single_join_prefer_left_table = 0;
CREATE TABLE tj (key2 UInt64, key1 Int64, a UInt64, b UInt64, x UInt64, y UInt64) ENGINE = Join(ALL, RIGHT, key1, key2);
INSERT INTO tj VALUES (2, -2, 20, 200, 2000, 20000), (3, -3, 30, 300, 3000, 30000), (4, -4, 40, 400, 4000, 40000), (5, -5, 50, 500, 5000, 50000), (6, -6, 60, 600, 6000, 60000);
SELECT '--- no name clashes ---';
CREATE TABLE t1 (id2 UInt64, id1 Int64, val UInt64) ENGINE = Memory;
INSERT INTO t1 VALUES (1, -1, 11), (2, -2, 22), (3, -3, 33), (4, -4, 44), (5, -5, 55);
SELECT '--- name clashes ---';
CREATE TABLE t (key2 UInt64, key1 Int64, b UInt64, x UInt64, val UInt64) ENGINE = Memory;
INSERT INTO t VALUES (1, -1, 11, 111, 1111), (2, -2, 22, 222, 2222), (3, -3, 33, 333, 2222), (4, -4, 44, 444, 4444), (5, -5, 55, 555, 5555)

SELECT '-- using --';
SELECT '-- on --';
SELECT '--- unsupported and illegal conditions ---';
DROP TABLE IF EXISTS t;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS tj;