drop table if exists t1;
create table t1 (a int auto_increment primary key, b char(20)) charset utf8mb4;
insert into t1 values(1,"test");
SELECT SQL_BUFFER_RESULT * from t1;
update t1 set b="a" where a=1;
delete from t1 where a=1;
insert into t1 values(1,"test"),(2,"test2");
SELECT SQL_BUFFER_RESULT * from t1;
update t1 set b="a" where a=1;
select 1 from t1,t1 as t2,t1 as t3;
update t1 set b="a";
update t1 set b="a" where b="test";
delete from t1;
delete from t1 where b="test";
delete from t1 where a+0=1;
select 1 from t1,t1 as t2,t1 as t3,t1 as t4,t1 as t5, t1 as t6;
select /*+ SET_VAR(max_join_size = 10) */
  1 from t1,t1 as t2,t1 as t3,t1 as t4,t1 as t5, t1 as t6;
select /*+ SET_VAR(max_join_size = 11) */
  1 from t1,t1 as t2,t1 as t3,t1 as t4,t1 as t5, t1 as t6;
update t1 set b="a" limit 1;
update t1 set b="a" where b="b" limit 2;
delete from t1 where b="test" limit 1;
delete from t1 where a+0=1 limit 2;
alter table t1 add key b (b);
SELECT @@MAX_JOIN_SIZE, @@SQL_BIG_SELECTS;
insert into t1 values (null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a");
SELECT * from t1 order by a;
SELECT * from t1 order by a;
SELECT * from t1;
SELECT * from t1 order by a;
insert into t1 values (null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a"),(null,"a");
drop table t1;
create table t1 (a int);
insert into t1 values (1),(2),(3),(4),(5);
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
select * from (select * from t1) x;
select * from (select * from t1) x;
select * from (select a.a as aa, b.a as ba from t1 a, t1 b) x;
select * from (select 1 union select 2 union select 3) x;
drop table t1;
CREATE TABLE t1 (c1 INT NOT NULL, c2 VARCHAR(200) NOT NULL,
                 UNIQUE KEY idx1 (c1), UNIQUE KEY idx2 (c2));
CREATE TABLE t2 (c1 INT NOT NULL, c2 VARCHAR(200) NOT NULL,
                 UNIQUE KEY idx1 (c1));
INSERT INTO t1 VALUES (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd');
INSERT INTO t2 VALUES (11, 'a'), (12, 'b'), (3, 'c'), (14, 'd');
DROP TABLE t1, t2;
CREATE TABLE t1(id INT PRIMARY KEY, x INT);
INSERT INTO t1
WITH RECURSIVE qn AS (SELECT 1 AS n UNION ALL SELECT 1+n FROM qn WHERE n < 100)
SELECT n, n FROM qn;
CREATE TABLE t2(id INT PRIMARY KEY, x INT);
INSERT INTO t2 SELECT * FROM t1 WHERE id <= 10;
SELECT /*+ SET_VAR(max_join_size = 110) */
COUNT(*) FROM t1, t2 WHERE t1.x = t2.x;
SELECT /*+ SET_VAR(max_join_size = 20) */
COUNT(*) FROM t1, t2 WHERE t1.id = t2.x;
SELECT /*+ SET_VAR(max_join_size = 110) */ COUNT(x) FROM t1
UNION ALL SELECT COUNT(x) FROM t2;
SELECT /*+ SET_VAR(max_join_size = 110) */ COUNT(x) FROM t1
UNION SELECT COUNT(x) FROM t2;
SELECT /*+ SET_VAR(max_join_size = 1111) */ COUNT(*) FROM t1, t2
WHERE t1.x=t2.x AND (SELECT MAX(t1.id+t2.id+t3.id) FROM t2 AS t3);
SELECT COUNT(*) FROM t1 LEFT JOIN t2
ON t1.x=t2.x AND (SELECT MAX(t1.id+t2.id+t3.id) FROM t2 AS t3);
SELECT COUNT(*) FROM t1 LEFT JOIN t2
ON t1.x=t2.x AND (SELECT MAX(t1.id+t2.id+t3.id) FROM t2 AS t3);
SELECT COUNT(*) FROM t1, t2
WHERE t1.x=t2.x AND (SELECT DISTINCT t3.x>0 FROM t2 AS t3);
SELECT COUNT(*) FROM t1, t2
WHERE t1.x=t2.x AND (SELECT DISTINCT t3.x>0 FROM t2 AS t3);
SELECT /*+ SET_VAR(max_join_size=110) */ COUNT(*) FROM
(SELECT DISTINCT x FROM t1) AS dt1,
(SELECT DISTINCT x FROM t2) AS dt2 WHERE dt1.x=dt2.x;
DROP TABLE t1, t2;
CREATE TABLE t(id INT PRIMARY KEY AUTO_INCREMENT, x INT, y INT, KEY (x));
INSERT INTO t(x, y) VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
                           (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
INSERT INTO t(x, y) SELECT x, y FROM t;
INSERT INTO t(x, y) SELECT x, y FROM t;
INSERT INTO t(x, y) SELECT x, y FROM t;
SELECT 1 FROM t LIMIT 10;
SELECT x FROM t ORDER BY x LIMIT 10;
SELECT * FROM t ORDER BY id LIMIT 10;
SELECT 1 FROM t LIMIT 10;
SELECT x FROM t ORDER BY x LIMIT 10;
SELECT * FROM t ORDER BY id LIMIT 10;
SELECT 1 FROM t WHERE y = 3 ORDER BY x LIMIT 3;
SELECT 1 FROM t WHERE y = 3 ORDER BY x LIMIT 3;
SELECT /*+ SET_VAR(max_join_size = 80) */ y FROM t ORDER BY y LIMIT 10;
SELECT SUM(y) FROM t LIMIT 10;
SELECT SUM(y) FROM t GROUP BY x LIMIT 10;
SELECT SUM(x) FROM t GROUP BY y LIMIT 10;
SELECT SUM(y) FROM t LIMIT 10;
SELECT SUM(y) FROM t GROUP BY x LIMIT 10;
SELECT SUM(x) FROM t GROUP BY y LIMIT 10;
SELECT 1 FROM t AS t1, t AS t2 WHERE t1.x = t2.x LIMIT 16;
SELECT 1 FROM t AS t1, t AS t2 WHERE t1.x = t2.x LIMIT 16;
SELECT 1 FROM t AS t1, t AS t2 WHERE t1.y = t2.y LIMIT 16;
SELECT 1 FROM t AS t1, t AS t2 WHERE t1.y = t2.y LIMIT 16;
DROP TABLE t;
