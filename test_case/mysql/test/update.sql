
--
-- test of updating of keys
--

--disable_warnings
drop table if exists t1,t2;

create table t1 (a int auto_increment , primary key (a));
insert into t1 values (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL);
update t1 set a=a+10 where a > 34;
update t1 set a=a+100 where a > 0;
update t1 set a=a+100 limit 0;

-- Some strange updates to test some otherwise unused code
update t1 set a=a+100 where a=1 and a=2;
update t1 set a=b+100 where a=1 and a=2;
update t1 set a=b+100 where c=1 and a=2;
update t1 set d=a+100 where a=1;
select * from t1;
drop table t1;

CREATE TABLE t1
 (
 place_id int (10) unsigned NOT NULL,
 shows int(10) unsigned DEFAULT '0' NOT NULL,
 ishows int(10) unsigned DEFAULT '0' NOT NULL,
 ushows int(10) unsigned DEFAULT '0' NOT NULL,
 clicks int(10) unsigned DEFAULT '0' NOT NULL,
 iclicks int(10) unsigned DEFAULT '0' NOT NULL,
 uclicks int(10) unsigned DEFAULT '0' NOT NULL,
 ts timestamp,
 PRIMARY KEY (place_id,ts)
 );

INSERT INTO t1 (place_id,shows,ishows,ushows,clicks,iclicks,uclicks,ts)
VALUES (1,0,0,0,0,0,0,20000928174434);
UPDATE t1 SET shows=shows+1,ishows=ishows+1,ushows=ushows+1,clicks=clicks+1,iclicks=iclicks+1,uclicks=uclicks+1 WHERE place_id=1 AND ts>="2000-09-28 00:00:00";
select place_id,shows from t1;
drop table t1;

--
-- Test of ORDER BY
--

create table t1 (a int not null, b int not null, key (a));
insert into t1 values (1,1),(1,2),(1,3),(3,1),(3,2),(3,3),(3,1),(3,2),(3,3),(2,1),(2,2),(2,3);
SET @tmp=0;
update t1 set b=(@tmp:=@tmp+1) order by a;
update t1 set b=99 where a=1 order by b asc limit 1;
select * from t1 order by a,b;
update t1 set b=100 where a=1 order by b desc limit 2;
update t1 set a=a+10+b where a=1 order by b;
select * from t1 order by a,b;
create table t2 (a int not null, b int not null);
insert into t2 values (1,1),(1,2),(1,3);
update t1 set b=(select distinct 1 from (select * from t2) a);
drop table t1,t2;

--
-- Multi table update test from bugs
--

create table t1 (F1 VARCHAR(30), F2 VARCHAR(30), F3 VARCHAR(30), cnt int, groupid int, KEY groupid_index (groupid));

insert into t1 (F1,F2,F3,cnt,groupid) values ('0','0','0',1,6),
('0','1','2',1,5), ('0','2','0',1,3), ('1','0','1',1,2),
('1','2','1',1,1), ('1','2','2',1,1), ('2','0','1',2,4),
('2','2','0',1,7);
delete from m1 using t1 m1,t1 m2 where m1.groupid=m2.groupid and (m1.cnt < m2.cnt or m1.cnt=m2.cnt and m1.F3>m2.F3);
select * from t1;
drop table t1;

--
-- Bug#5553 - Multi table UPDATE IGNORE fails on duplicate keys 
--

