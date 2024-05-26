drop table if exists t1;
select {fn length("hello")}, { date "1997-10-20" };
create table t1 (a int not null auto_increment,b int not null,primary key (a,b));
insert into t1 SET A=NULL,B=1;
insert into t1 SET a=null,b=2;
select * from t1 where a is null and b=2;
select * from t1 where a is null;
drop table t1;
CREATE TABLE t1 (a INT AUTO_INCREMENT PRIMARY KEY);
INSERT INTO t1 VALUES (NULL);
SELECT a, last_insert_id() FROM t1 WHERE a IS NULL;
DROP TABLE t1;
CREATE TABLE t1(a BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY);
CREATE TABLE t2(b INT);
INSERT INTO t2 VALUES (2),(3),(4);
INSERT INTO t1 VALUES ();
SELECT * FROM t2 LEFT JOIN t1 ON a=b WHERE a IS NULL;
INSERT INTO t1 VALUES ();
SELECT * FROM t2 LEFT JOIN t1 ON a=b WHERE a IS NULL;
INSERT INTO t1 VALUES ();
SELECT * FROM t1 HAVING a IS NULL;
SELECT a, a IS NULL FROM t1 WHERE a IS NULL;
SELECT * FROM t1 WHERE a IS NULL;
SELECT * FROM t1 WHERE a IS NULL;
INSERT INTO t1 VALUES (9223372036854775807);
INSERT INTO t1 VALUES ();
SELECT * FROM t1 WHERE a IS NULL;
DROP TABLE t1, t2;
