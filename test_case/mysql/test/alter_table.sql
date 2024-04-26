
--
-- Test of alter table
--

SET sql_mode = 'NO_ENGINE_SUBSTITUTION';

SET SESSION information_schema_stats_expiry=0;

create table t1 (
col1 int not null auto_increment primary key,
col2 varchar(30) not null,
col3 varchar (20) not null,
col4 varchar(4) not null,
col5 enum('PENDING', 'ACTIVE', 'DISABLED') not null,
col6 int not null, to_be_deleted int);
insert into t1 values (2,4,3,5,"PENDING",1,7);
alter table t1
add column col4_5 varchar(20) not null after col4,
add column col7 varchar(30) not null after col5,
add column col8 datetime not null, drop column to_be_deleted,
change column col2 fourth varchar(30) not null after col3,
modify column col6 int not null first;
select * from t1;
drop table t1;

create table t1 (bandID MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY, payoutID SMALLINT UNSIGNED NOT NULL) engine=myisam;
insert into t1 (bandID,payoutID) VALUES (1,6),(2,6),(3,4),(4,9),(5,10),(6,1),(7,12),(8,12);
alter table t1 add column new_col int, order by payoutid,bandid;
select * from t1;
alter table t1 order by bandid,payoutid;
select * from t1;
drop table t1;

-- ORDER BY does not make sence for InnoDB tables,because InnoDB always orders table rows based on the clustered index
create table t1 (bandID MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY, payoutID SMALLINT UNSIGNED NOT NULL) engine=InnoDB;
insert into t1 (bandID,payoutID) VALUES (1,6),(2,6),(3,4),(4,9),(5,10),(6,1),(7,12),(8,12);
alter table t1 add column new_col int, order by payoutid,bandid;
select * from t1;
alter table t1 order by bandid,payoutid;
select * from t1;
drop table t1;

-- Check that pack_keys and dynamic length rows are not forced.

CREATE TABLE t1 (
GROUP_ID int(10) unsigned DEFAULT '0' NOT NULL,
LANG_ID smallint(5) unsigned DEFAULT '0' NOT NULL,
NAME varchar(80) DEFAULT '' NOT NULL,
PRIMARY KEY (GROUP_ID,LANG_ID),
KEY NAME (NAME));
ALTER TABLE t1 CHANGE NAME NAME CHAR(80) not null;
DROP TABLE t1;

--
-- Test of ALTER TABLE ... ORDER BY
--

create table t1 (n int);
insert into t1 values(9),(3),(12),(10);
alter table t1 order by n;
select * from t1;
drop table t1;

CREATE TABLE t1 (
  id int(11) unsigned NOT NULL default '0',
  category_id tinyint(4) unsigned NOT NULL default '0',
  type_id tinyint(4) unsigned NOT NULL default '0',
  body text NOT NULL,
  user_id int(11) unsigned NOT NULL default '0',
  status enum('new','old') NOT NULL default 'new',
  PRIMARY KEY (id)
) ENGINE=MyISAM;

ALTER TABLE t1 ORDER BY t1.id, t1.status, t1.type_id, t1.user_id, t1.body;
DROP TABLE t1;

--
-- The following combination found a hang-bug in MyISAM
--

CREATE TABLE t1 (AnamneseId int(10) unsigned NOT NULL auto_increment,B BLOB,PRIMARY KEY (AnamneseId)) engine=myisam;
insert into t1 values (null,"hello");
ALTER TABLE t1 ADD Column new_col int not null;
DROP TABLE t1;

--
-- Drop and add an auto_increment column
--

create table t1 (i int unsigned not null auto_increment primary key);
insert into t1 values (null),(null),(null),(null);
alter table t1 drop i,add i int unsigned not null auto_increment, drop primary key, add primary key (i);
select * from t1;
drop table t1;

--
-- Bug #2628: 'alter table t1 rename mysqltest.t1' silently drops mysqltest.t1
-- if it exists
--
create table t1 (name char(15));
insert into t1 (name) values ("current");
create database mysqltest;
create table mysqltest.t1 (name char(15));
insert into mysqltest.t1 (name) values ("mysqltest");
select * from t1;
select * from mysqltest.t1;
alter table t1 rename mysqltest.t1;
select * from t1;
select * from mysqltest.t1;
drop table t1;
drop database mysqltest;

-- Disable/Enable keys supported by Myisam only
-- ALTER TABLE ... ENABLE/DISABLE KEYS

create table t1 (n1 int not null, n2 int, n3 int, n4 float,
                unique(n1),
                key (n1, n2, n3, n4),
                key (n2, n3, n4, n1),
                key (n3, n4, n1, n2),
                key (n4, n1, n2, n3) ) engine=Myisam;
alter table t1 disable keys;
let $1=10;
 dec $1;
alter table t1 enable keys;
drop table t1;

--
-- Alter table and rename
--

create table t1 (i int unsigned not null auto_increment primary key);
alter table t1 rename t2;
alter table t2 rename t1, add c char(10) comment "no comment";
drop table t1;

-- implicit analyze

create table t1 (a int, b int);
let $1=100;
 dec $1;
alter table t1 add unique (a,b), add key (b);
drop table t1;

--
-- Test ALTER TABLE ENABLE/DISABLE keys when things are locked
--

CREATE TABLE t1 (
  Host varchar(16) binary NOT NULL default '',
  User varchar(16) binary NOT NULL default '',
  PRIMARY KEY  (Host,User)
) ENGINE=MyISAM;

ALTER TABLE t1 DISABLE KEYS;
INSERT INTO t1 VALUES ('localhost','root'),('localhost',''),('games','monty');
ALTER TABLE t1 ENABLE KEYS;
DROP TABLE t1;

--
-- Test with two keys
--

CREATE TABLE t1 (
  Host varchar(16) binary NOT NULL default '',
  User varchar(16) binary NOT NULL default '',
  PRIMARY KEY  (Host,User),
  KEY  (Host)
) ENGINE=MyISAM;

ALTER TABLE t1 DISABLE KEYS;
INSERT INTO t1 VALUES ('localhost','root'),('localhost','');
ALTER TABLE t1 ENABLE KEYS;

-- Test RENAME with LOCK TABLES
LOCK TABLES t1 WRITE;
ALTER TABLE t1 RENAME t2;
select * from t2;
DROP TABLE t2;

--
-- Test disable keys with locking
--
CREATE TABLE t1 (
  Host varchar(16) binary NOT NULL default '',
  User varchar(16) binary NOT NULL default '',
  PRIMARY KEY  (Host,User),
  KEY  (Host)
) ENGINE=MyISAM;
ALTER TABLE t1 DISABLE KEYS;
DROP TABLE t1;

--
-- BUG#4717 - check for valid table names
--
create table t1 (a int);
alter table t1 rename to ``;
drop table t1;

--
-- BUG#6236 - ALTER TABLE MODIFY should set implicit NOT NULL on PK columns
--
drop table if exists t1, t2;
create table t1 ( a varchar(10) not null primary key ) engine=myisam;
create table t2 ( a varchar(10) not null primary key ) engine=merge union=(t1);
alter table t1 modify a varchar(10);
alter table t1 modify a varchar(10) not null;
drop table if exists t1, t2;

-- The following is also part of bug #6236 (CREATE TABLE didn't properly count
-- not null columns for primary keys)

create table t1 (a int, b int, c int, d int, e int, f int, g int, h int,i int, primary key (a,b,c,d,e,f,g,i,h)) engine=MyISAM;
insert into t1 (a) values(1);
alter table t1 modify a int;
drop table t1;
create table t1 (a int not null, b int not null, c int not null, d int not null, e int not null, f int not null, g int not null, h int not null,i int not null, primary key (a,b,c,d,e,f,g,i,h)) engine=MyISAM;
insert into t1 (a) values(1);
drop table t1;

--
-- Test that data get converted when character set is changed
-- Test that data doesn't get converted when src or dst is BINARY/BLOB
--
create table t1 (a char(10) character set koi8r);
insert into t1 values ('тест');
select a,hex(a) from t1;
alter table t1 change a a char(10) character set cp1251;
select a,hex(a) from t1;
alter table t1 change a a binary(4);
select hex(a) from t1;
alter table t1 change a a char(10) character set cp1251;
select a,hex(a) from t1;
alter table t1 change a a char(10) character set koi8r;
select a,hex(a) from t1;
alter table t1 change a a varchar(10) character set cp1251;
select a,hex(a) from t1;
alter table t1 change a a char(10) character set koi8r;
select a,hex(a) from t1;
alter table t1 change a a text character set cp1251;
select a,hex(a) from t1;
alter table t1 change a a char(10) character set koi8r;
select a,hex(a) from t1;
delete from t1;

--
-- Test ALTER TABLE .. CHARACTER SET ..
--
show create table t1;
alter table t1 DEFAULT CHARACTER SET latin1;
alter table t1 CONVERT TO CHARACTER SET latin1;
alter table t1 DEFAULT CHARACTER SET cp1251;

drop table t1;

--
-- Bug#2821
-- Test that table CHARACTER SET does not affect blobs
--
create table t1 (myblob longblob,mytext longtext)
default charset latin1 collate latin1_general_cs;
alter table t1 character set latin2;
drop table t1;

