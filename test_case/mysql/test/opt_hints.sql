
CREATE TABLE t1(f1 INT, f2 INT);
INSERT INTO t1 VALUES
(1,1),(2,2),(3,3);

CREATE TABLE t2(f1 INT NOT NULL, f2 INT NOT NULL, f3 CHAR(200), KEY(f1, f2));
INSERT INTO t2 VALUES
(1,1, 'qwerty'),(1,2, 'qwerty'),(1,3, 'qwerty'),
(2,1, 'qwerty'),(2,2, 'qwerty'),(2,3, 'qwerty'), (2,4, 'qwerty'),(2,5, 'qwerty'),
(3,1, 'qwerty'),(3,4, 'qwerty'),
(4,1, 'qwerty'),(4,2, 'qwerty'),(4,3, 'qwerty'), (4,4, 'qwerty'),
(1,1, 'qwerty'),(1,2, 'qwerty'),(1,3, 'qwerty'),
(2,1, 'qwerty'),(2,2, 'qwerty'),(2,3, 'qwerty'), (2,4, 'qwerty'),(2,5, 'qwerty'),
(3,1, 'qwerty'),(3,4, 'qwerty'),
(4,1, 'qwerty'),(4,2, 'qwerty'),(4,3, 'qwerty'), (4,4, 'qwerty');

CREATE TABLE t3 (f1 INT NOT NULL, f2 INT, f3 VARCHAR(32),
                 PRIMARY KEY(f1), KEY f2_idx(f1), KEY f3_idx(f3));
INSERT INTO t3 VALUES
(1, 1, 'qwerty'), (2, 1, 'ytrewq'),
(3, 2, 'uiop'), (4, 2, 'poiu'), (5, 2, 'lkjh'),
(6, 2, 'uiop'), (7, 2, 'poiu'), (8, 2, 'lkjh'),
(9, 2, 'uiop'), (10, 2, 'poiu'), (11, 2, 'lkjh'),
(12, 2, 'uiop'), (13, 2, 'poiu'), (14, 2, 'lkjh');
INSERT INTO t3 SELECT f1 + 20, f2, f3 FROM t3;
INSERT INTO t3 SELECT f1 + 40, f2, f3 FROM t3;
set optimizer_switch=default;
SELECT f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
SELECT /*+ NO_RANGE_OPTIMIZATION(t3) */ f1 FROM t3 WHERE f1 > 30 AND f1 < 33;
set optimizer_switch='index_condition_pushdown=on';
    WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
    WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
    WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
    WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
    WHERE TD.f1 > 27 AND TD.f3 = 'poiu';
set optimizer_switch=default;
set optimizer_switch='batched_key_access=off,mrr_cost_based=off';
SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2
WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;
SELECT /*+ BKA() */ t2.f1, t2.f2, t2.f3 FROM t1,t2
WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1;

set optimizer_switch='batched_key_access=off,mrr_cost_based=on';

set optimizer_switch='batched_key_access=on,mrr_cost_based=off';

