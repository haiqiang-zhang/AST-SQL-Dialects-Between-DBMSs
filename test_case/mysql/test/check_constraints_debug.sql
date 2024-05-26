SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t2 (f1 INT, f2 INT, CONSTRAINT t1_ck CHECK(f2 < 10))";
SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t3 (f1 INT, CONSTRAINT t1_chk_1 CHECK (f1 < 10))";
SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t3 (f1 INT, CONSTRAINT t1_chk_1 CHECK (f1 < 10))";
SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t2 (f1 INT, CONSTRAINT t1_chk_1 CHECK (f1 < 10))";
SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t2 (f1 INT, CONSTRAINT t1_chk_1 CHECK (f1 < 10))";
CREATE TABLE t2 (f1 INT, f2 INT, f3 INT CONSTRAINT f3_ck CHECK(f3 < 10));
INSERT INTO t2 VALUES (5, 5, 5);
SELECT * FROM t2;
SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                      WHERE info = "UPDATE t2 SET f2 = 10 WHERE f1 = 5" AND
                            state LIKE '%skip_check_constraints_on_unaffected_columns%';
SELECT * FROM t2;
CREATE TABLE t1 (c1 INT, c2 INT CHECK (c2 < 100));
ALTER TABLE t1 DROP COLUMN c2;
DROP TABLE t1;
