
CREATE TABLE t1(a INTEGER);
INSERT INTO t1 VALUES(11),(12),(13),(14),(15),(16),(17),(18),(19);

CREATE TABLE t2(a INTEGER);
INSERT INTO t2 VALUES(21),(22),(23),(24),(25),(26),(27);

SELECT * FROM t1 LIMIT 6;

SELECT * FROM t1 LIMIT 5 OFFSET 1;

SELECT * FROM t1 UNION SELECT * FROM t2 LIMIT 5;

SELECT * FROM t1 UNION SELECT * FROM t2 LIMIT 5 OFFSET 6;

SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a LIMIT 5;

SELECT * FROM t1 UNION SELECT * FROM t2 ORDER BY a LIMIT 5 OFFSET 6;

SELECT * FROM t1 UNION ALL SELECT * FROM t2 LIMIT 5;

SELECT * FROM t1 UNION ALL SELECT * FROM t2 LIMIT 5 OFFSET 6;

SELECT * FROM t1 UNION ALL SELECT * FROM t2 ORDER BY a LIMIT 5;

SELECT * FROM t1 UNION ALL SELECT * FROM t2 ORDER BY a LIMIT 5 OFFSET 6;
SELECT * FROM t2
LIMIT 8;
SELECT * FROM t2
LIMIT 8 OFFSET 1;
SELECT * FROM t2
LIMIT 8;
SELECT * FROM t2
LIMIT 8 OFFSET 1;
SELECT * FROM t2
ORDER BY a LIMIT 8;
SELECT * FROM t2
ORDER BY a LIMIT 8 OFFSET 1;
SELECT * FROM t2
ORDER BY a LIMIT 8;
SELECT * FROM t2
ORDER BY a LIMIT 8 OFFSET 1;
SELECT * FROM t2
LIMIT 8;
SELECT * FROM t2
LIMIT 8 OFFSET 1;
SELECT * FROM t2
LIMIT 8;
SELECT * FROM t2
LIMIT 8 OFFSET 1;
SELECT * FROM t2
ORDER BY a LIMIT 8;
SELECT * FROM t2
ORDER BY a LIMIT 8 OFFSET 1;
SELECT * FROM t2
ORDER BY a LIMIT 8;
SELECT * FROM t2
ORDER BY a LIMIT 8 OFFSET 1;

DROP TABLE t1, t2;

--
-- Test of update and delete with limit
--

create table t1 (a int not null default 0 primary key, b int not null default 0);
insert into t1 () values ();
insert into t1 values (1,1),(2,1),(3,1);
update t1 set a=4 where b=1 limit 1;
select * from t1;
update t1 set b=2 where b=1 limit 2;
select * from t1;
update t1 set b=4 where b=1;
select * from t1;
delete from t1 where b=2 limit 1;
select * from t1;
delete from t1 limit 1;
select * from t1;
drop table t1;

create table t1 (i int);
insert into t1 (i) values(1),(1),(1);
delete from t1 limit 1;
update t1 set i=2 limit 1;
delete from t1 limit 0;
update t1 set i=3 limit 0;
select * from t1;
drop table t1;

-- LIMIT 0

select 0 limit 0;

--
-- Test with DELETE, ORDER BY and limit (bug #1024)
--

CREATE TABLE t1(id int auto_increment primary key, id2 int, index(id2));
INSERT INTO t1 (id2) values (0),(0),(0);
DELETE FROM t1 WHERE id=1;
INSERT INTO t1 SET id2=0;
SELECT * FROM t1;
DELETE FROM t1 WHERE id2 = 0 ORDER BY id LIMIT 1;
SELECT * FROM t1;
DELETE FROM t1 WHERE id2 = 0 ORDER BY id desc LIMIT 1;
SELECT * FROM t1;
DROP TABLE t1;

--
-- Bug#8023 - limit on UNION with from DUAL, causes syntax error
--
create table t1 (a integer);
insert into t1 values (1);
select 1 as a from t1 union all select 1 from dual limit 1;
drop table t1;

--
-- Bug #21787: COUNT(*) + ORDER BY + LIMIT returns wrong result
--
create table t1 (a int);
insert into t1 values (1),(2),(3),(4),(5),(6),(7);
select count(*) c FROM t1 WHERE a > 0 ORDER BY c LIMIT 3;
select sum(a) c FROM t1 WHERE a > 0 ORDER BY c LIMIT 3;
drop table t1;

--
-- Bug #28464: a string argument to 'limit ?' PS
--

prepare s from "select 1 limit ?";
set @a='qwe';
set @a=-1;
set @a=14632475938453979136;
set @a=-14632475938453979136;

--
-- Bug#37075: offset of limit clause might be truncated to 0 on 32-bits server w/o big tables
--

select 1 as a limit 4294967296,10;

CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);
SELECT COUNT(*) FROM t1 LIMIT 1 OFFSET 3;
DROP TABLE t1;