CREATE TABLE t1 ( 
   `colA` int(10) unsigned NOT NULL auto_increment,
   `colB` int(11) NOT NULL default '0',
   PRIMARY KEY  (`colA`)
);
INSERT INTO t1 VALUES (4433,5424);
CREATE TABLE t2 (
  `colC` int(10) unsigned NOT NULL default '0',
  `colA` int(10) unsigned NOT NULL default '0',
  `colD` int(10) unsigned NOT NULL default '0',
  `colE` int(10) unsigned NOT NULL default '0',
  `colF` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`colC`,`colA`,`colD`,`colE`)
);
INSERT INTO t2 VALUES (3,4433,10005,495,500);
INSERT INTO t2 VALUES (3,4433,10005,496,500);
INSERT INTO t2 VALUES (3,4433,10009,494,500);
INSERT INTO t2 VALUES (3,4433,10011,494,500);
INSERT INTO t2 VALUES (3,4433,10005,497,500);
INSERT INTO t2 VALUES (3,4433,10013,489,500);
INSERT INTO t2 VALUES (3,4433,10005,494,500);
INSERT INTO t2 VALUES (3,4433,10005,493,500);
INSERT INTO t2 VALUES (3,4433,10005,492,500);
UPDATE IGNORE t2,t1 set t2.colE = t2.colE + 1,colF=0 WHERE t1.colA = t2.colA AND (t1.colB & 4096) > 0 AND (colE + 1) < colF;
SELECT * FROM t2;
DROP TABLE t1;
DROP TABLE t2;

--
-- Bug #6054 
--
create table t1 (c1 int, c2 char(6), c3 int);
create table t2 (c1 int, c2 char(6));
insert into t1 values (1, "t1c2-1", 10), (2, "t1c2-2", 20);
update t1 left join t2 on t1.c1 = t2.c1 set t2.c2 = "t2c2-1";
update t1 left join t2 on t1.c1 = t2.c1 set t2.c2 = "t2c2-1" where t1.c3 = 10;
drop table t1, t2;

--
-- Bug #8057
--
create table t1 (id int not null auto_increment primary key, id_str varchar(32));
insert into t1 (id_str) values ("test");
update t1 set id_str = concat(id_str, id) where id = last_insert_id();
select * from t1;
drop table t1;

--
-- Bug #8942: a problem with update and partial key part
--

create table t1 (a int, b char(255), key(a, b(20)));
insert into t1 values (0, '1');
update t1 set b = b + 1 where a = 0;
select * from t1;
drop table t1;

--
-- Bug #11868 Update with subquery with ref built with a key from the updated
--            table crashes server
--
create table t1(f1 int, f2 int);
create table t2(f3 int, f4 int);
create index idx on t2(f3);
insert into t1 values(1,0),(2,0);
insert into t2 values(1,1),(2,2);
UPDATE t1 SET t1.f2=(SELECT MAX(t2.f4) FROM t2 WHERE t2.f3=t1.f1);
select * from t1;
drop table t1,t2;

--
-- Bug #13180 sometimes server accepts sum func in update/delete where condition
--
create table t1(f1 int);
select DATABASE();
update t1 set f1=1 where count(*)=1;
select DATABASE();
delete from t1 where count(*)=1;
drop table t1;

-- BUG#12915: Optimize "DELETE|UPDATE ... ORDER BY ... LIMIT n" to use an index
create table t1 ( a int, b int default 0, index (a) );
insert into t1 (a) values (0),(0),(0),(0),(0),(0),(0),(0);
select a from t1 order by a limit 1;
update t1 set a=9999 order by a limit 1;
update t1 set b=9999 order by a limit 1;
delete from t1 order by a, b desc limit 1;
delete from t1 order by a desc, b desc limit 1;

alter table t1 disable keys;
delete from t1 order by a limit 1;

select * from t1;
update t1 set a=a+10,b=1 order by a limit 3;
update t1 set a=a+11,b=2 order by a limit 3;
update t1 set a=a+12,b=3 order by a limit 3;
select * from t1 order by a;

drop table t1;

--
-- Bug#15028 Multitable update returns different numbers of matched rows
--           depending on table order
create table t1 (f1 int);
create table t2 (f2 int);
insert into t1 values(1),(2);
insert into t2 values(1),(1);
update t1,t2 set f1=3,f2=3 where f1=f2 and f1=1;
update t2 set f2=1;
update t1 set f1=1 where f1=3;
update t2,t1 set f1=3,f2=3 where f1=f2 and f1=1;
drop table t1,t2;


