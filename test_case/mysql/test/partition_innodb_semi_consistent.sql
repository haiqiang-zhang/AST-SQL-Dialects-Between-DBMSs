select * from t1 where a=3 lock in share mode;
update t1 set a=10 where a=5;
update t1 set a=10 where a=5;
select * from t1 where a=2 for update;
select * from t1 where a=2 limit 1 for update;
update t1 set a=11 where a=6;
update t1 set a=12 where a=2;
update t1 set a=13 where a=1;
update t1 set a=14 where a=1;
select * from t1;
drop table t1;
CREATE TABLE t1 (a INT PRIMARY KEY, b VARCHAR(256))
ENGINE = InnoDB
PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (300),
 PARTITION p1 VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (1,2);
UPDATE t1 SET b = 12 WHERE a = 1;
SELECT * FROM t1;
UPDATE t1 SET b = 21 WHERE a = 1;
SELECT * FROM t1;
CREATE TABLE t2 (a INT);
INSERT INTO t2 VALUES ();
UPDATE t1 SET b = CONCAT(b, '+con1') WHERE a = 1;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
DELETE FROM t2;
UPDATE t1 SET a = 2, b = CONCAT(b, '+con1') WHERE a = 1;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1, t2;
