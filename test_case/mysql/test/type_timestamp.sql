
--
-- Test timestamp
--

--disable_warnings
drop table if exists t1,t2;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
set time_zone="+03:00";

CREATE TABLE t1 (a int, t timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
CREATE TABLE t2 (a int, t datetime);
SET TIMESTAMP=1234;
 insert into t1 values(1,NULL);
insert into t1 values(2,"2002-03-03");
SET TIMESTAMP=1235;
 insert into t1 values(3,NULL);
SET TIMESTAMP=1236;
insert into t1 (a) values(4);
insert into t2 values(5,"2002-03-04"),(6,NULL),(7,"2002-03-05"),(8,"00-00-00");
SET TIMESTAMP=1237;
insert into t1 select * from t2;
SET TIMESTAMP=1238;
insert into t1 (a) select a+1 from t2 where a=8;
select * from t1;
drop table t1,t2;

SET TIMESTAMP=1234;
CREATE TABLE t1 (value TEXT NOT NULL, id VARCHAR(32) NOT NULL, stamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY (id));
INSERT INTO t1 VALUES ("my value", "myKey","1999-04-02 00:00:00");
SELECT stamp FROM t1 WHERE id="myKey";
UPDATE t1 SET value="my value" WHERE id="myKey";
SELECT stamp FROM t1 WHERE id="myKey";
UPDATE t1 SET id="myKey" WHERE value="my value";
SELECT stamp FROM t1 WHERE id="myKey";
drop table t1;

create table t1 (a timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1 values (now());
select date_format(a,"%Y %y"),year(a),year(now()) from t1;
drop table t1;

create table t1 (ix timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1 values (19991101000000),(19990102030405),(19990630232922),(19990601000000),(19990930232922),(19990531232922),(19990501000000),(19991101000000),(19990501000000);
select ix+0 from t1;
insert into t1 values ("19991101000000"),("19990102030405"),("19990630232922"),("19990601000000");
select ix+0 from t1;
drop table t1;

CREATE TABLE t1 (date date, date_time datetime, time_stamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
INSERT INTO t1 VALUES ("1998-12-31","1998-12-31 23:59:59",19981231235959);
INSERT INTO t1 VALUES ("1999-01-01","1999-01-01 00:00:00",19990101000000);
INSERT INTO t1 VALUES ("1999-09-09","1999-09-09 23:59:59",19990909235959);
INSERT INTO t1 VALUES ("2000-01-01","2000-01-01 00:00:00",20000101000000);
INSERT INTO t1 VALUES ("2000-02-28","2000-02-28 00:00:00",20000228000000);
INSERT INTO t1 VALUES ("2000-02-29","2000-02-29 00:00:00",20000229000000);
INSERT INTO t1 VALUES ("2000-03-01","2000-03-01 00:00:00",20000301000000);
INSERT INTO t1 VALUES ("2000-12-31","2000-12-31 23:59:59",20001231235959);
INSERT INTO t1 VALUES ("2001-01-01","2001-01-01 00:00:00",20010101000000);
INSERT INTO t1 VALUES ("2004-12-31","2004-12-31 23:59:59",20041231235959);
INSERT INTO t1 VALUES ("2005-01-01","2005-01-01 00:00:00",20050101000000);
INSERT INTO t1 VALUES ("2030-01-01","2030-01-01 00:00:00",20300101000000);
SELECT * FROM t1;
drop table t1;

--
-- Let us check if we properly treat wrong datetimes and produce proper warnings
-- (for both strings and numbers)
--
create table t1 (ix timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1 values (0),(20030101010160),(20030101016001),(20030101240101),(20030132010101),(20031301010101),(20031200000000),(20030000000000);
select ix+0 from t1;
insert into t1 values ("00000000000000"),("20030101010160"),("20030101016001"),("20030101240101"),("20030132010101"),("20031301010101"),("20031200000000"),("20030000000000");
select ix+0 from t1;
insert into t1 values ("0000-00-00 00:00:00 some trailer"),("2003-01-01 00:00:00 some trailer");
select ix+0 from t1;
drop table t1;

-- Let us test TIMESTAMP auto-update behaviour

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
-- Also we will test behaviour of TIMESTAMP field in SHOW CREATE TABLE and
-- behaviour of DEFAULT literal for such fields
create table t1 (t1 timestamp not null default '2003-01-01 00:00:00', t2 datetime, t3 timestamp NOT NULL DEFAULT '0000-00-00 00:00:00');
SET TIMESTAMP=1000000000;
insert into t1 values ();
SET TIMESTAMP=1000000001;
update t1 set t2=now();
SET TIMESTAMP=1000000002;
insert into t1 (t1,t3) values (default, default);
select * from t1;
drop table t1;

create table t1 (t1 timestamp not null default now(), t2 datetime, t3 timestamp NOT NULL DEFAULT '0000-00-00 00:00:00');
SET TIMESTAMP=1000000002;
insert into t1 values ();
SET TIMESTAMP=1000000003;
update t1 set t2=now();
SET TIMESTAMP=1000000003;
insert into t1 (t1,t3) values (default, default);
select * from t1;
drop table t1;

create table t1 (t1 timestamp not null default '2003-01-01 00:00:00' on update now(), t2 datetime);
SET TIMESTAMP=1000000004;
insert into t1 values ();
select * from t1;
SET TIMESTAMP=1000000005;
update t1 set t2=now();
SET TIMESTAMP=1000000005;
insert into t1 (t1) values (default);
select * from t1;
drop table t1;

create table t1 (t1 timestamp not null default now() on update now(), t2 datetime);
SET TIMESTAMP=1000000006;
insert into t1 values ();
select * from t1;
SET TIMESTAMP=1000000007;
update t1 set t2=now();
SET TIMESTAMP=1000000007;
insert into t1 (t1) values (default);
select * from t1;
drop table t1;

create table t1 (t1 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, t2 datetime, t3 timestamp NOT NULL DEFAULT '0000-00-00 00:00:00');
SET TIMESTAMP=1000000007;
insert into t1 values ();
select * from t1;
SET TIMESTAMP=1000000008;
update t1 set t2=now();
SET TIMESTAMP=1000000008;
insert into t1 (t1,t3) values (default, default);
select * from t1;
drop table t1;

-- Let us test if CURRENT_TIMESTAMP also works well as default value
-- (Of course NOW and CURRENT_TIMESTAMP are same for parser but still just
-- for demonstartion.)
create table t1 (t1 timestamp not null default current_timestamp on update current_timestamp, t2 datetime);
SET TIMESTAMP=1000000009;
insert into t1 values ();
select * from t1;
SET TIMESTAMP=1000000010;
update t1 set t2=now();
SET TIMESTAMP=1000000011;
insert into t1 (t1) values (default);
select * from t1;

-- 
-- Let us test some cases when auto-set should be disabled or influence
-- on server behavior in some other way.
--

-- Update statement that explicitly sets field should not auto-set it. 
insert into t1 values ('2004-04-01 00:00:00', '2004-04-01 00:00:00');
SET TIMESTAMP=1000000012;
update t1 set t1= '2004-04-02 00:00:00';
select * from t1;
update t1 as ta, t1 as tb set tb.t1= '2004-04-03 00:00:00';
select * from t1;
drop table t1;

-- Now let us test replace it should behave exactly like delete+insert
-- Case where optimization is possible DEFAULT = ON UPDATE
create table t1 (pk int primary key, t1 timestamp not null default current_timestamp on update current_timestamp, bulk int);
insert into t1 values (1, '2004-04-01 00:00:00', 10);
SET TIMESTAMP=1000000013;
select * from t1;
drop table t1;
create table t1 (pk int primary key, t1 timestamp not null default '2003-01-01 00:00:00' on update current_timestamp, bulk int);
insert into t1 values (1, '2004-04-01 00:00:00', 10);
SET TIMESTAMP=1000000014;
select * from t1;
drop table t1;
create table t1 (pk int primary key, t1 timestamp not null default current_timestamp on update current_timestamp, bulk int);
insert into t1 values (1, '2004-04-01 00:00:00', 10);
SET TIMESTAMP=1000000015;
select * from t1;
drop table t1;

-- Let us test alter now
create table t1 (t1 timestamp not null default current_timestamp on update current_timestamp);
insert into t1 values ('2004-04-01 00:00:00');
SET TIMESTAMP=1000000016;
alter table t1 add i int default 10;
select * from t1;
drop table t1;

--
-- Test for TIMESTAMP columns which are able to store NULLs
--

-- Unlike for default TIMESTAMP fields we do not interpret first field
-- in this table as TIMESTAMP with DEFAULT NOW() ON UPDATE NOW() properties.
create table t1 (a timestamp null, b timestamp null);
insert into t1 values (NULL, NULL);
SET TIMESTAMP=1000000017;
insert into t1 values ();
select * from t1;
drop table t1;

-- But explicit auto-set properties still should be OK.
create table t1 (a timestamp null default current_timestamp on update current_timestamp, b timestamp null);
insert into t1 values (NULL, NULL);
SET TIMESTAMP=1000000018;
insert into t1 values ();
select * from t1;
drop table t1;

-- It is also OK to specify NULL as default explicitly for such fields.
-- This is also a test for bug #2464, DEFAULT keyword in INSERT statement
-- should return default value for column.

create table t1 (a timestamp null default null, b timestamp null default '2003-01-01 00:00:00');
insert into t1 values (NULL, NULL);
insert into t1 values (DEFAULT, DEFAULT);
select * from t1;
drop table t1;

--
-- Let us test behavior of ALTER TABLE when it converts columns 
-- containing NULL to TIMESTAMP columns.
--
create table t1 (a bigint, b bigint);
insert into t1 values (NULL, NULL), (20030101000000, 20030102000000);
set timestamp=1000000019;
alter table t1 modify a timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, modify b timestamp NOT NULL DEFAULT '0000-00-00 00:00:0';
select * from t1;
drop table t1;

--
-- Test for bug #4131, TIMESTAMP columns missing minutes and seconds when
-- using GROUP BY in @@new=1 mode.
--
create table t1 (a char(2), t timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1 values ('a', '2004-01-01 00:00:00'), ('a', '2004-01-01 01:00:00'),
                      ('b', '2004-02-01 00:00:00');
select max(t) from t1 group by a;
drop table t1;

--
-- Bug#7806 - insert on duplicate key and auto-update of timestamp
--
create table t1 (a int auto_increment primary key, b int, c timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1 (a, b, c) values (1, 0, '2001-01-01 01:01:01'),
  (2, 0, '2002-02-02 02:02:02'), (3, 0, '2003-03-03 03:03:03');
select * from t1;
update t1 set b = 2, c = c where a = 2;
select * from t1;
insert into t1 (a) values (4);
select * from t1;
update t1 set c = '2004-04-04 04:04:04' where a = 4;
select * from t1;
insert into t1 (a) values (3), (5) on duplicate key update b = 3, c = c;
select * from t1;
insert into t1 (a, c) values (4, '2004-04-04 00:00:00'),
  (6, '2006-06-06 06:06:06') on duplicate key update b = 4;
select * from t1;
drop table t1;

-- Restore timezone to default
set time_zone= @@global.time_zone;

CREATE TABLE t1 (a TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, KEY (a));

INSERT INTO t1 VALUES ('2000-01-01 00:00:00'), ('2000-01-01 00:00:00'),
                      ('2000-01-01 00:00:01'), ('2000-01-01 00:00:01');

SELECT a FROM t1 WHERE a >=  20000101000000;
SELECT a FROM t1 WHERE a >= '20000101000000';

DROP TABLE t1;
CREATE TABLE t1 ( a TIMESTAMP, KEY ( a ) );

INSERT INTO t1 VALUES( '2010-02-01 09:31:01' );
INSERT INTO t1 VALUES( '2010-02-01 09:31:02' );
INSERT INTO t1 VALUES( '2010-02-01 09:31:03' );
INSERT INTO t1 VALUES( '2010-02-01 09:31:04' );

SELECT * FROM t1 WHERE a >= '2010-02-01 09:31:02.0';
SELECT * FROM t1 WHERE '2010-02-01 09:31:02.0' <= a;
SELECT * FROM t1 WHERE a <= '2010-02-01 09:31:02.0';
SELECT * FROM t1 WHERE '2010-02-01 09:31:02.0' >= a;
SELECT * FROM t1 WHERE a >= '2010-02-01 09:31:02.0';

CREATE TABLE t2 ( a TIMESTAMP, KEY ( a ) );

INSERT INTO t2 VALUES( '2010-02-01 09:31:01' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:02' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:03' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:04' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:05' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:06' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:07' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:08' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:09' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:10' );
INSERT INTO t2 VALUES( '2010-02-01 09:31:11' );
SELECT * FROM t2 WHERE a < '2010-02-01 09:31:02.0';

DROP TABLE t1, t2;

SET TIMESTAMP=0;
CREATE TABLE t1(a timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
INSERT INTO t1 VALUES ('2008-02-23 09:23:45'), ('2010-03-05 11:08:02');
SELECT MAX(a) FROM t1;
SELECT a FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (dt DATETIME, ts TIMESTAMP);
INSERT INTO t1 VALUES('2011-01-06 12:34:30', '2011-01-06 12:34:30');
SELECT MAX(dt), MAX(ts) FROM t1;
SELECT MAX(ts) < '2010-01-01 00:00:00' FROM t1;
SELECT MAX(dt) < '2010-01-01 00:00:00' FROM t1;
SELECT MAX(ts) > '2010-01-01 00:00:00' FROM t1;
SELECT MAX(dt) > '2010-01-01 00:00:00' FROM t1;
SELECT MAX(ts) = '2011-01-06 12:34:30' FROM t1;
SELECT MAX(dt) = '2011-01-06 12:34:30' FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  `c1` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c2` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00'
);
INSERT INTO t1 VALUES ('2003-05-16 23:53:29','2000-01-27 23:13:41');
SELECT c2-c1 FROM t1;
SELECT * FROM t1;
SELECT TIMESTAMP'2000-01-27 23:13:41' - TIMESTAMP'2003-05-16 23:53:29';
SELECT TIMESTAMP('2000-01-27','23:13:41') - TIMESTAMP('2003-05-16','23:53:29');
DROP TABLE t1;
SET sql_mode = default;
DROP TABLE IF EXISTS t1, t2, t3;
SET @org_mode=@@sql_mode;
SET @@sql_mode='NO_ZERO_DATE,STRICT_ALL_TABLES';
CREATE TABLE t1 (c1 TIMESTAMP DEFAULT 0);
CREATE TABLE t1 (c1 TIMESTAMP DEFAULT '0000-00-00 00:00:00');
CREATE TABLE t1 (c1 TIMESTAMP DEFAULT '2012-02-00 12:12:12');
SET @@sql_mode='NO_ZERO_DATE';
CREATE TABLE t1 (c1 TIMESTAMP DEFAULT 0);
CREATE TABLE t2 (c1 TIMESTAMP DEFAULT '0000-00-00 00:00:00');
SET @@sql_mode='NO_ZERO_IN_DATE';
CREATE TABLE t3 (c1 TIMESTAMP DEFAULT '2012-02-00 12:12:12');
DROP TABLE t1, t2, t3;
SET @@sql_mode='';
CREATE TABLE t1 (c1 TIMESTAMP DEFAULT 0);
CREATE TABLE t2 (c1 TIMESTAMP DEFAULT '0000-00-00 00:00:00');
CREATE TABLE t3 (c1 TIMESTAMP DEFAULT '2012-02-00 12:12:12');
DROP TABLE t1, t2, t3;

CREATE TABLE t1 (c1 INT);
SET @@sql_mode='NO_ZERO_DATE,STRICT_ALL_TABLES';
ALTER TABLE t1 ADD c2 TIMESTAMP DEFAULT 0;
ALTER TABLE t1 ADD c2 TIMESTAMP DEFAULT '0000-00-00';
SET @@sql_mode='NO_ZERO_IN_DATE,STRICT_ALL_TABLES';
ALTER TABLE t1 ADD c2 TIMESTAMP DEFAULT '2012-02-00';
SET @@sql_mode='';
ALTER TABLE t1 ADD c2 TIMESTAMP DEFAULT 0;
ALTER TABLE t1 ADD c3 TIMESTAMP DEFAULT '0000-00-00';
ALTER TABLE t1 ADD c4 TIMESTAMP DEFAULT '2012-02-00';
DROP TABLE t1;

SET @@sql_mode= @org_mode;

SET SESSION SQL_MODE='';

CREATE TABLE t1 (
  c1 smallint DEFAULT NULL,
  c2 timestamp NOT NULL
);
INSERT INTO t1 VALUES (2,'2006-07-01 22:00:00'),(6,'0000-00-00 00:00:00');

SELECT
CONCAT_WS('out', c1, (CASE 42 WHEN c1 THEN c1 ELSE c2 END), c2, 'hello')
FROM t1;

DROP TABLE t1;

SET SESSION SQL_MODE=DEFAULT;
