CREATE TABLE t1 (
   word VARCHAR(64),
   bar INT(11) default 0,
   PRIMARY KEY (word))
   ENGINE=MyISAM
   CHARSET utf32
   COLLATE utf32_general_ci;
INSERT INTO t1 (word) VALUES ("aar");
INSERT INTO t1 (word) VALUES ("a");
INSERT INTO t1 (word) VALUES ("aardvar");
INSERT INTO t1 (word) VALUES ("aardvark");
INSERT INTO t1 (word) VALUES ("aardvara");
INSERT INTO t1 (word) VALUES ("aardvarz");
SELECT * FROM t1 ORDER BY word;
SELECT word FROM t1 ORDER by word;
DROP TABLE t1;
CREATE TABLE t1 (
   word VARCHAR(64) ,
   PRIMARY KEY (word))
   ENGINE=MyISAM
   CHARSET utf32
   COLLATE utf32_general_ci;
INSERT INTO t1 (word) VALUES ("aar");
INSERT INTO t1 (word) VALUES ("a");
INSERT INTO t1 (word) VALUES ("aardvar");
INSERT INTO t1 (word) VALUES ("aardvark");
INSERT INTO t1 (word) VALUES ("aardvara");
INSERT INTO t1 (word) VALUES ("aardvarz");
SELECT * FROM t1 ORDER BY word;
DROP TABLE t1;
CREATE TABLE t1 (
   word TEXT,
   bar INT(11) AUTO_INCREMENT,
   PRIMARY KEY (bar))
   ENGINE=MyISAM
   CHARSET utf32
   COLLATE utf32_general_ci;
INSERT INTO t1 (word) VALUES ("aar");
INSERT INTO t1 (word) VALUES ("a" );
INSERT INTO t1 (word) VALUES ("aardvar");
INSERT INTO t1 (word) VALUES ("aardvark");
INSERT INTO t1 (word) VALUES ("aardvara");
INSERT INTO t1 (word) VALUES ("aardvarz");
SELECT * FROM t1 ORDER BY word;
SELECT word FROM t1 ORDER BY word;
DROP TABLE t1;
CREATE TABLE t1 (
  a varchar(250) NOT NULL default '',
  KEY a (a)
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE utf32_general_ci;
insert into t1 values (0x803d);
insert into t1 values (0x005b);
select hex(a) from t1;
drop table t1;
create table t1 (
  a char(10) character set utf32 not null,
  index a (a)
) engine=myisam;
insert into t1 values (repeat(0x0000201f, 10));
insert into t1 values (repeat(0x00002020, 10));
insert into t1 values (repeat(0x00002021, 10));
alter table t1 drop index a;
drop table t1;
create table t1 (a varchar(250) character set utf32 primary key) engine=MyISAM;
drop table t1;
CREATE TABLE t1 (
 b char(250) CHARACTER SET utf32,
 key (b)
) ENGINE=MYISAM;
INSERT INTO t1 VALUES ('d'),('f');
SELECT * FROM t1 WHERE b BETWEEN 'a' AND 'z';
DROP TABLE t1;