-- BUG#15935
create table t1 (a int);
insert into t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
create table t2 (a int, filler1 char(200), filler2 char(200), key(a));
insert into t2 select A.a + 10*B.a, 'filler','filler' from t1 A, t1 B;
update t2 set a=3 where a=2;
drop table t1, t2;

--
-- Bug #16510 Updating field named like '*name' caused server crash
--
create table t1(f1 int, `*f2` int);
insert into t1 values (1,1);
update t1 set `*f2`=1;
drop table t1;

--
-- Bug#25126: Wrongly resolved field leads to a crash
--
create table t1(f1 int);
update t1 set f2=1 order by f2;
drop table t1;

--
-- Bug #24035: performance degradation with condition int_field=big_decimal
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (
  request_id int unsigned NOT NULL auto_increment,
  user_id varchar(12) default NULL,
  time_stamp datetime NOT NULL default '0000-00-00 00:00:00',
  ip_address varchar(15) default NULL,
  PRIMARY KEY (request_id),
  KEY user_id_2 (user_id,time_stamp)
);

INSERT INTO t1 (user_id) VALUES ('user1');
INSERT INTO t1(user_id) SELECT user_id FROM t1;
INSERT INTO t1(user_id) SELECT user_id FROM t1;
INSERT INTO t1(user_id) SELECT user_id FROM t1;
INSERT INTO t1(user_id) SELECT user_id FROM t1;
INSERT INTO t1(user_id) SELECT user_id FROM t1;
INSERT INTO t1(user_id) SELECT user_id FROM t1;
INSERT INTO t1(user_id) SELECT user_id FROM t1;
INSERT INTO t1(user_id) SELECT user_id FROM t1;
SELECT user_id FROM t1 WHERE request_id=9999999999999;
SELECT user_id FROM t1 WHERE request_id=999999999999999999999999999999;
UPDATE t1 SET user_id=null WHERE request_id=9999999999999;
UPDATE t1 SET user_id=null WHERE request_id=999999999999999999999999999999;

DROP TABLE t1;
SET sql_mode = default;
CREATE TABLE t1 (

  a INT(11),
  quux decimal( 31, 30 ),

  UNIQUE KEY bar (a),
  KEY quux (quux)
);

INSERT INTO
 t1 ( a, quux )
VALUES
    ( 1,    1 ),
    ( 2,  0.1 );

INSERT INTO t1( a )
  SELECT @newA := 1 + a FROM t1 WHERE quux <= 0.1;

SELECT * FROM t1;

DROP TABLE t1;

--
-- Bug #22364: Inconsistent "matched rows" when executing UPDATE
--

connect (con1,localhost,root,,test);

set tmp_table_size=1024;

-- Create the test tables
create table t1 (id int, a int, key idx(a));
create table t2 (id int unsigned not null auto_increment primary key, a int);
insert into t2(a) values(1),(2),(3),(4),(5),(6),(7),(8);
insert into t2(a) select a from t2;
insert into t2(a) select a from t2;
insert into t2(a) select a from t2;
update t2 set a=id;
insert into t1 select * from t2;

-- Check that the number of matched rows is correct when the temporary
-- table is small enough to not be converted to MyISAM
select count(*) from t1 join t2 on (t1.a=t2.a);
update t1 join t2 on (t1.a=t2.a) set t1.id=t2.id;

-- Increase table sizes
insert into t2(a) select a from t2;
update t2 set a=id;
insert into t1 select * from t2;

-- Check that the number of matched rows is correct when the temporary
-- table has to be converted to MyISAM
select count(*) from t1 join t2 on (t1.a=t2.a);
update t1 join t2 on (t1.a=t2.a) set t1.id=t2.id;

-- Check that the number of matched rows is correct when there are duplicate
-- key errors
update t1 set a=1;
update t2 set a=1;
select count(*) from t1 join t2 on (t1.a=t2.a);
update t1 join t2 on (t1.a=t2.a) set t1.id=t2.id;

