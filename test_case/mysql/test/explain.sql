drop table if exists t1;
create table t1 (id int not null, str char(10), unique(str)) charset utf8mb4;
insert into t1 values (1, null),(2, null),(3, "foo"),(4, "bar");
select * from t1 where str is null;
select * from t1 where str="foo";
drop table t1;

create table t1 (a int not null);
insert into t1 values(1);
insert into t1 values(1);
drop table t1;

--
-- Bug #3403 Wrong encoding in EXPLAIN SELECT output
--
set names koi8r;
create table таб (кол0 int, кол1 int, key инд0 (кол0), key инд01 (кол0,кол1));
insert into таб (кол0) values (1);
insert into таб (кол0) values (2);
drop table таб;
set names latin1;

-- End of 4.1 tests


--
-- Bug#15463: EXPLAIN SELECT..INTO hangs the client (QB, command line)
--
select 3 into @v1;

--
-- Bug#22331: Wrong WHERE in EXPLAIN when all expressions were
--            optimized away.
--
create table t1(f1 int, f2 int);
insert into t1 values (1,1);
create view v1 as select * from t1 where f1=1;
drop view v1;
drop table t1;

--
-- Bug #32241: memory corruption due to large index map in 'Range checked for 
--             each record'
--

CREATE TABLE t1(c INT);
INSERT INTO t1 VALUES (),();

CREATE TABLE t2 (b INT,
KEY(b),KEY(b),KEY(b),KEY(b),KEY(b),
KEY(b),KEY(b),KEY(b),KEY(b),KEY(b),
KEY(b),KEY(b),KEY(b),KEY(b),KEY(b),
KEY(b),KEY(b),KEY(b),KEY(b),KEY(b),
KEY(b),KEY(b),KEY(b),KEY(b),KEY(b),
KEY(b),KEY(b),KEY(b),KEY(b),KEY(b),
KEY(b),KEY(b),KEY(b),KEY(b),KEY(b),
KEY(b),KEY(b),KEY(b),KEY(b),KEY(b));

INSERT INTO t2 VALUES (),(),();

-- We only need to make sure that there is no buffer overrun and the index map
-- is displayed correctly
--replace_column 1 X 2 X 3 X 5 X 6 X 7 X 8 X 9 X 10 X
EXPLAIN SELECT 1 FROM
  (SELECT 1 FROM t2,t1 WHERE b < c GROUP BY 1 LIMIT 1) AS d2;
DROP TABLE t2;
DROP TABLE t1;

--
-- Bug #34773: query with explain and derived table / other table
-- crashes server
--

CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
INSERT INTO t1 VALUES (1),(2);
INSERT INTO t2 VALUES (1),(2);

DROP TABLE t1,t2;


--
-- Bug #43354: Use key hint can crash server in explain query
--

CREATE TABLE t1 (a INT PRIMARY KEY);

DROP TABLE t1;

--
-- Bug#45989 memory leak after explain encounters an error in the query
--
CREATE TABLE t1(a LONGTEXT);
INSERT INTO t1 VALUES (repeat('a',@@global.max_allowed_packet));
INSERT INTO t1 VALUES (repeat('b',@@global.max_allowed_packet));
        (SELECT a AS away FROM t1 GROUP BY a WITH ROLLUP) as d1
         WHERE t1.a = d1.a;
        (SELECT DISTINCTROW a AS away FROM t1 GROUP BY a WITH ROLLUP) as d1
         WHERE t1.a = d1.a;
DROP TABLE t1;

CREATE TABLE t1 (f1 INT);

SELECT @@session.sql_mode INTO @old_sql_mode;
SET SESSION sql_mode='ONLY_FULL_GROUP_BY';

-- EXPLAIN (with subselect). used to crash.
-- This is actually a valid query for this sql_mode,
-- but it was transformed in such a way that it failed, see
-- Bug#12329653 - EXPLAIN, UNION, PREPARED STATEMENT, CRASH, SQL_FULL_GROUP_BY
EXPLAIN SELECT 1 FROM t1
                          WHERE f1 > ALL( SELECT t.f1 FROM t1,t1 AS t );