--
-- Bug 2361 (Don't drop UNIQUE with DROP PRIMARY KEY)
--

CREATE TABLE t1 (a int PRIMARY KEY, b INT UNIQUE);
ALTER TABLE t1 DROP PRIMARY KEY;
ALTER TABLE t1 DROP PRIMARY KEY;
DROP TABLE t1;

-- BUG#3899
create table t1 (a int, b int, key(a));
insert into t1 values (1,1), (2,2);
alter table t1 drop key no_such_key;
alter table t1 drop key a;
drop table t1;

--
-- BUG 12207 alter table ... discard table space on MyISAM table causes ERROR 2013 (HY000)
--
-- Some platforms (Mac OS X, Windows) will send the error message using small letters.
CREATE TABLE T12207(a int) ENGINE=MYISAM;
ALTER TABLE T12207 DISCARD TABLESPACE;
DROP TABLE T12207;

--
-- Bug #6479  ALTER TABLE ... changing charset fails for TEXT columns
--
-- The column's character set was changed but the actual data was not
-- modified. In other words, the values were reinterpreted
-- as utf8mb3 instead of being converted.
create table t1 (a text) character set koi8r;
insert into t1 values ('тест');
select hex(a) from t1;
alter table t1 convert to character set cp1251;
select hex(a) from t1;
drop table t1;

--
-- Test for bug #7884 "Able to add invalid unique index on TIMESTAMP prefix"
-- MySQL should not think that packed field with non-zero decimals is
-- geometry field and allow to create prefix index which is
-- shorter than packed field length.
--
create table t1 ( a timestamp );
alter table t1 add unique ( a(1) );
drop table t1;

--
-- Disable/Enable keys supported by Myisam only
-- Bug #24395: ALTER TABLE DISABLE KEYS doesn't work when modifying the table
--
-- This problem happens if the data change is compatible.
-- Changing to the same type is compatible for example.
--
create table t1 (a int, key(a)) engine=myisam;
alter table t1 modify a int, disable keys;

alter table t1 enable keys;

alter table t1 modify a bigint, disable keys;

alter table t1 enable keys;

alter table t1 add b char(10), disable keys;

alter table t1 add c decimal(10,2), enable keys;
alter table t1 disable keys;

alter table t1 add d decimal(15,5);

drop table t1;
create table t1(a int, b char(10), unique(a)) engine=myisam;
alter table t1 disable keys;
alter table t1 enable keys;
alter table t1 modify a int, disable keys;
alter table t1 modify a bigint, disable keys;

alter table t1 modify a bigint;

alter table t1 modify a int;

drop table t1;
create table t1(a int, b char(10), unique(a), key(b)) engine=myisam;
alter table t1 disable keys;
alter table t1 enable keys;
alter table t1 modify a int, disable keys;
alter table t1 enable keys;
alter table t1 modify a bigint, disable keys;
alter table t1 modify a int;
alter table t1 modify a int;

drop table t1;


--
-- Bug#11493 - Alter table rename to default database does not work without
--             db name qualifying
--
create database mysqltest;
create table t1 (c1 int);
alter table t1 rename mysqltest.t1;
drop table t1;
alter table mysqltest.t1 rename t1;
drop table t1;
create table t1 (c1 int);
use mysqltest;
drop database mysqltest;
alter table test.t1 rename t1;
alter table test.t1 rename test.t1;
use test;
drop table t1;

--
-- ROW_FORMAT=FIXED supported by Myisam only
-- BUG#23404 - ROW_FORMAT=FIXED option is lost is an index is added to the
-- table
--
CREATE TABLE t1(a INT) ENGINE=MyISAM ROW_FORMAT=FIXED;
CREATE INDEX i1 ON t1(a);
DROP INDEX i1 ON t1;
DROP TABLE t1;

--
-- Disable/Enable keys supported by Myisam only
-- Bug#24219 - ALTER TABLE ... RENAME TO ... , DISABLE KEYS leads to crash
--

CREATE TABLE bug24219 (a INT, INDEX(a)) ENGINE=MyISAM;

ALTER TABLE bug24219 RENAME TO bug24219_2, DISABLE KEYS;

DROP TABLE bug24219_2;

--
-- Bug#24562 (ALTER TABLE ... ORDER BY ... with complex expression asserts)
--

create table table_24562(
  section int,
  subsection int,
  title varchar(50));

insert into table_24562 values
(1, 0, "Introduction"),
(1, 1, "Authors"),
(1, 2, "Acknowledgements"),
(2, 0, "Basics"),
(2, 1, "Syntax"),
(2, 2, "Client"),
(2, 3, "Server"),
(3, 0, "Intermediate"),
(3, 1, "Complex queries"),
(3, 2, "Stored Procedures"),
(3, 3, "Stored Functions"),
(4, 0, "Advanced"),
(4, 1, "Replication"),
(4, 2, "Load balancing"),
(4, 3, "High availability"),
(5, 0, "Conclusion");

select * from table_24562;

alter table table_24562 add column reviewer varchar(20),
order by title;

select * from table_24562;

update table_24562 set reviewer="Me" where section=2;
update table_24562 set reviewer="You" where section=3;

alter table table_24562
order by section ASC, subsection DESC;

select * from table_24562;

alter table table_24562
order by table_24562.subsection ASC, table_24562.section DESC;

select * from table_24562;
alter table table_24562 order by 12;
alter table table_24562 order by (section + 12);
alter table table_24562 order by length(title);
alter table table_24562 order by (select 12 from dual);
alter table table_24562 order by no_such_col;

drop table table_24562;

-- End of 4.1 tests

--
-- Bug #14693 (ALTER SET DEFAULT doesn't work)
--

create table t1 (mycol int(10) not null);
alter table t1 alter column mycol set default 0;
drop table t1;

--
-- Bug#25262 Auto Increment lost when changing Engine type
--

create table t1(id int(8) primary key auto_increment) engine=heap;

insert into t1 values (null);
insert into t1 values (null);

select * from t1;

-- Set auto increment to 50
alter table t1 auto_increment = 50;

-- Alter to myisam
alter table t1 engine = myisam;

-- This insert should get id 50
insert into t1 values (null);
select * from t1;

-- Alter to heap again
alter table t1 engine = heap;
insert into t1 values (null);
select * from t1;

drop table t1;

--
-- Bug#27507: Wrong DATETIME value was allowed by ALTER TABLE in the
--            NO_ZERO_DATE mode.
--
set sql_mode= default;
create table t1(f1 int) engine=myisam;
alter table t1 add column f2 datetime not null, add column f21 date not null;
insert into t1 values(1,'2000-01-01','2000-01-01');
alter table t1 add column f3 datetime not null;
alter table t1 add column f3 date not null;
alter table t1 add column f4 datetime not null default '2002-02-02',
  add column f41 date not null;
alter table t1 add column f4 datetime not null default '2002-02-02',
  add column f41 date not null default '2002-02-02';
select * from t1;
drop table t1;

--
-- Some additional tests for new, faster alter table.  Note that most of the
-- whole alter table code is being tested all around the test suite already.
--

create table t1 (v varchar(32));
insert into t1 values ('def'),('abc'),('hij'),('3r4f');
select * from t1;
alter table t1 change v v2 varchar(32);
select * from t1;
alter table t1 change v2 v varchar(64);
select * from t1;
update t1 set v = 'lmn' where v = 'hij';
select * from t1;
alter table t1 add i int auto_increment not null primary key first;
select * from t1;
update t1 set i=5 where i=3;
select * from t1;
alter table t1 change i i bigint;
select * from t1;
alter table t1 add unique key (i, v);
select * from t1 where i between 2 and 4 and v in ('def','3r4f','lmn');
drop table t1;

--
-- Bug#6073 "ALTER table minor glich": ALTER TABLE complains that an index
-- without # prefix is not allowed for TEXT columns, while index
-- is defined with prefix.
--
create table t1 (t varchar(255) default null, key t (t(80)))
engine=myisam default charset=latin1;
alter table t1 change t t text;
drop table t1;

--
-- Bug #26794: Adding an index with a prefix on a SPATIAL type breaks ALTER
-- TABLE
--
CREATE TABLE t1 (a varchar(500));

ALTER TABLE t1 ADD b GEOMETRY NOT NULL SRID 0, ADD SPATIAL INDEX(b);
ALTER TABLE t1 ADD KEY(b(50));

ALTER TABLE t1 ADD c POINT;
CREATE TABLE t2 (a INT, KEY (a(20)));

ALTER TABLE t1 ADD d INT;
ALTER TABLE t1 ADD KEY (d(20));

-- the 5.1 part of the test
--error ER_WRONG_SUB_KEY
ALTER TABLE t1 ADD e GEOMETRY NOT NULL, ADD SPATIAL KEY (e(30));

DROP TABLE t1;

--
-- Bug#18038  MySQL server corrupts binary columns data
--

CREATE TABLE t1 (s CHAR(8) BINARY);
INSERT INTO t1 VALUES ('test');
SELECT LENGTH(s) FROM t1;
ALTER TABLE t1 MODIFY s CHAR(10) BINARY;
SELECT LENGTH(s) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (s BINARY(8));
INSERT INTO t1 VALUES ('test');
SELECT LENGTH(s) FROM t1;
SELECT HEX(s) FROM t1;
ALTER TABLE t1 MODIFY s BINARY(10);
SELECT HEX(s) FROM t1;
SELECT LENGTH(s) FROM t1;
DROP TABLE t1;

--
-- Bug#19386: Multiple alter causes crashed table
-- The trailing column would get corrupted data, or server could not even read
-- it.
--

CREATE TABLE t1 (v VARCHAR(3), b INT);
INSERT INTO t1 VALUES ('abc', 5);
SELECT * FROM t1;
ALTER TABLE t1 MODIFY COLUMN v VARCHAR(4);
SELECT * FROM t1;
DROP TABLE t1;


--
-- Bug#31291 ALTER TABLE CONVERT TO CHARACTER SET does not change some data types
--
create table t1 (a tinytext character set latin1);
alter table t1 convert to character set utf8mb3;
drop table t1;
create table t1 (a mediumtext character set latin1);
alter table t1 convert to character set utf8mb3;
drop table t1;

--
-- Extended test coverage for ALTER TABLE behaviour under LOCK TABLES
-- It should be consistent across all platforms and for all engines
-- (Before 5.1 this was not true as behavior was different between
-- Unix/Windows and transactional/non-transactional tables).
-- See also innodb_mysql.test.
-- See alter_table-big.test for extended full ALTER TABLE RENAME coverage.
--
create table t1 (i int);
create table t3 (j int);
insert into t1 values ();
insert into t3 values ();
alter table t1 modify i int default 1;
insert into t1 values ();
select * from t1;
alter table t1 change i c char(10) default "Two";
insert into t1 values ();
select * from t1;
alter table t1 modify c char(10) default "Three", rename to t2;
select * from t1;
select * from t2;
select * from t3;
insert into t2 values ();
select * from t2;
alter table t2 change c vc varchar(100) default "Four", rename to t1;
select * from t1;
select * from t2;
select * from t3;
insert into t1 values ();
select * from t1;
drop tables t1, t3;


--
-- Bug#18775 - Temporary table from alter table visible to other threads
--
-- Check if special characters work and duplicates are detected.
CREATE TABLE `t+1` (c1 INT);
ALTER TABLE  `t+1` RENAME `t+2`;
CREATE TABLE `t+1` (c1 INT);
ALTER TABLE  `t+1` RENAME `t+2`;
DROP TABLE   `t+1`, `t+2`;
CREATE TEMPORARY TABLE `tt+1` (c1 INT);
ALTER TABLE  `tt+1` RENAME `tt+2`;
CREATE TEMPORARY TABLE `tt+1` (c1 INT);
ALTER TABLE  `tt+1` RENAME `tt+2`;
DROP TABLE   `tt+1`, `tt+2`;
CREATE TABLE `--sql1` (c1 INT);
CREATE TABLE `@0023sql2` (c1 INT);
ALTER TABLE `@0023sql1`  RENAME `--sql-1`;
ALTER TABLE `--sql2`      RENAME `@0023sql-2`;
INSERT INTO `--sql-1`     VALUES (1);
INSERT INTO `@0023sql-2` VALUES (2);
DROP TABLE `--sql-1`, `@0023sql-2`;
CREATE TEMPORARY TABLE `--sql1` (c1 INT);
CREATE TEMPORARY TABLE `@0023sql2` (c1 INT);
ALTER TABLE `--sql1`      RENAME `@0023sql1`;
ALTER TABLE `@0023sql2`  RENAME `--sql2`;
INSERT INTO `--sql2`      VALUES (1);
INSERT INTO `@0023sql1`  VALUES (2);
DROP TABLE `--sql2`, `@0023sql1`;

--
-- Bug #22369: Alter table rename combined with other alterations causes lost tables
--
-- This problem happens if the data change is compatible.
-- Changing to the same type is compatible for example.
--
--enable_warnings
CREATE TABLE t1 (
  int_field INTEGER UNSIGNED NOT NULL,
  char_field CHAR(10),
  INDEX(`int_field`)
);

INSERT INTO t1 VALUES (1, "edno"), (1, "edno"), (2, "dve"), (3, "tri"), (5, "pet");
ALTER TABLE t1
  CHANGE int_field unsigned_int_field INTEGER UNSIGNED NOT NULL,
  RENAME t2;
SELECT * FROM t1 ORDER BY int_field;
SELECT * FROM t2 ORDER BY unsigned_int_field;
ALTER TABLE t2 MODIFY unsigned_int_field BIGINT UNSIGNED NOT NULL;

DROP TABLE t2;

--
-- Bug#28427: Columns were renamed instead of moving by ALTER TABLE.
--
CREATE TABLE t1 (f1 INT, f2 INT, f3 INT);
INSERT INTO t1 VALUES (1, 2, NULL);
SELECT * FROM t1;
ALTER TABLE t1 MODIFY COLUMN f3 INT AFTER f1;
SELECT * FROM t1;
ALTER TABLE t1 MODIFY COLUMN f3 INT AFTER f2;
SELECT * FROM t1;
DROP TABLE t1;

--
-- BUG#29957 - alter_table.test fails
--
create table t1 (c char(10) default "Two");
insert into t1 values ();
alter table t1 modify c char(10) default "Three";
select * from t1;
drop table t1;

--
-- Bug#33873: Fast ALTER TABLE doesn't work with multibyte character sets
--

CREATE TABLE t1 (id int, c int) character set latin1;
INSERT INTO t1 VALUES (1,1);
ALTER TABLE t1 CHANGE c d int;
ALTER TABLE t1 CHANGE d c int;
ALTER TABLE t1 MODIFY c VARCHAR(10);
ALTER TABLE t1 CHANGE c d varchar(10);
ALTER TABLE t1 CHANGE d c varchar(10);
DROP TABLE t1;

CREATE TABLE t1 (id int, c int) character set utf8mb3;
INSERT INTO t1 VALUES (1,1);
ALTER TABLE t1 CHANGE c d int;
ALTER TABLE t1 CHANGE d c int;
ALTER TABLE t1 MODIFY c VARCHAR(10);
ALTER TABLE t1 CHANGE c d varchar(10);
ALTER TABLE t1 CHANGE d c varchar(10);
DROP TABLE t1;

--
-- pack_keys and max_data_length options are meant for Myisam tables
-- Bug#39372 "Smart" ALTER TABLE not so smart after all.
--
create table t1(f1 int not null, f2 int not null, key  (f1), key (f2)) engine=myisam;
let $count= 50;
{
  EVAL insert into t1 values (1,1),(1,1),(1,1),(1,1),(1,1);
  dec $count ;

select index_length into @unpaked_keys_size from
information_schema.tables where table_name='t1';
alter table t1 pack_keys=1;
select index_length into @paked_keys_size from
information_schema.tables where table_name='t1';
select (@unpaked_keys_size > @paked_keys_size);

select max_data_length into @orig_max_data_length from
information_schema.tables where table_name='t1';
alter table t1 max_rows=100;
select max_data_length into @changed_max_data_length from
information_schema.tables where table_name='t1';
select (@orig_max_data_length > @changed_max_data_length);

drop table t1;

--
-- Bug #23113: Different behavior on altering ENUM fields between 5.0 and 5.1
--
CREATE TABLE t1(a INT AUTO_INCREMENT PRIMARY KEY,
  b ENUM('a', 'b', 'c') NOT NULL);
INSERT INTO t1 (b) VALUES ('a'), ('c'), ('b'), ('b'), ('a');
ALTER TABLE t1 MODIFY b ENUM('a', 'z', 'b', 'c') NOT NULL;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a ENUM('a1','a2'));
INSERT INTO t1 VALUES ('a1'),('a2');
ALTER TABLE t1 MODIFY COLUMN a ENUM('a1','a2');
ALTER TABLE t1 MODIFY COLUMN a ENUM('a1','a2','a3');
ALTER TABLE t1 MODIFY COLUMN a ENUM('a1','a2','xx','a5');
ALTER TABLE t1 MODIFY COLUMN a ENUM('a1','a2','xx');
ALTER TABLE t1 MODIFY COLUMN a ENUM('a1','a2','a0','xx');
ALTER TABLE t1 MODIFY COLUMN a ENUM('a1','a2','a0','xx','a5','a6');
DROP TABLE t1;

CREATE TABLE t1 (a SET('a1','a2'));
INSERT INTO t1 VALUES ('a1'),('a2');
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2');
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','a3');
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','xx','a5');
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','xx');
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','a0','xx');
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','a0','xx','a5','a6');
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','a0','xx','a5','a6','a7','a8','a9','a10');
DROP TABLE t1;

--
-- Bug#43508: Renaming timestamp or date column triggers table copy
--

CREATE TABLE t1 (f1 TIMESTAMP NULL DEFAULT NULL,
                 f2 INT(11) DEFAULT NULL) ENGINE=MYISAM DEFAULT CHARSET=utf8mb3;

INSERT INTO t1 VALUES (NULL, NULL), ("2009-10-09 11:46:19", 2);
ALTER TABLE t1 CHANGE COLUMN f1 f1_no_real_change TIMESTAMP NULL DEFAULT NULL;
DROP TABLE t1;

CREATE TABLE t1 (a TEXT, id INT, b INT);
ALTER TABLE t1 DROP COLUMN a, ADD COLUMN c TEXT FIRST;

DROP TABLE t1;
create table t1 (i int, j int) engine=myisam;
insert into t1 value (1, 2);
select * from t1;
alter table t1 modify column j int first;
select * from t1;
alter table t1 drop column i, add column k int default 0;
select * from t1;
drop table t1;

--
-- Bug #31031 ALTER TABLE regression in 5.0
--
--  The ALTER TABLE operation failed with
--  ERROR 1089 (HY000): Incorrect sub part key;
CREATE TABLE t1(c CHAR(10),
  i INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY);
INSERT INTO t1 VALUES('a',2),('b',4),('c',6);
ALTER TABLE t1
  DROP i,
  ADD i INT UNSIGNED NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 1;
DROP TABLE t1;


--
-- Bug#50542 5.5.x doesn't check length of key prefixes:
--           corruption and crash results
--
-- This case is related to Bug#31031 (above)
-- A statement where the index key is larger/wider than
-- the column type, should cause an error
--
--error ER_WRONG_SUB_KEY
CREATE TABLE t1 (a CHAR(1), PRIMARY KEY (a(255)));

-- Test other variants of creating indices
CREATE TABLE t1 (a CHAR(1));
--  ALTER TABLE
--error ER_WRONG_SUB_KEY
ALTER TABLE t1 ADD PRIMARY KEY (a(20));
ALTER TABLE t1 ADD KEY (a(20));
--  CREATE INDEX
--error ER_WRONG_SUB_KEY
CREATE UNIQUE INDEX i1 ON t1 (a(20));
CREATE INDEX i2 ON t1 (a(20));
DROP TABLE t1;


--
-- Bug #45052    ALTER TABLE ADD COLUMN crashes server with multiple foreign key columns
--   The alter table fails if 2 or more new fields added and
--   also added a key with these fields
--
CREATE TABLE t1 (id int);
INSERT INTO t1 VALUES (1), (2);
ALTER TABLE t1 ADD COLUMN (f1 INT), ADD COLUMN (f2 INT), ADD KEY f2k(f2);
DROP TABLE t1;
CREATE TABLE t1 (a INT, b MEDIUMINT);
INSERT INTO t1 VALUES (1, 1), (2, 2);
ALTER TABLE t1 CHANGE a id INT;
DROP TABLE t1;

CREATE DATABASE db1 CHARACTER SET utf8mb3;
CREATE TABLE db1.t1 (bar TINYTEXT, KEY (bar(100)));
CREATE TABLE db1.t1 (bar TINYTEXT, KEY (bar(85)));
ALTER TABLE db1.t1 ADD baz INT;

DROP DATABASE db1;

CREATE TEMPORARY TABLE t1 (i int) ENGINE=MyISAM;
ALTER TABLE t1 DISCARD TABLESPACE;

DROP TABLE t1;
create table t1 (a int);
drop table t2;

CREATE TABLE t1 (c1 int unsigned , c2 char(100) not null default '');
ALTER TABLE t1 ADD c3 char(16) NOT NULL DEFAULT '' AFTER c2,
               MODIFY c2 char(100) NOT NULL DEFAULT '' AFTER c1;
DROP TABLE t1;

CREATE TABLE t1(a INT PRIMARY KEY, b INT) engine=InnoDB;
CREATE TABLE m1(a INT PRIMARY KEY, b INT) engine=MyISAM;
INSERT INTO t1 VALUES (1,1), (2,2);
INSERT INTO m1 VALUES (1,1), (2,2);
ALTER TABLE t1 ADD INDEX i1(b);
ALTER TABLE t1 ADD INDEX i2(b), ALGORITHM= DEFAULT;
ALTER TABLE t1 ADD INDEX i3(b), ALGORITHM= COPY;
ALTER TABLE t1 ADD INDEX i4(b), ALGORITHM= INPLACE;
ALTER TABLE t1 ADD INDEX i5(b), ALGORITHM= INVALID;

ALTER TABLE m1 ENABLE KEYS;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= DEFAULT;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= COPY;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= INPLACE;

ALTER TABLE t1 DROP INDEX i1, DROP INDEX i2, DROP INDEX i3, DROP INDEX i4;
SET SESSION old_alter_table= 1;
ALTER TABLE t1 ADD INDEX i1(b);
ALTER TABLE t1 ADD INDEX i2(b), ALGORITHM= DEFAULT;
ALTER TABLE t1 ADD INDEX i3(b), ALGORITHM= COPY;
ALTER TABLE t1 ADD INDEX i4(b), ALGORITHM= INPLACE;
SET SESSION old_alter_table= 0;

ALTER TABLE t1 DROP INDEX i1, DROP INDEX i2, DROP INDEX i3, DROP INDEX i4;

ALTER TABLE t1 ADD COLUMN (c1 INT);
ALTER TABLE t1 ADD COLUMN (c2 INT), ALGORITHM= DEFAULT;
ALTER TABLE t1 ADD COLUMN (c3 INT), ALGORITHM= COPY;
ALTER TABLE t1 ADD COLUMN (c4 INT), ALGORITHM= INPLACE;

ALTER TABLE t1 DROP COLUMN c1, DROP COLUMN c2, DROP COLUMN c3, DROP COLUMN c4;
ALTER TABLE t1 ADD INDEX i1(b), LOCK= DEFAULT;
ALTER TABLE t1 ADD INDEX i2(b), LOCK= NONE;
ALTER TABLE t1 ADD INDEX i3(b), LOCK= SHARED;
ALTER TABLE t1 ADD INDEX i4(b), LOCK= EXCLUSIVE;
ALTER TABLE t1 ADD INDEX i5(b), LOCK= INVALID;

ALTER TABLE m1 ENABLE KEYS, LOCK= DEFAULT;
ALTER TABLE m1 ENABLE KEYS, LOCK= NONE;
ALTER TABLE m1 ENABLE KEYS, LOCK= SHARED;
ALTER TABLE m1 ENABLE KEYS, LOCK= EXCLUSIVE;

ALTER TABLE t1 DROP INDEX i1, DROP INDEX i2, DROP INDEX i3, DROP INDEX i4;
ALTER TABLE t1 ADD INDEX i1(b), ALGORITHM= INPLACE, LOCK= NONE;
ALTER TABLE t1 ADD INDEX i2(b), ALGORITHM= INPLACE, LOCK= SHARED;
ALTER TABLE t1 ADD INDEX i3(b), ALGORITHM= INPLACE, LOCK= EXCLUSIVE;
ALTER TABLE t1 ADD INDEX i4(b), ALGORITHM= COPY, LOCK= NONE;
ALTER TABLE t1 ADD INDEX i5(b), ALGORITHM= COPY, LOCK= SHARED;
ALTER TABLE t1 ADD INDEX i6(b), ALGORITHM= COPY, LOCK= EXCLUSIVE;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= INPLACE, LOCK= NONE;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= INPLACE, LOCK= SHARED;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= INPLACE, LOCK= EXCLUSIVE;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= COPY, LOCK= NONE;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= COPY, LOCK= SHARED;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= COPY, LOCK= EXCLUSIVE;

DROP TABLE t1, m1;

-- Disable/Enable keys supported by Myisam only
--echo --
--echo -- 6: Possible deadlock involving thr_lock.c
--echo --

CREATE TABLE t1(a INT PRIMARY KEY, b INT) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1,1), (2,2);
INSERT INTO t1 VALUES (3,3);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER TABLE t1 DISABLE KEYS";
UPDATE t1 SET b = 4;
DROP TABLE t1;

