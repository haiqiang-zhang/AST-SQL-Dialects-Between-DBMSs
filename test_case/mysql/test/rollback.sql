CREATE TABLE t1 (i INT);
CREATE TABLE t0 (j INT);
CREATE TEMPORARY TABLE tt AS SELECT * FROM t1;
INSERT INTO tt VALUES (1), (2), (3);
DROP TEMPORARY TABLE tt;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "DROP TABLES t0, t1";
SELECT * FROM t0;