CREATE TABLE t1 (pk INTEGER PRIMARY KEY);
INSERT INTO t1 VALUES (1);
SELECT t1.pk FROM (SELECT DISTINCT * FROM t1) AS t1 WHERE t1.pk=1 LIMIT 1 OFFSET 2;
DROP TABLE t1;

--
-- Set up an error that occurs during OFFSET processing, and force the table
-- to be closed so that we verify that it's not stuck in performance schema
-- batch mode.
--
set @old_opt_switch=@@optimizer_switch;
set optimizer_switch='block_nested_loop=off';
CREATE TABLE t1 ( pk INTEGER );
INSERT INTO t1 VALUES (1), (2);
SELECT JSON_OBJECTAGG(NULL, '') FROM t1, t1 AS t2 GROUP BY t1.pk LIMIT 2 OFFSET 5;
DROP TABLE t1;
set optimizer_switch=@old_opt_switch;

CREATE TABLE t1 (
  col_int_key INT DEFAULT NULL,
  col_varchar_key VARCHAR(1) DEFAULT NULL,
  KEY idx_CC_col_int_key (col_int_key),
  KEY idx_CC_col_varchar_key (col_varchar_key)
);

INSERT INTO t1 VALUES(1,'A');

SELECT col_varchar_key AS f1
  FROM t1
  WHERE (col_int_key NOT BETWEEN 10 AND 15 OR col_varchar_key < '2') AND col_int_key IS NULL
  GROUP BY f1 LIMIT 100;
SELECT col_varchar_key AS f1
  FROM t1
  WHERE (col_int_key NOT BETWEEN 10 AND 15 OR col_varchar_key < '2') AND col_int_key IS NULL
  GROUP BY f1 LIMIT 100;

DROP TABLE t1;

CREATE TEMPORARY TABLE t1 (i INT);
INSERT INTO t1 VALUES (1), (2), (3), (4), (5);

SELECT * FROM (SELECT * FROM t1 ORDER BY i DESC LIMIT 3) AS alias LIMIT 2;

DROP TABLE t1;

-- Tables are created as myISAM tables as row counts will be reported
-- as 'excact' by myISAM handler. Table B is intentionally left empty to cause
-- 'rows_fetched = 0' to be reported from the handler. This results in
-- the 'fanout' of A join B to be calculated as 0, which triggered the bug:
--
-- The fanout was used to calculate a modified 'select_limit' for number
-- of rows to be read from the first table. This involved a division-by-zero
-- with fanout, such that 'modified select_limit' became 'infinite'.
-- Storing that (with type cast) into a ha_rows data type is undefined behavior.
-- Thus 'zero' ended up being stored (or possibly just left unassigned)

CREATE TABLE a (
  col_int int,
  col_varchar_255 varchar(255),
  pk integer auto_increment  primary key
) ENGINE=myisam;

CREATE TABLE b (
  col_varchar_10 varchar(10),
  pk integer primary key
) ENGINE=myisam;

let $query=
SELECT STRAIGHT_JOIN a.pk
FROM a
  JOIN b ON a.col_varchar_255 = b.col_varchar_10
WHERE b.pk <= a.col_int
ORDER BY a.pk LIMIT 10;

INSERT INTO a(col_int,col_varchar_255) VALUES (0,""),(1,"");

INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;
INSERT INTO a(col_int,col_varchar_255) SELECT col_int,col_varchar_255 FROM a;

DROP TABLE a;
DROP TABLE b;

CREATE TABLE t1(id INTEGER);
INSERT INTO t1 (id) VALUES (1), (2), (3);
SET @@sql_select_limit=1;
SET @a = 0;
set @@sql_select_limit=2;
set @@sql_select_limit=DEFAULT;
DROP TABLE t1;

CREATE TABLE t1(id INTEGER, c1 INTEGER, c2 INTEGER, c3 INTEGER);
INSERT INTO t1 VALUES(1,1,1,1),(2,2,2,2),(3,9,9,9),(4,10,10,10),(6,1,2,888);
SET @@sql_select_limit=2;
SET @@sql_select_limit=DEFAULT;
DROP TABLE t1;