CREATE TABLE ti1(a INT NOT NULL, b INT, c INT) engine=InnoDB;
CREATE TABLE tm1(a INT NOT NULL, b INT, c INT) engine=MyISAM;
CREATE TABLE ti2(a INT PRIMARY KEY AUTO_INCREMENT, b INT, c INT) engine=InnoDB;
CREATE TABLE tm2(a INT PRIMARY KEY AUTO_INCREMENT, b INT, c INT) engine=MyISAM;
INSERT INTO ti1 VALUES (1,1,1), (2,2,2);
INSERT INTO ti2 VALUES (1,1,1), (2,2,2);
INSERT INTO tm1 VALUES (1,1,1), (2,2,2);
INSERT INTO tm2 VALUES (1,1,1), (2,2,2);
ALTER TABLE ti1;
ALTER TABLE tm1;

ALTER TABLE ti1 ADD COLUMN d VARCHAR(200);
ALTER TABLE tm1 ADD COLUMN d VARCHAR(200);
ALTER TABLE ti1 ADD COLUMN d2 VARCHAR(200);
ALTER TABLE tm1 ADD COLUMN d2 VARCHAR(200);
ALTER TABLE ti1 ADD COLUMN e ENUM('a', 'b') FIRST;
ALTER TABLE tm1 ADD COLUMN e ENUM('a', 'b') FIRST;
ALTER TABLE ti1 ADD COLUMN f INT AFTER a;
ALTER TABLE tm1 ADD COLUMN f INT AFTER a;

ALTER TABLE ti1 ADD INDEX ii1(b);
ALTER TABLE tm1 ADD INDEX im1(b);
ALTER TABLE ti1 ADD UNIQUE INDEX ii2 (c);
ALTER TABLE tm1 ADD UNIQUE INDEX im2 (c);
ALTER TABLE ti1 ADD FULLTEXT INDEX ii3 (d);
ALTER TABLE tm1 ADD FULLTEXT INDEX im3 (d);
ALTER TABLE ti1 ADD FULLTEXT INDEX ii4 (d2);
ALTER TABLE tm1 ADD FULLTEXT INDEX im4 (d2);

-- Bug#14140038 INCONSISTENT HANDLING OF FULLTEXT INDEXES IN ALTER TABLE
--error ER_ALTER_OPERATION_NOT_SUPPORTED_REASON
ALTER TABLE ti1 ADD PRIMARY KEY(a), ALGORITHM=INPLACE;
ALTER TABLE ti1 ADD PRIMARY KEY(a);
ALTER TABLE tm1 ADD PRIMARY KEY(a);

ALTER TABLE ti1 DROP INDEX ii3;
ALTER TABLE tm1 DROP INDEX im3;

ALTER TABLE ti1 DROP COLUMN d2;
ALTER TABLE tm1 DROP COLUMN d2;

ALTER TABLE ti1 ADD CONSTRAINT fi1 FOREIGN KEY (b) REFERENCES ti2(a);
ALTER TABLE tm1 ADD CONSTRAINT fm1 FOREIGN KEY (b) REFERENCES tm2(a);

ALTER TABLE ti1 ALTER COLUMN b SET DEFAULT 1;
ALTER TABLE tm1 ALTER COLUMN b SET DEFAULT 1;
ALTER TABLE ti1 ALTER COLUMN b DROP DEFAULT;
ALTER TABLE tm1 ALTER COLUMN b DROP DEFAULT;

