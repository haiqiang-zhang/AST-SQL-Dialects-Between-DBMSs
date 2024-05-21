DROP TABLE IF EXISTS test_00562;
CREATE TABLE test_00562 ( s String,  i Int64) ENGINE = Memory;
INSERT INTO test_00562 VALUES('test_string', 1);
SELECT s, SUM(i*2) AS i FROM test_00562 GROUP BY s  UNION ALL  SELECT s, SUM(i*2) AS i FROM test_00562 GROUP BY s;
SELECT s FROM (SELECT s, SUM(i*2) AS i FROM test_00562 GROUP BY s  UNION ALL  SELECT s, SUM(i*2) AS i FROM test_00562 GROUP BY s);
DROP TABLE IF EXISTS test_00562;