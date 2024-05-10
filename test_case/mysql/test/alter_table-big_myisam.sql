CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t2 (i INT) ENGINE=MyISAM;
LOCK TABLES t1 WRITE, t2 WRITE;
ALTER TABLE t1 RENAME TO t3;
SELECT * FROM t3;
ALTER TABLE t2 RENAME TO t4;
SELECT * FROM t4;
SELECT * FROM t4;
UNLOCK TABLES;
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t2 (i INT) ENGINE=MyISAM;
LOCK TABLES t1 WRITE, t2 WRITE;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t2;
UNLOCK TABLES;
DROP TABLES t1, t4;
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE DATABASE mysqltest;
LOCK TABLES t1 WRITE, t2 WRITE;
SELECT * FROM t1;
DROP TABLE t1;
ALTER TABLE t2 RENAME COLUMN i TO j, RENAME TO t4, ALGORITHM=COPY;
SELECT * FROM t4;
SELECT * FROM t4;
UNLOCK TABLES;
LOCK TABLE t4 WRITE;
SELECT * FROM t4;
SELECT * FROM t4;
UNLOCK TABLES;
DROP DATABASE mysqltest;
CREATE TABLE t1 (pk INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t2 (fk INT) ENGINE=MyISAM;
LOCK TABLES t2 WRITE, t1 WRITE;
SELECT * FROM t2;
SELECT * FROM t2;
DELETE FROM t1;
UNLOCK TABLES;
DROP TABLES t3, t1;
CREATE TABLE t1(a INT) ENGINE=MyISAM;
ALTER TABLE t1 modify column a varchar(30);
SELECT COUNT(TABLE_NAME) FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_SCHEMA='test' AND TABLE_NAME like '#sql%';
DROP TABLE t1;
drop table if exists t1, t2;
create table t1 (n1 int, n2 int, n3 int,
                key (n1, n2, n3),
                key (n2, n3, n1),
                key (n3, n1, n2));
create table t2 (i int) engine=innodb;
alter table t1 disable keys;
insert into t1 values (1, 2, 3);
insert into t2 values (1);
select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t1 values (1, 1, 1)";
drop tables t1, t2;