-- This will set both ALTER_COLUMN_NAME and COLUMN_DEFAULT_VALUE
ALTER TABLE ti1 CHANGE COLUMN f g INT;
ALTER TABLE tm1 CHANGE COLUMN f g INT;
ALTER TABLE ti1 CHANGE COLUMN g h VARCHAR(20);
ALTER TABLE tm1 CHANGE COLUMN g h VARCHAR(20);
ALTER TABLE ti1 MODIFY COLUMN e ENUM('a', 'b', 'c');
ALTER TABLE tm1 MODIFY COLUMN e ENUM('a', 'b', 'c');
ALTER TABLE ti1 MODIFY COLUMN e INT;
ALTER TABLE tm1 MODIFY COLUMN e INT;
ALTER TABLE ti1 MODIFY COLUMN e INT AFTER h;
ALTER TABLE tm1 MODIFY COLUMN e INT AFTER h;
ALTER TABLE ti1 MODIFY COLUMN e INT FIRST;
ALTER TABLE tm1 MODIFY COLUMN e INT FIRST;
ALTER TABLE ti1 MODIFY COLUMN c INT NOT NULL;
ALTER TABLE tm1 MODIFY COLUMN c INT NOT NULL;
ALTER TABLE ti1 MODIFY COLUMN c INT NULL;
ALTER TABLE tm1 MODIFY COLUMN c INT NULL;
ALTER TABLE ti1 MODIFY COLUMN h VARCHAR(30);
ALTER TABLE tm1 MODIFY COLUMN h VARCHAR(30);
ALTER TABLE ti1 MODIFY COLUMN h VARCHAR(30) AFTER d;
ALTER TABLE tm1 MODIFY COLUMN h VARCHAR(30) AFTER d;

ALTER TABLE ti1 DROP COLUMN h;
ALTER TABLE tm1 DROP COLUMN h;

ALTER TABLE ti1 DROP INDEX ii2;
ALTER TABLE tm1 DROP INDEX im2;
ALTER TABLE ti1 DROP PRIMARY KEY;
ALTER TABLE tm1 DROP PRIMARY KEY;

ALTER TABLE ti1 DROP FOREIGN KEY fi1;
ALTER TABLE tm1 DROP FOREIGN KEY fm1;

ALTER TABLE ti1 RENAME TO ti3;
ALTER TABLE tm1 RENAME TO tm3;
ALTER TABLE ti3 RENAME TO ti1;
ALTER TABLE tm3 RENAME TO tm1;

ALTER TABLE ti1 ORDER BY b;
ALTER TABLE tm1 ORDER BY b;

ALTER TABLE ti1 CONVERT TO CHARACTER SET utf16;
ALTER TABLE tm1 CONVERT TO CHARACTER SET utf16;
ALTER TABLE ti1 DEFAULT CHARACTER SET utf8mb3;
ALTER TABLE tm1 DEFAULT CHARACTER SET utf8mb3;

ALTER TABLE ti1 FORCE;
ALTER TABLE tm1 FORCE;

ALTER TABLE ti1 AUTO_INCREMENT 3;
ALTER TABLE tm1 AUTO_INCREMENT 3;
ALTER TABLE ti1 AVG_ROW_LENGTH 10;
ALTER TABLE tm1 AVG_ROW_LENGTH 10;
ALTER TABLE ti1 CHECKSUM 1;
ALTER TABLE tm1 CHECKSUM 1;
ALTER TABLE ti1 COMMENT 'test';
ALTER TABLE tm1 COMMENT 'test';
ALTER TABLE ti1 MAX_ROWS 100;
ALTER TABLE tm1 MAX_ROWS 100;
ALTER TABLE ti1 MIN_ROWS 1;
ALTER TABLE tm1 MIN_ROWS 1;
ALTER TABLE ti1 PACK_KEYS 1;
ALTER TABLE tm1 PACK_KEYS 1;
DROP TABLE ti1, ti2, tm1, tm2;

CREATE TABLE ti1(a INT PRIMARY KEY AUTO_INCREMENT, b INT) engine=InnoDB;
INSERT INTO ti1(b) VALUES (1), (2);
ALTER TABLE ti1 RENAME TO ti3, ADD INDEX ii1(b);

ALTER TABLE ti3 DROP INDEX ii1, AUTO_INCREMENT 5;
INSERT INTO ti3(b) VALUES (5);
ALTER TABLE ti3 ADD INDEX ii1(b), AUTO_INCREMENT 7;
INSERT INTO ti3(b) VALUES (7);
SELECT * FROM ti3;

DROP TABLE ti3;

CREATE TABLE tm1(i INT DEFAULT 1) engine=MyISAM;
ALTER TABLE tm1 ADD INDEX ii1(i), ALTER COLUMN i DROP DEFAULT;
DROP TABLE tm1;

use mysql;
ALTER TABLE db ENGINE=memory;
ALTER TABLE user ENGINE=memory;
ALTER TABLE func ENGINE=csv;
ALTER TABLE servers ENGINE=merge;
ALTER TABLE procs_priv ENGINE=memory;
ALTER TABLE tables_priv ENGINE=heap;
ALTER TABLE columns_priv ENGINE=csv;
ALTER TABLE time_zone ENGINE=merge;
ALTER TABLE help_topic ENGINE=merge;
CREATE TABLE db (dummy int) ENGINE=memory;
CREATE TABLE user (dummy int) ENGINE=memory;
CREATE TABLE func (dummy int) ENGINE=memory;
CREATE TABLE servers (dummy int) ENGINE=merge;
CREATE TABLE procs_priv (dummy int) ENGINE=memory;
CREATE TABLE tables_priv (dummy int) ENGINE=heap;
CREATE TABLE columns_priv (dummy int) ENGINE=memory;
CREATE TABLE time_zone (dummy int) ENGINE=merge;
CREATE TABLE help_topic (dummy int) ENGINE=merge;
use test;
create table t1 (pk int primary key, i int, j int, key a(i));
alter table t1 rename key a to b;
alter table t1 rename index b to c;
alter table t1 rename key d to e;
alter table t1 drop key c, rename key c to d;
alter table t1 add key d(j), rename key d to e;
alter table t1 add key d(j);
alter table t1 rename key c to d;
alter table t1 drop key d;
alter table t1 add key d(j), rename key c to d;
alter table t1 add key d(j);
alter table t1 drop key c, rename key d to c;
alter table t1 rename key primary to d;
alter table t1 rename key `primary` to d;
alter table t1 rename key c to primary;
alter table t1 rename key c to `primary`;
drop table t1;
create table t1 (a int, unique u(a), b int, key k(b));
alter table t1 rename key u to uu;
alter table t1 rename key k to kk;
alter table t1 rename key kk to kkk, add column c int;
alter table t1 rename key uu to uuu, add key c(c);
alter table t1 rename key kkk to k, drop key uuu;
alter table t1 rename key k to kk, rename to t2;
alter table t2 rename key c to cc, modify column c bigint not null first;
alter table t2 add unique u (a, b, c);
alter table t2 rename key u to uu, drop column b;
drop table t2;
create table t1 (i int, key k(i)) engine=myisam;
insert into t1 values (1);
create table t2 (i int, key k(i)) engine=memory;
insert into t2 values (1);
alter table t1 algorithm=inplace, rename key k to kk;
alter table t2 algorithm=inplace, rename key k to kk;
alter table t1 rename key kk to kkk;
alter table t2 rename key kk to kkk;
alter table t1 algorithm=copy, rename key kkk to kkkk;
alter table t2 algorithm=copy, rename key kkk to kkkk;
alter table t1 algorithm=inplace, rename key kkkk to k, alter column i set default 100;
alter table t2 algorithm=inplace, rename key kkkk to k, alter column i set default 100;
alter table t1 algorithm=inplace, rename key k to kk, add column j int;
alter table t2 algorithm=inplace, rename key k to kk, add column j int;
drop table t1, t2;
create table t1 (i int, key k(i)) engine=innodb;
insert into t1 values (1);
alter table t1 algorithm=inplace, rename key k to kk;
alter table t1 algorithm=copy, rename key kk to kkk;
drop table t1;
create table t1 ( a int, b int, c int, d int,
                  primary key (a), index i1 (b), index i2 (c) ) engine=innodb;
alter table t1 add index i1 (d), rename index i1 to x;
select i.name as k, f.name as c from information_schema.innodb_tables as t,
                                     information_schema.innodb_indexes as i,
                                     information_schema.innodb_fields as f
where t.name='test/t1' and t.table_id = i.table_id and i.index_id = f.index_id
order by k, c;
drop table t1;
create table t1 (a int, b int, c int, d int,
                 primary key (a), index i1 (b), index i2 (c)) engine=innodb;
alter table t1 add index i1 (d), rename index i1 to i2, drop index i2;
select i.name as k, f.name as c from information_schema.innodb_tables as t,
                                     information_schema.innodb_indexes as i,
                                     information_schema.innodb_fields as f
where t.name='test/t1' and t.table_id = i.table_id and i.index_id = f.index_id
order by k, c;
drop table t1;
create table t1 (i int, key x(i)) engine=InnoDB;
alter table t1 drop key x, add key X(i), alter column i set default 10;
drop table t1;

CREATE TABLE t1 (i INT) ENGINE=InnoDB;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER TABLE t1 DISCARD TABLESPACE";
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER TABLE t1 IMPORT TABLESPACE";
DROP TABLE t1;

CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TEMPORARY TABLE t1 (j INT) ENGINE=InnoDB;
ALTER TABLE t1 DISCARD TABLESPACE;
ALTER TABLE t1 IMPORT TABLESPACE;

DROP TEMPORARY TABLE t1;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER TABLE t1 DISCARD TABLESPACE";
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info = "ALTER TABLE t1 IMPORT TABLESPACE";
DROP TABLE t1;

CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TEMPORARY TABLE t1 (j INT) ENGINE=InnoDB;
ALTER TABLE t1 DISCARD TABLESPACE;
ALTER TABLE t1 IMPORT TABLESPACE;
DROP TEMPORARY TABLE t1;
DROP TABLE t1;
SET sql_mode = default;
CREATE TABLE t1(fld1 int, key key1(fld1));
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT 'test';
DROP TABLE t1;

CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'test');
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1);
DROP TABLE t1;

CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'test');
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT 'success';
DROP TABLE t1;

-- Alter the comment, but keep the same comment length
CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'old comment');
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT 'new comment';
DROP TABLE t1;

CREATE TABLE t1(a INT NOT NULL, b POINT NOT NULL) ENGINE=INNODB;
ALTER TABLE t1 ADD UNIQUE INDEX (b);

ALTER TABLE t1 ADD UNIQUE INDEX (a);
SELECT T.NAME AS TABLE_NAME, I.NAME AS INDEX_NAME,
       CASE I.TYPE 
            WHEN 0 THEN 'Secondary'
            WHEN 1 THEN 'Clustered'
            WHEN 2 THEN 'Unique'
            WHEN 3 THEN 'Primary'
            WHEN 32 THEN 'Full text'
            WHEN 64 THEN 'Spatial'
            ELSE 'Unknown'
       END AS INDEX_TYPE,
       F.NAME AS FIELD_NAME, F.POS AS FIELD_POS FROM
              INFORMATION_SCHEMA.INNODB_TABLES AS T JOIN
              INFORMATION_SCHEMA.INNODB_INDEXES AS I JOIN
              INFORMATION_SCHEMA.INNODB_FIELDS AS F
              ON I.INDEX_ID = F.INDEX_ID AND I.TABLE_ID = T.TABLE_ID
       WHERE T.NAME = 'test/t1' ORDER BY I.NAME, F.NAME;

DROP TABLE t1;


SET @orig_sql_mode = @@sql_mode;
SET sql_mode= '';
CREATE TABLE t1(fld1 VARCHAR(767), KEY a(fld1)) charset latin1 ENGINE= INNODB
ROW_FORMAT=COMPACT;
ALTER TABLE t1 CHANGE fld1 fld1 VARCHAR(768), ALGORITHM= INPLACE;
DROP TABLE t1;

CREATE TABLE t1(fld1 VARCHAR(3072), KEY a(fld1)) charset latin1 ENGINE= INNODB,
ROW_FORMAT=DYNAMIC;
INSERT INTO t1 VALUES('a');
ALTER TABLE t1 CHANGE fld1 fld1 VARCHAR(3073), ALGORITHM= INPLACE;
SELECT COUNT(*) FROM t1 WHERE fld1= 'a';
DROP TABLE t1;