drop table t1,t2;

--
-- Bug #40745: Error during WHERE clause calculation in UPDATE
--             leads to an assertion failure
--
--disable_warnings
DROP TABLE IF EXISTS t1;
DROP FUNCTION IF EXISTS f1;

CREATE FUNCTION f1() RETURNS INT RETURN f1();
CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);
UPDATE t1 SET i = 3 WHERE f1();
UPDATE t1 SET i = f1();

DROP TABLE t1;
DROP FUNCTION f1;

CREATE TABLE t1 (f1 INTEGER AUTO_INCREMENT, PRIMARY KEY (f1));
CREATE TEMPORARY TABLE t2 LIKE t1;
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1);

ALTER TABLE t2 COMMENT = 'ABC';
UPDATE t2, t1 SET t2.f1 = 2, t1.f1 = 9;
ALTER TABLE t2 COMMENT = 'DEF';

DROP TABLE t1, t2;
CREATE TABLE t1 ( a INT, KEY( a ) );
INSERT INTO t1 VALUES (0), (1);
CREATE VIEW v1 AS SELECT t11.a, t12.a AS b FROM t1 t11, t1 t12;
SET SESSION sql_safe_updates = 1;
UPDATE IGNORE v1 SET a = 1;

SET SESSION sql_safe_updates = DEFAULT;
DROP TABLE t1;
DROP VIEW v1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP TABLE IF EXISTS t1, not_exists;
DROP FUNCTION IF EXISTS f1;
DROP VIEW IF EXISTS v1;

CREATE TABLE t1 (PRIMARY KEY(pk)) AS SELECT 1 AS pk;
CREATE FUNCTION f1() RETURNS INTEGER RETURN (SELECT 1 FROM not_exists);
CREATE VIEW v1 AS SELECT pk FROM t1 WHERE f1() = 13;
UPDATE v1 SET pk = 7 WHERE pk > 0;

DROP VIEW v1;
DROP FUNCTION f1;
DROP TABLE t1;
SET sql_mode = default;