SET SESSION sql_mode=@old_sql_mode;

DROP TABLE t1;
set @opt_sw_save=  @@optimizer_switch;
{
  set optimizer_switch='semijoin=off';
create table t1 (dt datetime not null, t time not null);
create table t2 (dt datetime not null);
insert into t1 values ('2001-01-01 1:1:1', '1:1:1'),
('2001-01-01 1:1:1', '1:1:1');
insert into t2 values ('2001-01-01 1:1:1'), ('2001-01-01 1:1:1');
SELECT outr.dt FROM t1 AS outr WHERE outr.dt IN (SELECT innr.dt FROM t2 AS innr WHERE outr.dt IS NULL );
SELECT outr.dt FROM t1 AS outr WHERE outr.dt IN ( SELECT innr.dt FROM t2 AS innr WHERE outr.t < '2005-11-13 7:41:31' );
drop tables t1, t2;
set optimizer_switch= @opt_sw_save;

CREATE TABLE t1 (c int);
INSERT INTO t1 VALUES (NULL);
CREATE TABLE t2 (d int);
INSERT INTO t2 VALUES (NULL), (0);
DROP TABLE t1, t2;
create table t1(f1 int);
create table t2(f2 int);
insert into t1 values(1);
insert into t2 values(1),(2);
drop table t1,t2;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (b BLOB, KEY b(b(100)));
INSERT INTO t2 VALUES ('1'), ('2'), ('3');

DROP TABLE t1, t2;

CREATE TABLE t1(c1 INT, c2 INT, c4 INT, c5 INT, KEY(c2, c5), KEY(c2, c4, c5));
INSERT INTO t1 VALUES(4, 1, 1, 1);
INSERT INTO t1 VALUES(3, 1, 1, 1);
INSERT INTO t1 VALUES(2, 1, 1, 1);
INSERT INTO t1 VALUES(1, 1, 1, 1);

DROP TABLE t1;

CREATE TABLE t1(f1 VARCHAR(6) NOT NULL,
FULLTEXT KEY(f1),UNIQUE(f1));
INSERT INTO t1 VALUES ('test');
 ON (MATCH(t1.f1) AGAINST (""))
 WHERE t1.f1 GROUP BY t1.f1))';
 ON (MATCH(t1.f1) AGAINST (""))
 WHERE t1.f1 GROUP BY t1.f1))';

DROP TABLE t1;
drop table if exists t1;
create table `t1` (`a` int);
drop table t1;
 SELECT 1
 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
 ;

CREATE TABLE t1 (url char(1) PRIMARY KEY) charset latin1;
INSERT INTO t1 VALUES ('1'),('2'),('3'),('4'),('5');
SELECT * FROM t1 WHERE url=1;
SELECT * FROM t1 WHERE url='1' collate latin1_german2_ci;
SELECT * FROM t1 WHERE url>3;
SELECT * FROM t1 WHERE url>'3' collate latin1_german2_ci;
DROP TABLE t1;

CREATE TABLE t1(a INT);

INSERT INTO t1 VALUES (0), (0);
SELECT SUBSTRING(1, (SELECT 1 FROM t1 a1 RIGHT OUTER JOIN t1 ON 0)) AS d
FROM t1 WHERE 0 > ANY (SELECT @a FROM t1)';
DROP TABLE t1;

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
CREATE TABLE t2 (a INT);
INSERT INTO t2 VALUES (3),(4),(5);

-- LIMIT <offset> is for SELECT, not for EXPLAIN OUTPUT:
--echo -- EXPLAIN must return 3 rows:
EXPLAIN SELECT SQL_CALC_FOUND_ROWS * FROM t1 UNION SELECT * FROM t2 LIMIT 2,2;