CREATE TABLE t1(fld1 VARCHAR(3072), KEY a(fld1)) charset latin1 ENGINE= INNODB
ROW_FORMAT= DYNAMIC;
INSERT INTO t1 VALUES('a');
ALTER TABLE t1 CHANGE fld1 fld1 VARCHAR(3073), ALGORITHM= INPLACE;
SELECT COUNT(*) FROM t1 WHERE fld1= 'a';
DROP TABLE t1;
SET sql_mode= @orig_sql_mode;
CREATE TABLE t1(fld1 int, key key1(fld1)) ENGINE= INNODB;
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT 'test',
ALGORITHM= INPLACE;
DROP TABLE t1;

CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'test') ENGINE= MyISAM;
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1), ALGORITHM=INPLACE;
DROP TABLE t1;

CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'test') ENGINE= INNODB;
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT 'success',
ALGORITHM= INPLACE;
DROP TABLE t1;

-- Alter the comment, but keep the same comment length
CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'old comment') ENGINE=MyISAM;
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT 'new comment',
ALGORITHM= INPLACE;
DROP TABLE t1;

CREATE TABLE t1(fld1 int, key key1(fld1)) ENGINE=INNODB;
SELECT MERGE_THRESHOLD from INFORMATION_SCHEMA.INNODB_INDEXES WHERE NAME='key1';
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT
'MERGE_THRESHOLD=45';
SELECT MERGE_THRESHOLD from INFORMATION_SCHEMA.INNODB_INDEXES WHERE NAME='key1';
DROP TABLE t1;

CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'MERGE_THRESHOLD=40')
ENGINE=INNODB;
SELECT MERGE_THRESHOLD from INFORMATION_SCHEMA.INNODB_INDEXES WHERE NAME='key1';
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1);
SELECT MERGE_THRESHOLD from INFORMATION_SCHEMA.INNODB_INDEXES WHERE NAME='key1';
DROP TABLE t1;

CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'MERGE_THRESHOLD=40')
ENGINE=INNODB;
SELECT MERGE_THRESHOLD from INFORMATION_SCHEMA.INNODB_INDEXES WHERE NAME='key1';
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT
'MERGE_THRESHOLD=45';
SELECT MERGE_THRESHOLD from INFORMATION_SCHEMA.INNODB_INDEXES WHERE NAME='key1';
DROP TABLE t1;
CREATE TABLESPACE s ADD DATAFILE 's.ibd' ENGINE InnoDB;
CREATE TABLE t (i int) TABLESPACE s ENGINE InnoDB;
ALTER TABLE t DISCARD PARTITION p TABLESPACE;
ALTER TABLE t TABLESPACE s;
DROP TABLE t;
DROP TABLESPACE s ENGINE InnoDB;

CREATE TABLE t1 (f1 INT);
ALTER TABLE t1 CHARACTER SET utf8mb3, CHARACTER SET utf8mb3;
ALTER TABLE t1 CHARACTER SET utf8mb3, CONVERT TO CHARACTER SET utf8mb3;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8mb3, CHARACTER SET utf8mb3;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8mb3, CONVERT TO CHARACTER SET utf8mb3;
ALTER TABLE t1 CHARACTER SET utf8mb3, CONVERT TO CHARACTER SET latin1;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8mb3, CHARACTER SET latin1;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8mb3, CONVERT TO CHARACTER SET latin1;
ALTER TABLE t1 CHARACTER SET utf8mb3 COLLATE latin1_danish_ci;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8mb3 COLLATE latin1_danish_ci;
ALTER TABLE t1 CHARACTER SET latin1, CONVERT TO CHARACTER SET utf8mb3 COLLATE latin1_danish_ci;

-- Clean-up
DROP TABLE t1;

CREATE TABLE t1(fld1 varchar(200), FULLTEXT(fld1)) ENGINE=MyISAM;
INSERT INTO t1 VALUES('ABCD');
ALTER TABLE t1 DROP INDEX fld1, ADD FULLTEXT INDEX fld1(fld1);
ALTER TABLE t1 ALGORITHM=INPLACE, DROP INDEX fld1,
ADD FULLTEXT INDEX fld1(fld1);
DROP TABLE t1;
CREATE TABLE t1(fld1 varchar(200), FULLTEXT(fld1)) ENGINE=INNODB;
INSERT INTO t1 VALUES('ABCD');
ALTER TABLE t1 DROP INDEX fld1, ADD FULLTEXT INDEX fld1(fld1);
ALTER TABLE t1 ALGORITHM=INPLACE, DROP INDEX fld1,
ADD FULLTEXT INDEX fld1(fld1);
DROP TABLE t1;

CREATE TABLE t1 (a INT PRIMARY KEY, b INT,
                 FOREIGN KEY (b) REFERENCES t1(a)) ENGINE= MyISAM;
ALTER TABLE t1 RENAME INDEX b TO w, ADD FOREIGN KEY (b) REFERENCES t1(a);
DROP TABLE t1;

CREATE TABLE t1 (a INT PRIMARY KEY, b INT,
                 FOREIGN KEY (b) REFERENCES t1(a)) ENGINE= InnoDB;
ALTER TABLE t1 RENAME INDEX b TO w, ADD FOREIGN KEY (b) REFERENCES t1(a);
DROP TABLE t1;
CREATE TABLE t0(a INT NOT NULL) ENGINE=INNODB;
ALTER TABLE t0 ADD UNIQUE INDEX (a);
CREATE TABLE t1(a POINT GENERATED ALWAYS AS (POINT(1,1)) VIRTUAL UNIQUE NOT NULL) ENGINE=INNODB;
CREATE TABLE t2(a POINT GENERATED ALWAYS AS (POINT(1,1)) VIRTUAL NOT NULL, UNIQUE INDEX no_pk(a(1))) ENGINE=INNODB;
CREATE TABLE t3(a POINT GENERATED ALWAYS AS (POINT(1,1)) VIRTUAL NOT NULL)
ENGINE=INNODB;
ALTER TABLE t3 ADD UNIQUE INDEX (a(1));
SELECT * FROM t3;
CREATE TABLE t4 (a BLOB, b BLOB GENERATED ALWAYS AS (a) VIRTUAL NOT NULL) ENGINE=INNODB;
ALTER TABLE t4 ADD UNIQUE INDEX (b(1));
SELECT * FROM t4;
SELECT T.NAME AS TABLE_NAME, I.NAME AS INDEX_NAME,
       CASE (I.TYPE & 3)
            WHEN 3 THEN "yes"
            ELSE "no" END AS IS_PRIMARY_KEY,
       F.NAME AS FIELD_NAME, F.POS AS FIELD_POS FROM
              INFORMATION_SCHEMA.INNODB_TABLES AS T JOIN
              INFORMATION_SCHEMA.INNODB_INDEXES AS I JOIN
              INFORMATION_SCHEMA.INNODB_FIELDS AS F
              ON I.INDEX_ID = F.INDEX_ID AND I.TABLE_ID = T.TABLE_ID
       WHERE T.NAME LIKE 'test/%' ORDER BY T.NAME, I.NAME, F.POS;


DROP TABLE t0;
DROP TABLE t3;
DROP TABLE t4;

CREATE TABLE t (a TIMESTAMP(1) GENERATED ALWAYS AS (1) VIRTUAL,
                b INT GENERATED ALWAYS AS (1) VIRTUAL
               ) ENGINE=INNODB;
ALTER TABLE t ADD  INDEX (b);
DROP TABLE t;

CREATE TABLE t1 (fld1 INT PRIMARY KEY) ENGINE = INNODB CHARACTER SET gbk;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8mb3, ALGORITHM = INPLACE;

let $test_dir= `SELECT CONCAT(@@datadir, 'test/')`;

DROP TABLE t1;

CREATE TABLE t1 (fld1 CHAR(10) PRIMARY KEY) ENGINE = INNODB CHARACTER SET gbk;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf8mb3, ALGORITHM = INPLACE;

DROP TABLE t1;

CREATE TABLE t1 (fld1 INT PRIMARY KEY, fld2 CHAR(10)) ENGINE = INNODB
CHARACTER SET gbk;
ALTER TABLE t1 CHARACTER SET utf8mb3, ALGORITHM = INPLACE;

let $test_dir= `SELECT CONCAT(@@datadir, 'test/')`;

DROP TABLE t1;
CREATE TABLE t1(i INT) ENGINE=INNODB PACK_KEYS=0 PACK_KEYS=1
STATS_PERSISTENT=0 STATS_PERSISTENT=1 CHECKSUM=0 CHECKSUM=1
DELAY_KEY_WRITE=0 DELAY_KEY_WRITE=1;
ALTER TABLE t1 PACK_KEYS=1 PACK_KEYS=0 STATS_PERSISTENT=1 STATS_PERSISTENT=0 CHECKSUM=1 CHECKSUM=0 DELAY_KEY_WRITE=1 DELAY_KEY_WRITE=0;

DROP TABLE t1;

-- Before you were allowed to create a prefix key for TEXT columns
-- which were larger than the column length. The column length
-- for TINYBLOB is 255 bytes, while prefix length is in characters.
--error ER_TOO_LONG_KEY
CREATE TABLE t1(id INT PRIMARY KEY,
                name TINYTEXT,
                KEY nameloc (name(64))
) DEFAULT CHARSET=utf8mb4;

-- 63 characters of 4 bytes each fit in 255 bytes.
CREATE TABLE t1(id INT PRIMARY KEY,
                name TINYTEXT,
                KEY nameloc (name(63))
) DEFAULT CHARSET=utf8mb4;

-- Check that we can rebuild the table without issue
ALTER TABLE t1 FORCE;

-- Also check ALTER TABLE
--error ER_TOO_LONG_KEY
ALTER TABLE t1 ADD INDEX idx (name(64), id);
ALTER TABLE t1 ADD INDEX idx (name(63), id);
DROP TABLE t1;

-- Check that we can create a table with a prefix index of
-- 64 4-byte characters for a TEXT column.

-- 64 characters of 4 bytes each fit in 65535 bytes.
CREATE TABLE t1(id INT PRIMARY KEY,
                name TEXT,
                KEY nameloc (name(64))
) DEFAULT CHARSET=utf8mb4;

-- Check ALTER TABLE where we change the type of the
-- base column, reducing max field length, keeping the
-- length of the prefix key the same.
--error ER_TOO_LONG_KEY
ALTER TABLE t1 MODIFY COLUMN name TINYTEXT;
DROP TABLE t1;

SET @saved_sql_mode = @@session.sql_mode;
SET SESSION sql_mode= '';
CREATE TABLE t1(fld1 DATE NOT NULL) ENGINE= INNODB;
INSERT INTO t1 VALUES('2000-01-01');
ALTER TABLE t1 ADD COLUMN fld2 DATETIME NOT NULL, ALGORITHM=INPLACE;
ALTER TABLE t1 ADD COLUMN fld3 DATETIME NOT NULL, ALGORITHM=COPY;

DROP TABLE t1;

SET SESSION sql_mode= 'STRICT_ALL_TABLES';
CREATE TABLE t1(fld1 DATE NOT NULL) ENGINE= INNODB;
INSERT INTO t1 VALUES('2000-01-01');
ALTER TABLE t1 ADD COLUMN fld2 DATETIME NOT NULL, ALGORITHM=INPLACE;
ALTER TABLE t1 ADD COLUMN fld3 DATETIME NOT NULL, ALGORITHM=COPY;

DROP TABLE t1;

SET SESSION sql_mode= 'NO_ZERO_DATE';
CREATE TABLE t1(fld1 DATE NOT NULL) ENGINE= INNODB;
INSERT INTO t1 VALUES('2000-01-01');
ALTER TABLE t1 ADD COLUMN fld2 DATETIME NOT NULL, ALGORITHM=INPLACE;
ALTER TABLE t1 ADD COLUMN fld3 DATETIME NOT NULL, ALGORITHM=COPY;

DROP TABLE t1;

SET SESSION sql_mode= @saved_sql_mode;

