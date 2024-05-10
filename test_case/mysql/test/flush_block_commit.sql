DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT) ENGINE=innodb;
INSERT INTO t1 VALUES(1);
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock" and info = "COMMIT";
SELECT * FROM t1;
UNLOCK TABLES;
SELECT * FROM t1 FOR UPDATE;
UNLOCK TABLES;
INSERT INTO t1 VALUES(10);
UNLOCK TABLES;
SELECT * FROM t1;
DROP TABLE t1;
