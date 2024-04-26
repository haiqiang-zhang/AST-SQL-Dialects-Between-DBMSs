
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';

create table t1 (bandID MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY, payoutID SMALLINT UNSIGNED NOT NULL) engine=myisam;
insert into t1 (bandID,payoutID) VALUES (1,6),(2,6),(3,4),(4,9),(5,10),(6,1),(7,12),(8,12);
alter table t1 add column new_col int, order by payoutid,bandid;
select * from t1;
alter table t1 order by bandid,payoutid;
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
-- BUG 12207 alter table ... discard table space on MyISAM table causes ERROR 2013 (HY000)
--
-- Some platforms (Mac OS X, Windows) will send the error message using small letters.
CREATE TABLE T12207(a int) engine=MyISAM;
ALTER TABLE T12207 DISCARD TABLESPACE;
DROP TABLE T12207;

--
-- Disable/Enable keys supported by Myisam only
-- Bug #24395: ALTER TABLE DISABLE KEYS doesn't work when modifying the table
--
-- This problem happens if the data change is compatible.
-- Changing to the same type is compatible for example.
--
--disable_warnings
drop table if exists t1;
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
--disable_warnings
DROP TABLE IF EXISTS bug24219;
DROP TABLE IF EXISTS bug24219_2;

CREATE TABLE bug24219 (a INT, INDEX(a)) ENGINE=MyISAM;

ALTER TABLE bug24219 RENAME TO bug24219_2, DISABLE KEYS;

DROP TABLE bug24219_2;

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
-- Bug#6073 "ALTER table minor glich": ALTER TABLE complains that an index
-- without # prefix is not allowed for TEXT columns, while index
-- is defined with prefix.
--
create table t1 (t varchar(255) default null, key t (t(80)))
engine=myisam default charset=latin1;
alter table t1 change t t text;
drop table t1;

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
-- Bug#43508: Renaming timestamp or date column triggers table copy
--

CREATE TABLE t1 (f1 TIMESTAMP NULL DEFAULT NULL,
                 f2 INT(11) DEFAULT NULL) ENGINE=MYISAM DEFAULT CHARSET=utf8mb3;

INSERT INTO t1 VALUES (NULL, NULL), ("2009-10-09 11:46:19", 2);
ALTER TABLE t1 CHANGE COLUMN f1 f1_no_real_change TIMESTAMP NULL DEFAULT NULL;
DROP TABLE t1;
create table t1 (i int, j int) engine=myisam;
insert into t1 value (1, 2);
select * from t1;
alter table t1 modify column j int first;
select * from t1;
alter table t1 drop column i, add column k int default 0;
select * from t1;
drop table t1;
DROP TABLE IF EXISTS t1;

CREATE TEMPORARY TABLE t1 (i int) ENGINE=MyISAM;
ALTER TABLE t1 DISCARD TABLESPACE;

DROP TABLE t1;
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

CREATE TABLE m1(a INT PRIMARY KEY, b INT) engine=MyISAM;
INSERT INTO m1 VALUES (1,1), (2,2);
ALTER TABLE m1 ENABLE KEYS;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= DEFAULT;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= COPY;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= INPLACE;

ALTER TABLE m1 ENABLE KEYS, LOCK= DEFAULT;
ALTER TABLE m1 ENABLE KEYS, LOCK= NONE;
ALTER TABLE m1 ENABLE KEYS, LOCK= SHARED;
ALTER TABLE m1 ENABLE KEYS, LOCK= EXCLUSIVE;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= INPLACE, LOCK= NONE;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= INPLACE, LOCK= SHARED;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= INPLACE, LOCK= EXCLUSIVE;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= COPY, LOCK= NONE;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= COPY, LOCK= SHARED;
ALTER TABLE m1 ENABLE KEYS, ALGORITHM= COPY, LOCK= EXCLUSIVE;

DROP TABLE m1;

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

CREATE TABLE tm1(a INT NOT NULL, b INT, c INT) engine=MyISAM;
CREATE TABLE tm2(a INT PRIMARY KEY AUTO_INCREMENT, b INT, c INT) engine=MyISAM;
INSERT INTO tm1 VALUES (1,1,1), (2,2,2);
INSERT INTO tm2 VALUES (1,1,1), (2,2,2);
ALTER TABLE tm1;

ALTER TABLE tm1 ADD COLUMN d VARCHAR(200);
ALTER TABLE tm1 ADD COLUMN d2 VARCHAR(200);
ALTER TABLE tm1 ADD COLUMN e ENUM('a', 'b') FIRST;
ALTER TABLE tm1 ADD COLUMN f INT AFTER a;
ALTER TABLE tm1 ADD INDEX im1(b);
ALTER TABLE tm1 ADD UNIQUE INDEX im2 (c);
ALTER TABLE tm1 ADD FULLTEXT INDEX im3 (d);
ALTER TABLE tm1 ADD FULLTEXT INDEX im4 (d2);

-- Bug#14140038 INCONSISTENT HANDLING OF FULLTEXT INDEXES IN ALTER TABLE
ALTER TABLE tm1 ADD PRIMARY KEY(a);
ALTER TABLE tm1 DROP INDEX im3;
ALTER TABLE tm1 DROP COLUMN d2;
 
ALTER TABLE tm1 ADD CONSTRAINT fm1 FOREIGN KEY (b) REFERENCES tm2(a);
ALTER TABLE tm1 ALTER COLUMN b SET DEFAULT 1;
ALTER TABLE tm1 ALTER COLUMN b DROP DEFAULT;