CREATE TABLE t1(fld1 DATE NOT NULL) ENGINE= INNODB;
INSERT INTO t1 VALUES('2000-01-01');
ALTER TABLE t1 ADD COLUMN fld2 DATETIME NOT NULL, ALGORITHM=INPLACE;
ALTER TABLE t1 ADD COLUMN fld2 DATETIME NOT NULL, ALGORITHM=COPY;
ALTER TABLE t1 ADD COLUMN fld4 DATETIME NOT NULL, ALGORITHM=INPLACE;
DROP TABLE t1;
CREATE TABLE t1 (pk INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t2 (fk INT, FOREIGN KEY (fk) REFERENCES t1 (pk)) ENGINE=InnoDB;
ALTER TABLE t2 ADD COLUMN j INT, RENAME TO t3, ALGORITHM=INPLACE;
DROP TABLE t3;
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW SET @a:=0;
ALTER TABLE t1 ADD COLUMN j INT, RENAME TO t4, ALGORITHM=INPLACE;
SELECT trigger_name, event_object_schema, event_object_table, action_statement
  FROM information_schema.triggers WHERE event_object_schema = 'test';
DROP TABLE t4;

CREATE TABLE t1(
  i INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY) charset latin1;
ALTER TABLE t1
  DROP i,
  ADD i INT UNSIGNED NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 1;
DROP TABLE t1;

CREATE TABLE t1(
  i INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY) charset utf8mb4;
ALTER TABLE t1
  DROP i,
  ADD i INT UNSIGNED NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 1;
DROP TABLE t1;

SET @saved_sql_mode = @@session.sql_mode;
CREATE TABLE t1 (fld1 INT, fld2 DATETIME NOT NULL) ENGINE= INNODB;
CREATE TABLE t2 (fld1 INT, fld2 POINT NOT NULL) ENGINE= INNODB;

INSERT INTO t1 VALUES(1, '2000-01-01');
INSERT INTO t2 values(1,  ST_PointFromText('POINT(10 10)'));
ALTER TABLE t1 MODIFY fld2 DATETIME NOT NULL AFTER fld1;
ALTER TABLE t2 MODIFY fld2 POINT NOT NULL AFTER fld1;
ALTER TABLE t1 MODIFY fld2 DATETIME NOT NULL FIRST, ALGORITHM= COPY;
ALTER TABLE t2 MODIFY fld2 POINT NOT NULL FIRST, ALGORITHM= COPY;
ALTER TABLE t1 MODIFY fld2 DATETIME NOT NULL AFTER fld1,
               ADD COLUMN fld3 DATETIME NOT NULL;
ALTER TABLE t2 MODIFY fld2 POINT NOT NULL AFTER fld1,
               ADD COLUMN fld3 MULTIPOINT NOT NULL;
ALTER TABLE t1 MODIFY fld2 DATETIME NOT NULL AFTER fld1,
               ADD COLUMN fld3 DATETIME NOT NULL, ALGORITHM= COPY;
ALTER TABLE t2 MODIFY fld2 POINT NOT NULL AFTER fld1,
               ADD COLUMN fld3 MULTIPOINT NOT NULL, ALGORITHM= COPY;
ALTER TABLE t1 MODIFY fld2 DATETIME NOT NULL AFTER fld1;
ALTER TABLE t2 MODIFY fld2 POINT NOT NULL AFTER fld1;
ALTER TABLE t1 MODIFY fld2 DATETIME NOT NULL FIRST, ALGORITHM= COPY;
ALTER TABLE t2 MODIFY fld2 POINT NOT NULL FIRST, ALGORITHM= COPY;
ALTER TABLE t1 MODIFY fld2 DATETIME NOT NULL AFTER fld1,
               ADD COLUMN fld3 DATETIME NOT NULL;
ALTER TABLE t2 MODIFY fld2 POINT NOT NULL AFTER fld1,
               ADD COLUMN fld3 MULTIPOINT NOT NULL;

ALTER TABLE t1 MODIFY fld2 DATETIME NOT NULL AFTER fld1,
               ADD COLUMN fld4 DATETIME NOT NULL, ALGORITHM= COPY;
ALTER TABLE t2 MODIFY fld2 POINT NOT NULL AFTER fld1,
               ADD COLUMN fld4 MULTIPOINT NOT NULL, ALGORITHM= COPY;

DROP TABLE t1, t2;
SET SESSION sql_mode= '';
CREATE TABLE t1 (fld1 char(25)) ENGINE= INNODB;
INSERT INTO t1 VALUES('0000-00-00');
ALTER TABLE t1 MODIFY fld1 DATETIME NOT NULL;

DROP TABLE t1;
SET SESSION sql_mode= 'NO_ZERO_DATE';
CREATE TABLE t1 (fld1 char(25)) ENGINE= INNODB;
INSERT INTO t1 VALUES('0000-00-00');
ALTER TABLE t1 MODIFY fld1 DATETIME NOT NULL;

DROP TABLE t1;

SET SESSION sql_mode= 'STRICT_ALL_TABLES';
CREATE TABLE t1 (fld1 char(25)) ENGINE= INNODB;
INSERT INTO t1 VALUES('0000-00-00');
ALTER TABLE t1 MODIFY fld1 DATETIME NOT NULL;

DROP TABLE t1;
SET SESSION sql_mode= @saved_sql_mode;
CREATE TABLE t1 (fld1 char(25)) ENGINE= INNODB;
INSERT INTO t1 VALUES('0000-00-00');
ALTER TABLE t1 MODIFY fld1 DATETIME NOT NULL;

DROP TABLE t1;
CREATE TABLE t1 (fld0 DATETIME, fld1 INT, fld2 DATETIME NOT NULL) ENGINE= INNODB;
CREATE TABLE t2 (fld0 POINT, fld1 INT, fld2 POINT NOT NULL) ENGINE= INNODB;
INSERT INTO t1 VALUES('2000-01-01', 1, '2000-01-01');
INSERT INTO t2 values(ST_PointFromText('POINT(10 10)'), 1,
                      ST_PointFromText('POINT(10 10)'));
ALTER TABLE t1 MODIFY fld0 DATETIME NOT NULL AFTER fld2;
ALTER TABLE t2 MODIFY fld0 POINT NOT NULL AFTER fld2;

DROP TABLE t1, t2;
CREATE TABLE t1 (fld0 DATETIME, fld1 INT, fld2 DATETIME NOT NULL) ENGINE= INNODB;
CREATE TABLE t2 (fld0 POINT, fld1 INT, fld2 POINT NOT NULL) ENGINE= INNODB;

INSERT INTO t1 VALUES(NULL, 1, '2000-01-01');
INSERT INTO t2 values(NULL, 1, ST_PointFromText('POINT(10 10)'));
ALTER TABLE t1 MODIFY fld0 DATETIME NOT NULL;
ALTER TABLE t2 MODIFY fld0 POINT NOT NULL;

DROP TABLE t1, t2;

CREATE TABLE t1(a INT, b VARCHAR(30), c FLOAT);
INSERT INTO t1 VALUES(1,'abcd',1.234);
CREATE TABLE t2(a INT, b VARCHAR(30), c FLOAT) ENGINE=MyIsam;
INSERT INTO t2 VALUES(1,'abcd',1.234);

-- Rename one column
ALTER TABLE t1 RENAME COLUMN a TO a;
ALTER TABLE t1 RENAME COLUMN a TO m;
SELECT * FROM t1;

-- Rename multiple column
ALTER TABLE t1 RENAME COLUMN m TO x,
               RENAME COLUMN b TO y,
               RENAME COLUMN c TO z;
SELECT * FROM t1;

-- Rename multiple columns with MyIsam Engine
ALTER TABLE t2 RENAME COLUMN a TO d, RENAME COLUMN b TO e, RENAME COLUMN c to f;
SELECT * FROM t2;

-- Mix different ALTER operations with RENAME COLUMN
ALTER TABLE t1 CHANGE COLUMN x a INT, RENAME COLUMN y TO b;
ALTER TABLE t1 CHANGE COLUMN z c DOUBLE, RENAME COLUMN b to b;
ALTER TABLE t1 CHANGE COLUMN a b int, RENAME COLUMN b TO c, CHANGE COLUMN c d FLOAT;
ALTER TABLE t1 ADD COLUMN zz INT, RENAME COLUMN d TO f;
ALTER TABLE t1 DROP COLUMN zz, RENAME COLUMN c TO zz;
ALTER TABLE t1 RENAME COLUMN zz to c, DROP COLUMN f;
ALTER TABLE t1 ADD COLUMN d INT DEFAULT 5, RENAME COLUMN c TO b, DROP COLUMN b;
ALTER TABLE t1 RENAME COLUMN b TO d, RENAME COLUMN d TO b;

-- Rename with Indexes
ALTER TABLE t1 ADD KEY(b);
ALTER TABLE t1 RENAME COLUMN b TO bb;
SELECT * FROM t1;

-- Rename with Foreign keys.
CREATE TABLE t3(a int, b int, KEY(b)) ENGINE=InnoDB;
ALTER TABLE t3 ADD CONSTRAINT FOREIGN KEY(b) REFERENCES t1(bb);
ALTER TABLE t1 RENAME COLUMN bb TO b;
ALTER TABLE t3 RENAME COLUMN b TO c;

-- Different Algorithm
CREATE TABLE t4(a int);
ALTER TABLE t4 RENAME COLUMN a TO aa, ALGORITHM = INPLACE;
ALTER TABLE t4 RENAME COLUMN aa TO a, ALGORITHM = COPY;
DROP TABLE t4;

-- View, Trigger and SP
CREATE VIEW v1 AS SELECT d,e,f FROM t2;
CREATE TRIGGER trg1 BEFORE UPDATE on t2 FOR EACH ROW SET NEW.d=OLD.d + 10;
CREATE PROCEDURE sp1() INSERT INTO t2(d) VALUES(10);
ALTER TABLE t2 RENAME COLUMN d TO g;
SELECT * FROM v1;
UPDATE t2 SET f = f + 10;
DROP TRIGGER trg1;
DROP PROCEDURE sp1;

-- Generated Columns
CREATE TABLE t_gen(a INT, b DOUBLE GENERATED ALWAYS AS (SQRT(a)));
INSERT INTO t_gen(a) VALUES(4);
SELECT * FROM t_gen;
ALTER TABLE t_gen RENAME COLUMN a TO c, CHANGE COLUMN b b DOUBLE GENERATED ALWAYS AS (SQRT(c));
SELECT * FROM t_gen;
ALTER TABLE t_gen CHANGE COLUMN c a INT;
ALTER TABLE t_gen RENAME COLUMN c TO a;
DROP TABLE t_gen;

--# Histogram invalidation
CREATE TABLE foo (col1 INT);
INSERT INTO foo VALUES (1), (2);
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
ALTER TABLE foo RENAME COLUMN col1 TO col2;
SELECT schema_name, table_name, column_name,
       JSON_REMOVE(histogram, '$."last-updated"')
FROM information_schema.COLUMN_STATISTICS;
DROP TABLE foo;

--
-- Negative tests
--
SHOW CREATE TABLE t1;

-- Invalid Syntax
--error ER_PARSE_ERROR
ALTER TABLE t1 RENAME COLUMN b z;
ALTER TABLE t1 RENAME COLUMN FROM b TO z;
ALTER TABLE t1 RENAME COLUMN b TO 1;

-- Duplicate column name
--error ER_BAD_FIELD_ERROR
ALTER TABLE t1 RENAME COLUMN b TO e, RENAME COLUMN c TO e;
ALTER TABLE t1 ADD COLUMN z INT, RENAME COLUMN b TO z;

-- Multiple operation on same column
--error ER_BAD_FIELD_ERROR
ALTER TABLE t1 DROP COLUMN b, RENAME COLUMN b TO z;
ALTER TABLE t1 RENAME COLUMN b TO b, RENAME COLUMN b TO b;
ALTER TABLE t1 RENAME COLUMN b TO c3, DROP COLUMN c3;
ALTER TABLE t1 ADD COLUMN z INT, CHANGE COLUMN z y INT, DROP COLUMN y;
ALTER TABLE t1 ADD COLUMN z INT, RENAME COLUMN z TO y, DROP COLUMN y;

-- Invalid column name while renaming
--error ER_WRONG_COLUMN_NAME
ALTER TABLE t1 RENAME COLUMN b TO `nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn`;
ALTER TABLE t1 CHANGE b `nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn` int;
SELECT * FROM t1;

-- Cleanup
DROP VIEW v1;
DROP TABLE t3,t1,t2;
SET SESSION information_schema_stats_expiry=default;

CREATE TABLE t(a INT);
INSERT INTO t VALUES ();
ALTER TABLE t
ADD COLUMN b DATE GENERATED ALWAYS AS ('1999-09-09') VIRTUAL NOT NULL;
ALTER TABLE t
ADD COLUMN c DATE GENERATED ALWAYS AS ('1999-09-09') STORED NOT NULL;
ALTER TABLE t
ADD COLUMN d DATE GENERATED ALWAYS AS (NULL) VIRTUAL NOT NULL;
CREATE INDEX idx ON t(d);
ALTER TABLE t
ADD COLUMN e DATE GENERATED ALWAYS AS (NULL) STORED NOT NULL;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 10, ALGORITHM=INSTANT;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 11, ALGORITHM=INSTANT, LOCK=NONE;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 12, ALGORITHM=INSTANT, LOCK=SHARED;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 13, ALGORITHM=INSTANT, LOCK=EXCLUSIVE;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 13, ALGORITHM=INSTANT, LOCK=DEFAULT;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 14, ALGORITHM=INSTANT;
ALTER TABLE t1 ALTER COLUMN i DROP DEFAULT, ALGORITHM=INSTANT;
ALTER TABLE t1 ADD COLUMN j ENUM('a', 'b', 'c');
ALTER TABLE t1 MODIFY COLUMN j ENUM('a', 'b', 'c', 'd', 'e'), ALGORITHM=INSTANT;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INSTANT;
ALTER TABLE t2 RENAME TO t1, ALGORITHM=INPLACE;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 15, ALGORITHM=INPLACE;
ALTER TABLE t1 ALTER COLUMN i DROP DEFAULT, ALGORITHM=INPLACE;
ALTER TABLE t1 MODIFY COLUMN j ENUM('a', 'b', 'c', 'd', 'e', 'f', 'g'), ALGORITHM=INPLACE;
ALTER TABLE t1 ADD KEY(j), ALGORITHM=INSTANT;
DROP TABLE t1;
CREATE TABLE t1 (i INT, j ENUM('a', 'b'), KEY(i)) ENGINE=MyISAM;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 10, ALGORITHM=INSTANT;
ALTER TABLE t1 ALTER COLUMN i DROP DEFAULT, ALGORITHM=INSTANT;
ALTER TABLE t1 MODIFY COLUMN j ENUM('a', 'b', 'c', 'd', 'e'), ALGORITHM=INSTANT;
ALTER TABLE t1 CHANGE COLUMN i k INT, ALGORITHM=INSTANT;
ALTER TABLE t1 RENAME INDEX i TO k, ALGORITHM=INSTANT;
ALTER TABLE t1 RENAME TO t2, ALGORITHM=INSTANT;
ALTER TABLE t2 RENAME TO t1, ALGORITHM=INPLACE;
ALTER TABLE t1 ALTER COLUMN k SET DEFAULT 11, ALGORITHM=INPLACE;
ALTER TABLE t1 ALTER COLUMN k DROP DEFAULT, ALGORITHM=INPLACE;
ALTER TABLE t1 MODIFY COLUMN j ENUM('a', 'b', 'c', 'd', 'e', 'f', 'g'), ALGORITHM=INPLACE;
ALTER TABLE t1 CHANGE COLUMN k i INT, ALGORITHM=INPLACE;
ALTER TABLE t1 RENAME INDEX k TO i, ALGORITHM=INPLACE;
ALTER TABLE t1 ADD COLUMN l INT, ALGORITHM=INSTANT;
ALTER TABLE t1 ALTER COLUMN i SET DEFAULT 12, DROP COLUMN j, ALGORITHM=INSTANT;
DROP TABLE t1;

CREATE TABLE t1 (a INT) ENGINE=INNODB;
ALTER TABLE t1 CONVERT TO CHARACTER SET utf16 COLLATE utf16_turkish_ci,
DEFAULT CHARACTER SET utf16 COLLATE utf16_slovak_ci;

DROP TABLE t1;

SET SQL_MODE='';
CREATE TABLE t1 SELECT 100000000000000000000000000000000000000000000000000000000000000001 AS c1;
ALTER TABLE t1 ADD INDEX (c1);
DROP TABLE t1;
SET SQL_MODE=default;

SET @orig_sql_mode = @@sql_mode;
CREATE TABLE t1 (fld1 VARCHAR(768), KEY(fld1)) CHARSET latin1 ENGINE =InnoDB
ROW_FORMAT= COMPACT;
CREATE TABLE t2 (fld1 VARCHAR(3073), KEY(fld1)) CHARSET latin1 ENGINE= InnoDB;
CREATE TABLE t1 (fld1 VARCHAR(767), KEY(fld1)) CHARSET latin1 ENGINE=INNODB
ROW_FORMAT=COMPACT;
ALTER TABLE t1 MODIFY fld1 VARCHAR(768), ALGORITHM= INPLACE;
ALTER TABLE t1 MODIFY fld1 VARCHAR(768), ALGORITHM= COPY;
CREATE TABLE t2 (fld1 VARCHAR(3072), KEY(fld1)) CHARSET latin1 ENGINE=INNODB
ROW_FORMAT=DYNAMIC;
ALTER TABLE t2 MODIFY fld1 VARCHAR(3073), ALGORITHM= INPLACE;
ALTER TABLE t2 MODIFY fld1 VARCHAR(3073), ALGORITHM= COPY;

DROP TABLE t1, t2;

SET sql_mode= '';
CREATE TABLE t1 (fld1 VARCHAR(768), KEY(fld1)) ENGINE= InnoDB
ROW_FORMAT=COMPACT;
CREATE TABLE t2 (fld1 VARCHAR(3073), KEY(fld1)) ENGINE= InnoDB;
CREATE TABLE t3 (fld1 VARCHAR(767), KEY(fld1))ENGINE=INNODB ROW_FORMAT=COMPACT;

ALTER TABLE t3 MODIFY fld1 VARCHAR(768), ALGORITHM= INPLACE;

ALTER TABLE t3 MODIFY fld1 VARCHAR(800), ALGORITHM= COPY;
CREATE TABLE t4 (fld1 VARCHAR(3072), KEY(fld1))ENGINE=INNODB
ROW_FORMAT=DYNAMIC;

ALTER TABLE t4 MODIFY fld1 VARCHAR(3073), ALGORITHM= INPLACE;

ALTER TABLE t4 MODIFY fld1 VARCHAR(3074), ALGORITHM= COPY;
CREATE TABLE t5(fld1 VARCHAR(768) PRIMARY KEY) ENGINE= InnoDB
ROW_FORMAT=COMPACT;
CREATE TABLE t5(fld1 VARCHAR(3073), UNIQUE KEY(fld1)) ENGINE= InnoDB;

DROP TABLE t1, t2, t3, t4;

SET sql_mode= @orig_sql_mode;
CREATE TABLE t1(fld1 VARCHAR(3), KEY(fld1)) ENGINE=MYISAM;
ALTER TABLE t1 MODIFY fld1 VARCHAR(10), ALGORITHM=INPLACE;
ALTER TABLE t1 MODIFY fld1 VARCHAR(10), ALGORITHM=COPY;
CREATE TABLE t2(fld1 VARCHAR(768), KEY(fld1)) ENGINE= InnoDB ROW_FORMAT= DYNAMIC;
ALTER TABLE t2 ADD INDEX idx1(fld1(769));

SET sql_mode= '';
ALTER TABLE t2 ADD INDEX idx1(fld1(769));
DROP TABLE t1, t2;
SET sql_mode= @orig_sql_mode;


CREATE TABLE t1(fld1 INT, fld2 INT GENERATED ALWAYS AS (-fld1) VIRTUAL,
                fld3 INT GENERATED ALWAYS AS (-fld1) STORED);
ALTER TABLE t1 ALTER COLUMN fld2 SET DEFAULT -1;
ALTER TABLE t1 ALTER COLUMN fld3 SET DEFAULT -1;
ALTER TABLE t1 CHANGE fld2 fld2 INT GENERATED ALWAYS AS (-fld1) DEFAULT -1;
ALTER TABLE t1 MODIFY fld3 INT GENERATED ALWAYS AS (-fld1) STORED DEFAULT -1;

DROP TABLE t1;
SET GLOBAL max_allowed_packet=17825792;
CREATE TABLE t1 (t1_fld1 TEXT) ENGINE=InnoDB;
CREATE TABLE t2 (t2_fld1 MEDIUMTEXT) ENGINE=InnoDB;
CREATE TABLE t3 (t3_fld1 LONGTEXT) ENGINE=InnoDB;

INSERT INTO t1 VALUES (REPEAT('a',300));
INSERT INTO t2 VALUES (REPEAT('b',65680));
INSERT INTO t3 VALUES (REPEAT('c',16777300));

SELECT LENGTH(t1_fld1) FROM t1;
SELECT LENGTH(t2_fld1) FROM t2;
SELECT LENGTH(t3_fld1) FROM t3;
SET SQL_MODE='STRICT_ALL_TABLES';
ALTER TABLE t1 CHANGE `t1_fld1` `my_t1_fld1` TINYTEXT;
ALTER TABLE t2 CHANGE `t2_fld1` `my_t2_fld1` TEXT;
ALTER TABLE t3 CHANGE `t3_fld1` `my_t3_fld1` MEDIUMTEXT;
SET SQL_MODE='';

ALTER TABLE t1 CHANGE `t1_fld1` `my_t1_fld1` TINYTEXT;
ALTER TABLE t2 CHANGE `t2_fld1` `my_t2_fld1` TEXT;
ALTER TABLE t3 CHANGE `t3_fld1` `my_t3_fld1` MEDIUMTEXT;

SELECT LENGTH(my_t1_fld1) FROM t1;
SELECT LENGTH(my_t2_fld1) FROM t2;
SELECT LENGTH(my_t3_fld1) FROM t3;

-- Cleanup
--disconnect con1
--source include/wait_until_disconnected.inc

--connection default
DROP TABLE t1, t2, t3;

SET SQL_MODE=default;
SET GLOBAL max_allowed_packet=default;
CREATE TABLE t1(c1 VARCHAR(512) CHARSET SWE7);
ALTER TABLE t1 MODIFY COLUMN c1 VARCHAR(512) CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(512) CHARSET ASCII);
ALTER TABLE t1 MODIFY COLUMN c1 VARCHAR(512) CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(512) CHARSET UTF8MB4);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5));
ALTER TABLE t1 MODIFY COLUMN c1 VARCHAR(512) CHARSET BINARY,
ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN c1 VARCHAR(2048) CHARSET BINARY,
ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(512) CHARSET ASCII);
INSERT INTO t1 VALUES ('a string');
ALTER TABLE t1 MODIFY COLUMN c1 VARCHAR(512) CHARSET SWE7, ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN c1 VARCHAR(512) CHARSET UCS2, ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN c1 VARCHAR(512) CHARSET UTF8MB4,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 VARCHAR(512) CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 VARCHAR(512) CHARSET UTF8MB4,
ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(1) CHARSET UTF8MB3);
INSERT INTO t1 VALUES (0xc3a6), (0xc3b8);
ALTER TABLE t1 MODIFY COLUMN c1 CHAR(1) CHARSET UTF8MB4, ALGORITHM = INPLACE;
SELECT * FROM t1;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(31) CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 CHAR(31) CHARSET UTF8MB4, ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(85) CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 CHAR(85) CHARSET UTF8MB4, ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(64) CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 CHAR(64) CHARSET UTF8MB4, ALGORITHM = INPLACE;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(86) CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 CHAR(86) CHARSET UTF8MB4, ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 CHAR(63) CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 CHAR(63) CHARSET UTF8MB4, ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 TINYTEXT CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 TINYTEXT CHARSET UTF8MB4, ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 TEXT CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 TEXT CHARSET UTF8MB4, ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 MEDIUMTEXT CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 MEDIUMTEXT CHARSET UTF8MB4, ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 LONGTEXT CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT(0xc3a6, 0xc3b8, 0xc3a5, "text"));
ALTER TABLE t1 MODIFY COLUMN c1 LONGTEXT CHARSET UTF8MB4, ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 ENUM('a','b','c') CHARSET UTF8MB3);
INSERT INTO t1 VALUES ('a');
ALTER TABLE t1 MODIFY COLUMN c1 ENUM('a','b','c', 0xf0909080) CHARSET UTF8MB4,
ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (0xf0909080);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 ENUM(0xc3a6,0xc3b8,0xc3a5) CHARSET UTF8MB3);
ALTER TABLE t1 MODIFY COLUMN c1 ENUM(0xc3a6,0xf0909080,0xc3b8,0xc3a5)
CHARSET UTF8MB4, ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 ENUM('a', 'b','c') CHARSET ASCII);
ALTER TABLE t1 MODIFY COLUMN c1 ENUM('a','b','c') CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 ENUM('a','b','c') CHARSET SWE7);
ALTER TABLE t1 MODIFY COLUMN c1 ENUM('a','b','c') CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 ENUM('a','b','c') CHARSET UTF8MB3);
ALTER TABLE t1 MODIFY COLUMN c1 ENUM('a','b','c') CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 ENUM('a','b','c') CHARSET UTF8MB4);
ALTER TABLE t1 MODIFY COLUMN c1 ENUM('a','b','c') CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 SET('b',0xc3a6,0xc3b8,0xc3a5) CHARSET UTF8MB3);
INSERT INTO t1 VALUES (CONCAT('b,', 0xc3a6));
ALTER TABLE t1 MODIFY COLUMN c1 SET('b',0xc3a6,0xc3b8,0xc3a5,0xf0909080)
CHARSET UTF8MB4, ALGORITHM = INPLACE;
INSERT INTO t1 VALUES (CONCAT('b,', 0xf0909080, ',', 0xc3b8));
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 SET(0xc3a6,0xc3b8,0xc3a5) CHARSET UTF8MB3);
ALTER TABLE t1 MODIFY COLUMN c1 SET(0xc3a6,0xf0909080,0xc3b8,0xc3a5)
CHARSET UTF8MB4, ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 SET('a','b','c') CHARSET ASCII);
ALTER TABLE t1 MODIFY COLUMN c1 SET('a','b','c') CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 SET('a','b','c') CHARSET SWE7);
ALTER TABLE t1 MODIFY COLUMN c1 SET('a','b','c') CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 SET('a','b','c') CHARSET UTF8MB3);
ALTER TABLE t1 MODIFY COLUMN c1 SET('a','b','c') CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 SET('a','b','c') CHARSET UTF8MB4);
ALTER TABLE t1 MODIFY COLUMN c1 SET('a','b','c') CHARSET BINARY,
ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1 (a SET('a1','a2'));
INSERT INTO t1 VALUES ('a1'),('a2');
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','a3'), ALGORITHM = INPLACE;
INSERT INTO t1 VALUES ('a2,a3');
SELECT a FROM t1;
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','xx','a5'), ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2'), ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','a0','a3'), ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN a SET('a1','a2','a3','a4'), ALGORITHM = INPLACE;
INSERT INTO t1 VALUES ('a3,a4');
SELECT a FROM t1;
ALTER TABLE t1 MODIFY COLUMN a
SET('a1','a2','a3','a4','a5','a6','a7','a8','a9','a10'), ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c1 int, c2 CHAR(1) CHARSET ASCII);
INSERT INTO t1 VALUES(1,'a');
ALTER TABLE t1 ADD COLUMN c3 VARCHAR(1) CHARSET UTF8MB3 DEFAULT 'b', ALGORITHM = INSTANT;
SELECT * FROM t1;
ALTER TABLE t1 MODIFY COLUMN c3 VARCHAR(1) CHARSET UTF8MB4, ALGORITHM = INPLACE;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1(c1 int,
                c2 VARCHAR(1) CHARSET UTF8MB3,
                c3 VARCHAR(1) CHARSET UTF8MB3,
                c4 VARCHAR(2) GENERATED ALWAYS AS (CONCAT(c2,c3)) virtual);