DROP TABLE t1, t2;
CREATE TABLE t1(a INT);
DROP TABLE t1;

CREATE TABLE t1(c1 INT PRIMARY KEY) ENGINE=INNODB;
INSERT INTO t1 VALUES (1),(2),(3);
DROP TABLE t1;

CREATE TABLE t1 (a INT, b INT) ENGINE=INNODB PARTITION BY KEY (b) PARTITIONS 2;
CREATE TABLE t2 (c INT) ENGINE=INNODB;
UPDATE t1 SET a=(SELECT c from t2) WHERE 0;
DELETE FROM t1 WHERE 0 AND a IN (SELECT c from t2);
DROP TABLE t1, t2;

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(NULL);
SELECT COUNT(*) FROM t1 WHERE a<>a;
SELECT a<>a FROM t1;
SELECT COUNT(*) FROM t1 WHERE a>a;
SELECT a>a FROM t1;
SELECT COUNT(*) FROM t1 WHERE a<a;
SELECT a<a FROM t1;
SELECT COUNT(*) FROM t1 WHERE a<=>a;
SELECT a<=>a FROM t1;
SELECT COUNT(*) FROM t1 WHERE a<=a;
SELECT a<=a FROM t1;
SELECT COUNT(*) FROM t1 WHERE a>=a;
SELECT a>=a FROM t1;
SELECT COUNT(*) FROM t1 WHERE a=a;
SELECT a=a FROM t1;
SELECT COUNT(*) FROM t1 WHERE a<>a IS NOT FALSE;
SELECT COUNT(*) FROM t1 WHERE (a=1 AND a<>a IS NOT FALSE);
SELECT * FROM t1 WHERE (a= 1 OR a<>a);
SELECT * FROM t1 WHERE (a=1 AND a<>a);

UPDATE t1 SET a = 2 WHERE a IS NULL;
ALTER TABLE t1 MODIFY a INT NOT NULL;
SELECT COUNT(*) FROM t1 WHERE a<>a;
SELECT COUNT(*) FROM t1 WHERE a>a;
SELECT COUNT(*) FROM t1 WHERE a<a;
SELECT COUNT(*) FROM t1 WHERE a<=>a;
SELECT COUNT(*) FROM t1 WHERE a<=a;
SELECT COUNT(*) FROM t1 WHERE a>=a;
SELECT COUNT(*) FROM t1 WHERE a=a;
SELECT COUNT(*) FROM t1 WHERE a<>a IS NOT FALSE;
SELECT COUNT(*) FROM t1 WHERE (a=1 AND a<>a IS NOT FALSE);
SELECT * FROM t1 WHERE (a=1 OR a<>a);
SELECT * FROM t1 WHERE (a=1 AND a<>a);

DROP TABLE t1;

CREATE TABLE r(a INT);
INSERT INTO r VALUES (1), (2), (-1), (-2);
CREATE TABLE s(a INT);
INSERT INTO s VALUES (1), (10), (20), (-10), (-20);
CREATE TABLE t(a INT);
INSERT INTO t VALUES (10), (100), (200), (-100), (-200);
let $query =
         ( ( SELECT * FROM r UNION
             (SELECT * FROM s ORDER BY a LIMIT 1)) UNION
           ( SELECT * FROM s UNION SELECT 2 LIMIT 3)
            ORDER BY 1 LIMIT 3)
         ORDER BY 1;
let $query =
     (SELECT * FROM r
      UNION SELECT * FROM s);
let $1=200;
 let $query =
     ($query
      UNION SELECT * FROM s);
 dec $1;
let $query = SELECT * FROM r INTERSECT SELECT * FROM s;

let $query = SELECT * FROM r INTERSECT ALL SELECT * FROM s;
let $query = SELECT * FROM r EXCEPT SELECT * FROM s;

let $query = SELECT * FROM r EXCEPT ALL SELECT * FROM s;

DROP TABLE r, s, t;