set optimizer_switch='mrr=off';
set optimizer_switch='mrr=on';
set optimizer_switch='batched_key_access=off,mrr_cost_based=off,semijoin=off,materialization=off';
SET f3 = 'mnbv' WHERE f1 > 30 AND f1 < 33 AND (t3.f1, t3.f2, t3.f3) IN
  (SELECT t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND
    t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
SET f3 = 'mnbv' WHERE f1 > 30 AND f1 < 33 AND (t3.f1, t3.f2, t3.f3) IN
  (SELECT /*+ BKA(t2) NO_BNL(t1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND
    t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
    t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
    t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1);
SELECT /*+ QB_NAME(qb2) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND
  t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1;
SELECT /*+ QB_NAME(qb1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND
  t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1;
SELECT /*+ BKA(t2) NO_BNL(t1) BKA(t3) NO_RANGE_OPTIMIZATION(t3 idx1) NO_RANGE_OPTIMIZATION(t3) */
t2.f1, t2.f2, t2.f3 FROM t1,t2 WHERE t1.f1=t2.f1 AND
t2.f2 BETWEEN t1.f1 AND t1.f2 AND t2.f2 + 1 >= t1.f1 + 1;
    WHERE TD.f1 > 2 AND TD.f3 = 'poiu';
SELECT /*+ BKA(@qb1 t2) */ * FROM (SELECT /*+ QB_NAME(QB1) */ t2.f1, t2.f2, t2.f3 FROM t1,t2
WHERE t1.f1=t2.f1 AND t2.f2 BETWEEN t1.f1 and t1.f2 and t2.f2 + 1 >= t1.f1 + 1) AS s1;

DROP TABLE t1, t2, t3;

set optimizer_switch=default;
set optimizer_switch='block_nested_loop=on';

CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1),(2,2);
CREATE TABLE t2 (a INT, b INT);
INSERT INTO t2 VALUES (1,1),(2,2);
CREATE TABLE t3 (a INT, b INT);
INSERT INTO t3 VALUES (1,1),(2,2);
SELECT t1.* FROM t1,t2,t3;
SELECT /*+ NO_BNL() */t1.* FROM t1,t2,t3;

set optimizer_switch='block_nested_loop=off';

DROP TABLE t1, t2, t3;
set optimizer_switch = DEFAULT;
CREATE TABLE t1 (a INT, b INT, PRIMARY KEY (a));
CREATE TABLE t2 (a INT, INDEX a (a));
CREATE TABLE t3 (a INT, b INT, INDEX a (a,b));
INSERT INTO t1 VALUES (1,10), (2,20), (3,30),  (4,40);
INSERT INTO t2 VALUES (2), (3), (4), (5);
INSERT INTO t3 VALUES (10,3), (20,4), (30,5);

SET optimizer_prune_level = 0;

SET optimizer_prune_level = DEFAULT;

DROP TABLE t1, t2, t3;
set optimizer_switch=default;

CREATE TABLE t1
(
  f1 int NOT NULL DEFAULT '0',
  f2 int NOT NULL DEFAULT '0',
  f3 int NOT NULL DEFAULT '0',
  INDEX idx1(f2, f3), INDEX idx2(f3)
);

INSERT INTO t1(f1) VALUES (1), (2), (3), (4), (5), (6), (7), (8);
INSERT INTO t1(f2, f3) VALUES (3,4), (3,4);

set optimizer_switch='mrr=on,mrr_cost_based=off';
SELECT * FROM t1 WHERE f2 <= 3 AND 3 <= f3;
SELECT /*+ NO_MRR(t1) */ * FROM t1 WHERE f2 <= 3 AND 3 <= f3;

set optimizer_switch='mrr=off,mrr_cost_based=off';

set optimizer_switch='mrr=off,mrr_cost_based=on';

DROP TABLE t1;

CREATE TABLE t(a INT);
INSERT INTO t VALUES (1);

-- Test turning off BNL
SET optimizer_switch='block_nested_loop=on';

SELECT /*+ NO_BNL(t4) */ 1 FROM t t1 LEFT JOIN t t2 ON 1 LEFT JOIN (t t3 LEFT JOIN t t4 ON 1) ON 1;
SELECT /*+ NO_BNL(t3) */ 1 FROM t t1 LEFT JOIN (t t2 LEFT JOIN t t3 ON 1 LEFT JOIN t t4 ON 1) ON 1 WHERE 1;

-- Test turning on BNL
SET optimizer_switch='block_nested_loop=off';

DROP TABLE t;

-- Test turning on BKA
CREATE TABLE t(a INT, b INT, KEY k(a));
INSERT INTO t VALUES (1,1);

-- Queries with a mix of BKA and BNL
-- Turn both on with optimizer_switch
SET optimizer_switch='block_nested_loop=on,batched_key_access=on,mrr_cost_based=off';

-- Turn BKA is off, BNL is still on
SET optimizer_switch='batched_key_access=off';

-- Let both BKA and BNL be off
SET optimizer_switch='block_nested_loop=off';

DROP TABLE t;

set optimizer_switch=default;

CREATE TABLE t1 (i INT PRIMARY KEY);

SELECT /*+ BKA() BKA() */ 1;
SELECT /*+ BKA(t1) BKA(t1) */ * FROM t1;
SELECT /*+ QB_NAME(q1) BKA(t1@q1) BKA(t1@q1) */ * FROM t1;
SELECT /*+ QB_NAME(q1) NO_ICP(@q1 t1 PRIMARY) NO_ICP(@q1 t1 PRIMARY) */ * FROM t1;

DROP TABLE t1;

CREATE TABLE t1(a INT, KEY(a));
INSERT INTO t1(a) SELECT /*+ NO_RANGE_OPTIMIZATION(t1 a)*/ 1 FROM t1;
DROP TABLE t1;


CREATE TABLE t1 (i INT, j INT);
CREATE INDEX i1 ON t1(i);
CREATE INDEX i2 ON t1(j);
SELECT /*+*/ 1;
SELECT /*+ */ 1;
SELECT /*+ * ** / // /* */ 1;
SELECT /*+ @ */ 1;
SELECT /*+ @foo */ 1;
SELECT /*+ foo@bar */ 1;
SELECT /*+ foo @bar */ 1;
SELECT /*+ `@` */ 1;
SELECT /*+ `@foo` */ 1;
SELECT /*+ `foo@bar` */ 1;
SELECT /*+ `foo @bar` */ 1;
SELECT /*+ BKA( @) */ 1;
SELECT /*+ BKA( @) */ 1;
SELECT /*+ BKA(t1 @) */ 1;
SELECT /*+ BKA(`test*/`) */ 1;

--
-- disabled test because of mysqltest bug #19785832
-- see test_wl8016() at mysql_client_test.c for the workaround
--
----echo # should just warn:
--SELECT /*+ BKA(`test*/ 1;
SELECT  /*+ NO_ICP() */ 1;
SELECT  /*+NO_ICP()*/ 1;
SELECT  /*+ NO_ICP () */ 1;
SELECT  /*+ NO_ICP (  ) */ 1;

SELECT  /*+ NO_ICP() */ 1 UNION SELECT 1;

UPDATE  /*+ NO_ICP() */ t1 SET i = 10;
INSERT  /*+ NO_ICP() */ INTO t1 VALUES ();
DELETE  /*+ NO_ICP() */ FROM t1 WHERE 1;

SELECT /*+ BKA(t1) */    1 FROM t1;
SELECT /*+ BKA(a b) */   1 FROM t1 a, t1 b;

SELECT /*+ NO_ICP(i1) */ 1 FROM t1;
SELECT /*+ NO_ICP(i1 i2) */ 1 FROM t1;
SELECT /*+ NO_ICP(@qb ident) */ 1 FROM t1;

CREATE INDEX 3rd_index ON t1(i, j);
SELECT /*+ NO_ICP(3rd_index) */ 1 FROM t1;

CREATE INDEX `$index` ON t1(j, i);
SELECT /*+ NO_ICP($index) */ 1 FROM t1;

CREATE TABLE ` quoted name тест` (i INT);
SELECT /*+ BKA(` quoted name тест`) */ 1 FROM t1;
SELECT /*+ BKA(` quoted name тест`@`select--1`) */ 1 FROM t1;
DROP TABLE ` quoted name тест`;

SET SQL_MODE = 'ANSI_QUOTES';

CREATE TABLE " quoted name тест" (i INT);
SELECT /*+ BKA(" quoted name тест") */ 1 FROM t1;
SELECT /*+ BKA(" quoted name тест"@"select--1") */ 1 FROM t1;

CREATE TABLE `test1``test2``` (i INT);

SELECT /*+ BKA(`test1``test2```) */ 1;
SELECT /*+ BKA("test1""test2""") */ 1;

SET SQL_MODE = '';
SELECT /*+ BKA(" quoted name тест") */ 1 FROM t1;

DROP TABLE ` quoted name тест`;
DROP TABLE `test1``test2```;
b`) */ 1;

SET NAMES utf8mb3;

CREATE TABLE tableТ (i INT);
SELECT /*+ BKA(tableТ) */ 1 FROM t1;
SELECT /*+ BKA(test@tableТ) */ 1 FROM t1;
DROP TABLE tableТ;

CREATE TABLE таблица (i INT);

SELECT /*+ BKA(`таблица`) */ 1 FROM t1;
SELECT /*+ BKA(таблица) */ 1 FROM t1;
SELECT /*+ BKA(test@таблица) */ 1 FROM t1;
SELECT /*+ NO_ICP(`�`) */ 1 FROM t1;

DROP TABLE таблица;

SET NAMES DEFAULT;

SELECT * FROM (SELECT /*+ DEBUG_HINT3 */ 1) a;
SELECT (SELECT /*+ DEBUG_HINT3 */ 1);
SELECT 1 FROM DUAL WHERE 1 IN (SELECT /*+ DEBUG_HINT3 */ 1);
SELECT /*+ 10 */ 1;
SELECT /*+ NO_ICP() */ 1;
SELECT /*+ NO_ICP(10) */ 1;
SELECT /*+ NO_ICP( */ 1;
SELECT /*+ NO_ICP) */ 1;
SELECT /*+ NO_ICP(t1 */ 1;
SELECT /*+ NO_ICP(t1 ( */ 1;

INSERT INTO t1 VALUES (1, 1), (2, 2);

SELECT 1 FROM /*+ regular commentary, not a hint! */ t1;
SELECT 1 FROM /*+ --1 */ t1 WHERE /*+ #2 */ 1 /*+ #3 */;

SELECT /*+ NO_ICP() */ 1
  FROM /*+ regular commentary, not a hint! */ t1;

SELECT /*+ NO_ICP(t1) bad_hint */ 1 FROM t1;

SELECT /*+
  NO_ICP(@qb ident)
*/ 1 FROM t1;

SELECT /*+
  ? bad syntax
*/ 1;

SELECT
/*+ ? bad syntax */ 1;

DROP TABLE t1;

CREATE TABLE t1 (i INT);
DROP TABLE t1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE cur1 CURSOR FOR  SELECT /*+ NO_MRR(q w)*/1;
DROP PROCEDURE p1;

create table t1(a int);

create view v1 as (select * from t1);
drop view v1;
create algorithm=merge view v1 as (select * from t1);
drop view v1;

create algorithm=temptable view v1 as (select * from t1);
drop view v1;

set optimizer_switch="derived_merge=off";

create view v1 as (select * from t1);
drop view v1;

set optimizer_switch=default;

create table t2(a int, b int);
create table t3 like t2;
      (select * from t3) as dt3;
 select * from t1
 where (1,a,2) =  (
                   select @n:=@n+1, t2.a, sum(t2.b)
                   from (select @n:=1) as dt, t2
                   group by t2.a
                  )
) as dt2
;
 select * from t1
 where (1,a,2) =  (
                   select @n:=@n+1, t2.a, sum(t2.b)
                   from (select @n:=1) as dt, t2
                   group by t2.a
                  )
) as dt2
;

let $query_end=
view v1 as select (select t1.a from t1 where t1.a=t2.a) from t2;
drop view v1;
drop view v1;

select /*+ no_mrr(dt idx1) */ * from (select 1 from t1 limit 1) dt;
select /*+ no_mrr(dt idx1) */ * from (select 1 from t1) dt;

insert into t1 values(1),(2);
create view v1 as
 select  * from t1 where a <> 0;

let $query_part=t3, v1 set t3.a=v1.a+10 where t3.a-v1.a=0;

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

let $query_part=t3, v1 set v1.a=t3.a+10 where t3.a-v1.a=0;

delete from t3;
insert into t3 values(1,1),(2,2);

delete from t1;
insert into t1 values(1),(2);
select * from t1;

delete from t1;
insert into t1 values(1),(2);
select * from t1;

let $query_part=t3, (select * from t1) dt set t3.a=dt.a+10 where t3.a-dt.a=0;

delete from t1;
insert into t1 values(1),(2);

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

delete from t1;
insert into t1 values(1),(2);

let $query_part=
t3 set b=NULL
where a in (select /*+ qb_name(sub) */ a
            from (select * from t1 where a>1) dt);

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

let $query_part=
t3 set b=NULL
where a in (select /*+ qb_name(sub) */ a
            from (select * from t3 where b>1) dt);

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

let $query_part=t3.* from t3, v1 where t3.a-v1.a=0;

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

delete from t3;
insert into t3 values(1,1),(2,2);
select * from t3;

drop view v1;

drop table t1,t2,t3;
CREATE TABLE t (id int AUTO_INCREMENT, cid int NOT NULL, price float NOT NULL,
  PRIMARY KEY (id), KEY key1 (price, cid));

INSERT INTO t(cid, price) values(1, 10), (2, 100), (3, 55), (4, 20), (5, 30),
    (6, 27), (7, 217), (8, 927), (9, 207);

SET SESSION OPTIMIZER_TRACE="enabled=on";
    ORDER BY price, cid LIMIT 3;
SELECT price, cid FROM t WHERE (price >= 10) ORDER BY price, cid LIMIT 3;
SELECT REGEXP_SUBSTR(trace, 'index_dive[^,]*',1,1,'n') FROM
    INFORMATION_SCHEMA.OPTIMIZER_TRACE;
    ORDER BY price, cid LIMIT 3;
SELECT price, cid FROM t FORCE INDEX (key1) WHERE (price >= 10)
    ORDER BY price, cid LIMIT 3;
SELECT REGEXP_SUBSTR(trace, 'index_dive[^,]*',1,1,'n') FROM
    INFORMATION_SCHEMA.OPTIMIZER_TRACE;
    ORDER BY price DESC, cid DESC LIMIT 3;
SELECT price, cid FROM t FORCE INDEX (key1) WHERE (price >= 200)
    ORDER BY price DESC, cid DESC LIMIT 3;
SELECT REGEXP_SUBSTR(trace, 'index_dive[^,]*',1,1,'n') FROM
    INFORMATION_SCHEMA.OPTIMIZER_TRACE;
SELECT price, cid FROM t FORCE INDEX(key1) WHERE price >= 20 ORDER BY cid;
SELECT REGEXP_SUBSTR(trace, 'index_dive[^,]*',1,1,'n') FROM
    INFORMATION_SCHEMA.OPTIMIZER_TRACE;

SET SESSION OPTIMIZER_TRACE="enabled=off";
DROP TABLE t;