INSERT INTO t1(c1,c2,c3) VALUES(1,'a','b');
SELECT * FROM t1;
ALTER TABLE t1
  MODIFY COLUMN c2 VARCHAR(1) CHARSET UTF8MB4,
  MODIFY COLUMN c3 VARCHAR(1) CHARSET UTF8MB4, ALGORITHM = INPLACE;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c CHAR(1) CHARSET ASCII);
INSERT INTO t1 VALUES('a');
SELECT * FROM t1;
ALTER TABLE t1 MODIFY COLUMN c CHAR(4) CHARSET BINARY, ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN c CHAR(1) CHARSET BINARY, ALGORITHM = INPLACE;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c VARCHAR(1) CHARSET ASCII UNIQUE KEY);
INSERT INTO t1 VALUES('a');
SELECT * FROM t1;
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(1) CHARSET BINARY, ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci PRIMARY KEY);
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_0900_as_ci, ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_0900_as_ci, ALGORITHM = COPY;
DROP TABLE t1;
CREATE TABLE t1(c VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci);
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_0900_as_ci, ADD UNIQUE INDEX(c), ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_0900_as_ci, ADD UNIQUE INDEX(c), ALGORITHM = COPY;
DROP TABLE t1;
CREATE TABLE t1(i INT, c VARCHAR(10) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci);
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(10) CHARSET utf8mb4 COLLATE utf8mb4_0900_as_ci, ADD INDEX idx(i, c(5)), ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(10) CHARSET utf8mb4 COLLATE utf8mb4_0900_as_ci, ADD INDEX idx(i, c(5)), ALGORITHM = COPY;
DROP TABLE t1;
CREATE TABLE t1(c VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci, UNIQUE INDEX idx(c));
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(1) CHARSET utf8mb4 COLLATE utf8mb4_0900_as_ci, DROP INDEX idx, ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c VARCHAR(1) CHARSET ASCII);
INSERT INTO t1 VALUES('a');
SELECT * FROM t1;
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(256) CHARSET BINARY, ALGORITHM = INPLACE;
ALTER TABLE t1 MODIFY COLUMN c VARCHAR(255) CHARSET BINARY, ALGORITHM = INPLACE;
DROP TABLE t1;
CREATE TABLE t1(c VARCHAR(1)) CHARSET ASCII;
INSERT INTO t1 VALUES('a');
SELECT * FROM t1;
ALTER TABLE t1 CONVERT TO CHARSET BINARY, ALGORITHM = INPLACE;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a INT,b VARCHAR(255),KEY(a))ENGINE=INNODB;
INSERT INTO t1 VALUES (100,'1A204A9228E5201A36122351DA1744AF');
INSERT INTO t1 VALUES (100,'1a204a9228e5201a36122351da1744af');
ALTER TABLE t1 MODIFY b VARCHAR(255) COLLATE UTF8MB4_BIN;
ALTER TABLE t1 ADD KEY(b);
SELECT b FROM t1 USE INDEX (b) WHERE  b='1A204A9228E5201A36122351DA1744AF';
DROP TABLE t1;

