DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
DROP TABLE IF EXISTS t4;
SELECT count() FROM t1;
SELECT * FROM t2 LIMIT 18;
SELECT * FROM t3 where number > 17 and number < 25;
CREATE TABLE t4 AS numbers(100);
SELECT count() FROM t4 where number > 74;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;