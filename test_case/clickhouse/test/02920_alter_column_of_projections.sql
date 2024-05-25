SYSTEM STOP MERGES t;
SET alter_sync = 0;
ALTER TABLE t MODIFY COLUMN j Int32;
SELECT count(j) FROM t GROUP BY name, age;
SYSTEM START MERGES t;
SET alter_sync = 1;
ALTER TABLE t MODIFY COLUMN j Int64 SETTINGS mutations_sync = 2;
SELECT count(j) FROM t GROUP BY name, age;
DROP TABLE t;