CREATE TABLE t1 (a INT,b TEXT(255),KEY(a))ENGINE=INNODB;
INSERT INTO t1 VALUES (100,'1A204A9228E5201A36122351DA1744AF');
INSERT INTO t1 VALUES (100,'1a204a9228e5201a36122351da1744af');
ALTER TABLE t1 MODIFY b TEXT(255) COLLATE UTF8MB4_BIN;
ALTER TABLE t1 ADD KEY(b(255));
SELECT b FROM t1 USE INDEX (b) WHERE  b='1A204A9228E5201A36122351DA1744AF';
DROP TABLE t1;

CREATE TABLE t1 (b INT);
ALTER TABLE t1 ADD gcol INT AS (b + 1) VIRTUAL FIRST, ADD COLUMN a INT;
DROP TABLE t1;

CREATE TABLE t1 (c1
SET('1234567890123456789a','1234567890123456789b','12345678901234567890c'));
ALTER TABLE t1 ADD c2 INT NULL AFTER c1, ALGORITHM=INPLACE;
DROP TABLE t1;

CREATE TABLE t1 (c1
SET('1234567890123456789a','1234567890123456789b','12345678901234567890cd')
DEFAULT NULL);
ALTER TABLE t1 ADD c2 INT NULL AFTER c1, ALGORITHM=INPLACE;
DROP TABLE t1;
CREATE TABLE t1 (c1 ENUM ('000', '001',
'0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'));

CREATE TABLE t1 (c1 SET ('00', '01', '02', '03', '04', '05', '06'));
ALTER TABLE t1 MODIFY COLUMN c1 SET ('00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15'), ALGORITHM=INPLACE;
DROP TABLE t1;

CREATE TABLE t1 (c1 ENUM ('000', '001', '002', '003'));
ALTER TABLE t1 MODIFY COLUMN c1 ENUM (
'000', '001', '002', '003', '004', '005', '006', '007', '008', '009', '010', '011', '012', '013', '014', '015', '016', '017', '018', '019', '020', '021', '022', '023', '024', '025', '026', '027', '028', '029', '030', '031', '032', '033', '034', '035', '036', '037', '038', '039', '040', '041', '042', '043', '044', '045', '046', '047', '048', '049', '050', '051', '052', '053', '054', '055', '056', '057', '058', '059', '060', '061', '062', '063', '064', '065', '066', '067', '068', '069', '070', '071', '072', '073', '074', '075', '076', '077', '078', '079', '080', '081', '082', '083', '084', '085', '086', '087', '088', '089', '090', '091', '092', '093', '094', '095', '096', '097', '098', '099', '100', '101', '102', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '113', '114', '115', '116', '117', '118', '119', '120', '121', '122', '123', '124', '125', '126', '127', '128', '129', '130', '131', '132', '133', '134', '135', '136', '137', '138', '139', '140', '141', '142', '143', '144', '145', '146', '147', '148', '149', '150', '151', '152', '153', '154', '155', '156', '157', '158', '159', '160', '161', '162', '163', '164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175', '176', '177', '178', '179', '180', '181', '182', '183', '184', '185', '186', '187', '188', '189', '190', '191', '192', '193', '194', '195', '196', '197', '198', '199', '200', '201', '202', '203', '204', '205', '206', '207', '208', '209', '210', '211', '212', '213', '214', '215', '216', '217', '218', '219', '220', '221', '222', '223', '224', '225', '226', '227', '228', '229', '230', '231', '232', '233', '234', '235', '236', '237', '238', '239', '240', '241', '242', '243', '244', '245', '246', '247', '248', '249', '250', '251', '252', '253', '254', '255', '256'), ALGORITHM=INPLACE;
DROP TABLE t1;
ALTER TABLE z ADD b INT AS (EXISTS((SELECT 1 UNION DISTINCT SELECT 2) LIMIT 3));
SET TIMESTAMP=1558818549;
CREATE TABLE t1 (i INT PRIMARY KEY, no_default DATETIME);
ALTER TABLE t1 ADD alter_default DATETIME DEFAULT (now());
CREATE TABLE t2(i INT, alter_date DATETIME);
INSERT INTO t2 VALUES (0, now()), (1, now()), (2, now());
SET TIMESTAMP=1558818554;
INSERT INTO t1 (i, no_default) VALUES (0, now()), (1, now()), (2, now());
SELECT (t1.no_default > t2.alter_date) AS no_default_newer_than_alter,
(t1.alter_default > t2.alter_date) AS alter_default_newer_than_alter FROM t1
NATURAL JOIN t2;

DROP TABLE t2;
DROP TABLE t1;
SET TIMESTAMP=1558818549;
CREATE TABLE t1 (i INT, no_default DATETIME, create_default DATETIME DEFAULT (now()) );
ALTER TABLE t1 ADD alter_default DATETIME DEFAULT (now());
CREATE TABLE t2(i INT, alter_date DATETIME);
INSERT INTO t2 VALUES (0, now()), (1, now()), (2, now());
SET TIMESTAMP=1558818554;
INSERT INTO t1 (i, no_default) VALUES (0, now()), (1, now()), (2, now());
SELECT (no_default > alter_date) AS no_default_newer_than_alter,
(create_default > alter_date) AS create_default_newer_than_alter,
(alter_default > alter_date) AS alter_default_newer_than_alter FROM t1 NATURAL
JOIN t2;
DROP TABLE t2, t1;
SET TIMESTAMP=default;
CREATE TABLE t1(a VARBINARY(9223372036854775806) SECONDARY_ENGINE_ATTRIBUTE '');
ALTER TABLE t1 ADD COLUMN b VARBINARY(9223372036854775806)
SECONDARY_ENGINE_ATTRIBUTE '';

CREATE TABLE t1(a INT);
ALTER TABLE t1 ALTER COLUMN a SET DEFAULT TRUE;
DROP TABLE t1;

CREATE TABLE t1(a SET('a') CHARACTER SET BINARY);
ALTER TABLE t1 ALTER COLUMN a SET DEFAULT TRUE;
DROP TABLE t1;

CREATE TABLE t1(a INT);
ALTER TABLE t1 MODIFY COLUMN a DECIMAL DEFAULT '4648-04-10';
DROP TABLE t1;

CREATE TABLE t1 (
  c1 VARCHAR(10) COLLATE utf8mb4_bin DEFAULT NULL
) COLLATE=utf8mb4_bin PARTITION BY KEY (c1) PARTITIONS 3;

INSERT INTO t1 VALUES('a');
SELECT partition_name, table_rows FROM
information_schema.partitions WHERE table_name = 't1';
ALTER TABLE t1 MODIFY c1 VARCHAR(10) CHARSET utf8mb4, ALGORITHM=INPLACE;

ALTER TABLE t1 MODIFY c1 VARCHAR(10) CHARSET utf8mb4;

INSERT INTO t1 VALUES('a');
SELECT partition_name, table_rows FROM
information_schema.partitions WHERE table_name = 't1';

SELECT * FROM t1 PARTITION(p2);
SELECT * FROM t1 PARTITION(p1);
CREATE TABLE t2(c1 VARCHAR(10)) COLLATE=utf8mb4_bin;
ALTER TABLE t1 MODIFY c1 VARCHAR(10) CHARSET utf8mb4, ALGORITHM=INPLACE;
CREATE TABLE t3(c1 VARCHAR(10), c2 VARCHAR(10) COLLATE utf8mb4_bin) PARTITION BY KEY(c1) PARTITIONS 3;
ALTER TABLE t3 MODIFY c2 VARCHAR(10) CHARSET utf8mb4, ALGORITHM=INPLACE;
DROP TABLE t3;
DROP TABLE t2;
DROP TABLE t1;
