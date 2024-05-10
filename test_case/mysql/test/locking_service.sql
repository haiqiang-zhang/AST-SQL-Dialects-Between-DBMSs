SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for locking service lock";
SELECT COUNT(*) = 1 AS expect_1 FROM information_schema.processlist
WHERE state = 'Waiting for locking service lock';
SELECT COUNT(*) = 0 AS expect_1 FROM information_schema.processlist
WHERE state = 'Waiting for locking service lock';
CREATE TEMPORARY TABLE t1 AS SELECT 1 AS col1;
DROP TEMPORARY TABLE t1;
CREATE TABLE t1 (col1 VARCHAR(10));
INSERT INTO t1 VALUES ('l1'), ('l2'), ('l3');
DROP TABLE t1;