-- This will set both ALTER_COLUMN_NAME and COLUMN_DEFAULT_VALUE
ALTER TABLE tm1 CHANGE COLUMN f g INT;
ALTER TABLE tm1 CHANGE COLUMN g h VARCHAR(20);
ALTER TABLE tm1 MODIFY COLUMN e ENUM('a', 'b', 'c');
ALTER TABLE tm1 MODIFY COLUMN e INT;

-- This will set both ALTER_COLUMN_ORDER and COLUMN_DEFAULT_VALUE
ALTER TABLE tm1 MODIFY COLUMN e INT AFTER h;
ALTER TABLE tm1 MODIFY COLUMN e INT FIRST;

-- This will set both ALTER_COLUMN_NOT_NULLABLE and COLUMN_DEFAULT_VALUE
ALTER TABLE tm1 MODIFY COLUMN c INT NOT NULL;

-- This will set both ALTER_COLUMN_NULLABLE and COLUMN_DEFAULT_VALUE
ALTER TABLE tm1 MODIFY COLUMN c INT NULL;

-- This will set both ALTER_COLUMN_EQUAL_PACK_LENGTH and COLUMN_DEFAULT_VALUE
ALTER TABLE tm1 MODIFY COLUMN h VARCHAR(30);
ALTER TABLE tm1 MODIFY COLUMN h VARCHAR(30) AFTER d;

ALTER TABLE tm1 DROP COLUMN h;
ALTER TABLE tm1 DROP INDEX im2;
ALTER TABLE tm1 DROP PRIMARY KEY;
ALTER TABLE tm1 DROP FOREIGN KEY fm1;
ALTER TABLE tm1 RENAME TO tm3;
ALTER TABLE tm3 RENAME TO tm1;
ALTER TABLE tm1 ORDER BY b;
ALTER TABLE tm1 CONVERT TO CHARACTER SET utf16;
ALTER TABLE tm1 DEFAULT CHARACTER SET utf8mb3;
ALTER TABLE tm1 FORCE;
ALTER TABLE tm1 AUTO_INCREMENT 3;
ALTER TABLE tm1 AVG_ROW_LENGTH 10;
ALTER TABLE tm1 CHECKSUM 1;
ALTER TABLE tm1 COMMENT 'test';
ALTER TABLE tm1 MAX_ROWS 100;
ALTER TABLE tm1 MIN_ROWS 1;
ALTER TABLE tm1 PACK_KEYS 1;
DROP TABLE tm1,tm2;

CREATE TABLE tm1(i INT DEFAULT 1) engine=MyISAM;
ALTER TABLE tm1 ADD INDEX ii1(i), ALTER COLUMN i DROP DEFAULT;
DROP TABLE tm1;

CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'test') ENGINE= MyISAM;
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1), ALGORITHM=INPLACE;
DROP TABLE t1;

-- Alter the comment, but keep the same comment length
CREATE TABLE t1(fld1 int, key key1(fld1) COMMENT 'old comment') ENGINE=MyISAM;
ALTER TABLE t1 DROP INDEX key1, ADD INDEX key1(fld1) COMMENT 'new comment',
ALGORITHM= INPLACE;
DROP TABLE t1;

CREATE TABLE t1(fld1 varchar(200), FULLTEXT(fld1)) ENGINE=MyISAM;
INSERT INTO t1 VALUES('ABCD');
ALTER TABLE t1 DROP INDEX fld1, ADD FULLTEXT INDEX fld1(fld1);
ALTER TABLE t1 ALGORITHM=INPLACE, DROP INDEX fld1,
ADD FULLTEXT INDEX fld1(fld1);
DROP TABLE t1;

CREATE TABLE t1 (a INT PRIMARY KEY, b INT,
                 FOREIGN KEY (b) REFERENCES t1(a)) ENGINE= MyISAM;
ALTER TABLE t1 RENAME INDEX b TO w, ADD FOREIGN KEY (b) REFERENCES t1(a);
DROP TABLE t1;
CREATE TABLE t2(a INT, b VARCHAR(30), c FLOAT) ENGINE=MyIsam;
INSERT INTO t2 VALUES(1,'abcd',1.234);

-- Rename multiple columns with MyIsam Engine
ALTER TABLE t2 RENAME COLUMN a TO d, RENAME COLUMN b TO e, RENAME COLUMN c to f;
SELECT * FROM t2;

-- View, Trigger and SP
CREATE VIEW v1 AS SELECT d,e,f FROM t2;
CREATE TRIGGER trg1 BEFORE UPDATE on t2 FOR EACH ROW SET NEW.d=OLD.d + 10;
CREATE PROCEDURE sp1() INSERT INTO t2(d) VALUES(10);
ALTER TABLE t2 RENAME COLUMN d TO g;
SELECT * FROM v1;
UPDATE t2 SET f = f + 10;
DROP TRIGGER trg1;
DROP PROCEDURE sp1;
DROP TABLE t2;
DROP VIEW v1;
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
CREATE TABLE t1(fld1 VARCHAR(3), KEY(fld1)) ENGINE=MYISAM;
ALTER TABLE t1 MODIFY fld1 VARCHAR(10), ALGORITHM=INPLACE;
ALTER TABLE t1 MODIFY fld1 VARCHAR(10), ALGORITHM=COPY;
DROP TABLE t1;
CREATE TABLE t1(fld1 VARCHAR(3), KEY(fld1)) ENGINE=MYISAM;
ALTER TABLE t1 MODIFY fld1 VARCHAR(10), ALGORITHM=INPLACE;
ALTER TABLE t1 MODIFY fld1 VARCHAR(10), ALGORITHM=COPY;
DROP TABLE t1;
