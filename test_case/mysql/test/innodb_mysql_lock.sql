DROP TABLE IF EXISTS t1;
CREATE TABLE t1(s1 INT UNIQUE) ENGINE=innodb;
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
SELECT COUNT(*) = 1 FROM information_schema.innodb_trx
  WHERE trx_query = 'INSERT INTO t1 VALUES (1)' AND
  trx_operation_state = 'inserting' AND
  trx_state = 'LOCK WAIT';
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE info = "DROP TABLE t1" and 
  state = "Waiting for table metadata lock";
drop table if exists t1;
create table t1 (c1 int primary key, c2 int, c3 int) engine=InnoDB;
insert into t1 values (1,1,0),(2,2,0),(3,3,0),(4,4,0),(5,5,0);
update t1 set c3=c3+1 where c2=3;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column c4 int";
update t1 set c3=c3+1 where c2=4;
drop table t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT) engine=innodb;
INSERT INTO t1 VALUES (1), (2), (3);
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1, t2;
DROP VIEW IF EXISTS v2;
CREATE TABLE t1 ( f1 INTEGER ) ENGINE = innodb;
CREATE TABLE t2 ( f1 INTEGER );
CREATE VIEW v1 AS SELECT 1 FROM t1;
LOCK TABLE t1 WRITE;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND info = "SELECT * FROM v1";
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER VIEW v1 AS SELECT 2 FROM t2";
UNLOCK TABLES;
SELECT * FROM v1;
DROP TABLE t1, t2;
DROP VIEW v1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT PRIMARY KEY, value INT) ENGINE = InnoDB;
INSERT INTO t1 VALUES (1, 12345);
SELECT * FROM t1;
ALTER TABLE t1 ADD INDEX idx(value);
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INT, b VARCHAR(250), PRIMARY KEY(a,b))
  engine=innodb default charset=utf8mb3;
INSERT INTO t1 VALUES (1, 'a'), (2, 'b');
CREATE INDEX t1ba ON t1(b,a);
DROP TABLE t1;
