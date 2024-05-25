SELECT * FROM t2;
SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                      WHERE info = "UPDATE t2 SET f2 = 10 WHERE f1 = 5" AND
                            state LIKE '%skip_check_constraints_on_unaffected_columns%';
SELECT * FROM t2;
CREATE TABLE t1 (c1 INT, c2 INT CHECK (c2 < 100));
ALTER TABLE t1 DROP COLUMN c2;
DROP TABLE t1;