CREATE TABLE t1 (i INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (10),(11),(12),(13),(14),(15),(16),(17),(18),(19),
                      (20),(21),(22),(23),(24),(25),(26),(27),(28),(29),
                      (30),(31),(32),(33),(34),(35);
CREATE TABLE t2 (a CHAR(2), b CHAR(2), c CHAR(2), d CHAR(2),
                 INDEX idx (a,b(1),c)) ENGINE=INNODB;
INSERT INTO t2 SELECT i, i, i, i FROM t1;
UPDATE t2 SET d = 10 WHERE b = 10 LIMIT 5;
SET @binlog_handler_update= IF(@@global.log_bin AND @@global.binlog_format != 'STATEMENT', 1, 0);
UPDATE t2 SET d = 10 WHERE b = 10 ORDER BY a, c LIMIT 5;

ALTER TABLE t2 DROP INDEX idx, ADD INDEX idx2 (a, b);
UPDATE t2 SET c = 10 LIMIT 5;
UPDATE t2 SET c = 10 ORDER BY a, b DESC LIMIT 5;
DROP TABLE t1, t2;

CREATE TABLE t1(
 a int,
 c int,
 e int,
 f int,
 g blob,
 h int,
 i int,
 j blob,
 unique key (g(221),c),
 unique key (c,a,j(148)),
 key (i)
) engine=innodb;

UPDATE (SELECT 1 AS a FROM t1 NATURAL JOIN t1 AS t2) AS x, t1
SET t1.e= x.a;

DROP TABLE t1;

CREATE TABLE t1 (a VARCHAR(50), b TEXT, c CHAR(50)) ENGINE=INNODB;

INSERT INTO t1 (a, b, c) VALUES ('start trail', '', 'even longer string');
UPDATE t1 SET b = a, a = 'inject';
SELECT a, b FROM t1;
UPDATE t1 SET b = c, c = 'inject';
SELECT c, b FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (
a INTEGER,
b INTEGER,
c INTEGER,
d INTEGER,
KEY key1 (a,b,c)
);

INSERT INTO t1 (a,b,c,d) VALUES (1, 1, 1, 4), (2, 2, 2, 5), (2, 3, 4, 7),
(3, 3, 3, 9), (4, 4, 4, 0), (5, 5, 5, 1), (5, 6, 7, 3), (5, 7, 9, 9);

-- Updating part of index, should still use the index for the order by (no
-- filesort)
analyze table t1;
let $query=UPDATE t1 SET c = 72 WHERE a = 2 ORDER BY b ASC LIMIT 1;
SELECT * FROM t1;

-- Updating field not included in index, should use index for order by (no file
-- sort) 
let $query=UPDATE t1 SET d = 72 WHERE a = 2 ORDER BY b ASC LIMIT 1;
SELECT * FROM t1;

-- Checking if we are updating three different rows when limit is increased.
-- Updating field included in index, should use index for order by (no file
--sort).
INSERT INTO t1 (a,b,c,d) VALUES (5, 5, 1, 1), (5, 5, 2, 1), (5, 5, 4, 1);
let $query=UPDATE t1 SET c = 3 WHERE a = 5 ORDER BY b ASC LIMIT 3;
SELECT * FROM t1;

-- Must use file sort since the index can not be used for order by as range on
-- "a" is not constant
analyze table t1;
let $query=UPDATE t1 SET c = 62 WHERE a > 4 ORDER BY b ASC LIMIT 3;
SELECT * FROM t1;

-- To make the cost model for order by limit to pick index for ordering, we need
-- to insert some more data
INSERT INTO t1 (a,b,c,d) VALUES (1, 1, 1, 4), (2, 2, 2, 5), (2, 3, 4, 7),
(3, 3, 3, 9), (4, 4, 4, 0), (5, 5, 5, 1), (5, 6, 7, 3), (5, 7, 9, 9);

-- Updating part of index, should still use the index for the order by (no file
-- sort)
let $query=UPDATE t1 SET c = 82 ORDER BY a ASC LIMIT 1;
SELECT * FROM t1;

-- Must use file sort since the index can not be used for order by
let $query=UPDATE t1 SET a = 82 ORDER BY b ASC LIMIT 1;
SELECT * FROM t1;

-- Must use file sort since the index can not be used for order by
let $query=UPDATE t1 SET b = 82 ORDER BY d ASC LIMIT 1;
SELECT * FROM t1;

-- Checking if we are updating two different rows when limit is increased.  Cost
-- model will choose index for ordering for increased limit only when some more
-- dats is inserted
INSERT INTO t1 (a,b,c,d) VALUES (1, 1, 1, 4), (2, 2, 2, 5), (2, 3, 4, 7),
(3, 3, 3, 9), (4, 4, 4, 0), (5, 5, 5, 1), (5, 6, 7, 3), (5, 7, 9, 9);
INSERT INTO t1 (a,b,c,d) VALUES (1, 1, 1, 4), (2, 2, 2, 5), (2, 3, 4, 7),
(3, 3, 3, 9), (4, 4, 4, 0), (5, 5, 5, 1), (5, 6, 7, 3), (5, 7, 9, 9);

-- Updating part of index, should still use the index for the order by (no file
-- sort)
let $query=UPDATE t1 SET c = 82 ORDER BY a ASC LIMIT 2;
SELECT * FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (a INT PRIMARY KEY, b DATE);
UPDATE t1 SET b= NULL WHERE a < '00:38:47.008761';
DROP TABLE t1;

CREATE TABLE t1(
id INTEGER NOT NULL AUTO_INCREMENT,
token VARCHAR(255) DEFAULT NULL,
PRIMARY KEY (id),
KEY token (token)
)DEFAULT CHARSET=utf8mb3;

INSERT INTO t1 VALUES (1, "abc"), (2, "def");

SET sql_mode='';
UPDATE t1 SET token = X'ad';
SELECT * FROM t1;

let query=UPDATE t1 SET token = NULL WHERE token = X'ad';

SET sql_mode=default;
SELECT * FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (a INTEGER);
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
INSERT INTO t1 VALUES (0);

-- Cause the UPDATE to fail halfway, verifying that we're resetting
-- allow_semi_consistent() even in error paths.
--skip_if_hypergraph  -- Doesn't fail. ORDER BY is optimized away.
--error ER_TRUNCATED_WRONG_VALUE
UPDATE t1 SET a=1 ORDER BY CAST('invalid' AS DATETIME);

-- If the transaction is still marked as allowing semi-consistent reads
-- when in SERIALIZABLE, this will crash when trying to unlock the
-- (non-matching) record.
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
DELETE FROM t1 WHERE a=2;

DROP TABLE t1;
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

CREATE TABLE t1 (f1 INT PRIMARY KEY, f2 INT CHECK (f2 < 400));
CREATE TABLE t2 (f1 INT PRIMARY KEY, f2 INT);
CREATE VIEW v2 AS SELECT * FROM t2 WHERE f2 < 400 WITH CHECK OPTION;
INSERT INTO t1 VALUES (1, 10), (2, 20);
INSERT INTO t2 VALUES (1, 10), (2, 20);
UPDATE IGNORE t1 SET f2 = 400;

-- 2 (was 0) matched, 0 changed
UPDATE IGNORE v2 SET f2 = 400;

-- 2 (was 0) matched, 0 changed
UPDATE IGNORE v2 STRAIGHT_JOIN (SELECT 1) AS t0 SET f2 = 400;

-- 2 matched, 0 changed
UPDATE IGNORE (SELECT 1) AS t0 STRAIGHT_JOIN v2 SET f2 = 400;

-- 2 matched, 2 changed
UPDATE IGNORE t2 SET f2 = 400;

DROP VIEW v2;
DROP TABLE t2, t1;

CREATE TABLE t1(a INTEGER, b INTEGER AS (a));
CREATE TABLE t2(a INTEGER);
UPDATE t1 JOIN t2 USING(a) SET t2.a=t2.a+1 WHERE t1.b>0;
DROP TABLE t1, t2;

CREATE TABLE t1(a1 INTEGER PRIMARY KEY, b1 INTEGER);
CREATE TABLE t2(a2 INTEGER PRIMARY KEY, b2 INTEGER);

CREATE VIEW vmat2 AS SELECT DISTINCT * FROM t2;

CREATE VIEW vtr AS
SELECT * FROM t1 JOIN vmat2 AS dt2 ON t1.a1=dt2.a2;

UPDATE vtr SET b1=b1+1 WHERE a1=1;
UPDATE vtr SET b2=b2+1 WHERE a2=1;

DROP VIEW vtr, vmat2;
DROP TABLE t1, t2;

CREATE TABLE g(c INTEGER, b INTEGER);
CREATE TABLE t(a INTEGER);
UPDATE t SET a=1 WHERE EXISTS(SELECT b FROM g WHERE 1 NOT LIKE c FOR UPDATE);
DROP TABLE g, t;

CREATE TABLE t1(i int primary key, c1 tinytext, c2 text);

INSERT INTO t1 VALUES (-1, 'twofiftyfive', '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234');
INSERT INTO t1 VALUES(0,'zero',
'0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345');
INSERT INTO t1 VALUES (1, 'one', '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456');
INSERT INTO t1 VALUES (2, 'two', '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567');
UPDATE t1 SET c1 = c2 WHERE i = -1;
UPDATE t1 SET c1 = c2 WHERE i = 0;
UPDATE IGNORE t1 SET c1 = c2 WHERE i = 1;
SET SESSION sql_mode = '';
UPDATE t1 SET c1 = c2 WHERE i = 2;
SET SESSION sql_mode = DEFAULT;
SELECT * FROM t1;
DROP TABlE t1;
