create table t1 (f1 int not null, f2 int not null, f3 int not null, f4 int not null, primary key(f1,f2,f3,f4)) engine=myisam;
insert into t1 values (1,1,1,0),(1,1,2,0),(1,1,3,0),(1,2,1,0),(1,2,2,0),(1,2,3,0),(1,3,1,0),(1,3,2,0),(1,3,3,0),(1,1,1,1),(1,1,2,1),(1,1,3,1),(1,2,1,1),(1,2,2,1),(1,2,3,1),(1,3,1,1),(1,3,2,1),(1,3,3,1);
drop table t1;
create table t1 (a int not null, b VARCHAR(10), INDEX (b) ) AVG_ROW_LENGTH=10 CHECKSUM=1 COMMENT="test" ENGINE=MYISAM MIN_ROWS=10 MAX_ROWS=100 PACK_KEYS=1 DELAY_KEY_WRITE=1 ROW_FORMAT=fixed;
alter table t1 MAX_ROWS=200 ROW_FORMAT=dynamic PACK_KEYS=0;
ALTER TABLE t1 AVG_ROW_LENGTH=0 CHECKSUM=0 COMMENT="" MIN_ROWS=0 MAX_ROWS=0 PACK_KEYS=DEFAULT DELAY_KEY_WRITE=0 ROW_FORMAT=default;
drop table t1;
CREATE TABLE t1 (i int, KEY (i)) ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY USING HASH (i)) ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY USING BTREE (i)) ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY (i)) ENGINE=MyISAM;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY USING BTREE (i)) ENGINE=MyISAM;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY (i)) ENGINE=MyISAM;
ALTER TABLE t1 ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY USING BTREE (i)) ENGINE=MyISAM;
ALTER TABLE t1 ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE `tab1` (
  `c1` int(11) default NULL,
  `c2` char(20) default NULL,
  `c3` char(20) default NULL,
  KEY `k1` (`c2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO tab1 values(1, "hello", "world");
INSERT INTO tab1 values(2, "hello2", "world2");
INSERT INTO tab1 values(3, "hello3", "world3");
