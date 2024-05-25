drop table if exists t1, t2;
CREATE TABLE t1 (fld1 INT PRIMARY KEY) ENGINE= INNODB PARTITION BY HASH(fld1)
PARTITIONS 5;
DROP TABLE t1;
CREATE TABLE t1
(a INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
 b VARCHAR(200),
 c TEXT)
ENGINE=InnoDB
PARTITION BY HASH(a) PARTITIONS 1;
DROP TABLE t1;
CREATE TABLE t1 (
  i INT
)
ENGINE=InnoDB
PARTITION BY RANGE (i)
(PARTITION p3 VALUES LESS THAN (3),
 PARTITION p5 VALUES LESS THAN (5),
 PARTITION pMax VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6);
ALTER TABLE t1 CHECKSUM = 1;
DROP TABLE t1;
CREATE TABLE t1 (
  i INT
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6);
ALTER TABLE t1 CHECKSUM = 1;
DROP TABLE t1;
CREATE TABLE t1
(a INT,
 b varchar(64),
 PRIMARY KEY (a),
 KEY (b))
ENGINE = InnoDB
PARTITION BY RANGE (a)
SUBPARTITION BY HASH (a) SUBPARTITIONS 10
(PARTITION pNeg VALUES LESS THAN (0),
 PARTITION p0 VALUES LESS THAN (1000),
 PARTITION pMAX VALUES LESS THAN MAXVALUE);
INSERT INTO t1 VALUES (-1, 'Only negative pk value');
INSERT INTO t1 VALUES (0, 'Mod Zero'), (1, 'One'), (2, 'Two'), (3, 'Three'),
(10, 'Zero'), (11, 'Mod One'), (12, 'Mod Two'), (13, 'Mod Three'),
(20, '0'), (21, '1'), (22, '2'), (23, '3'),
(4, '4'), (5, '5'), (6, '6'), (7, '7'), (8, '8'), (9, '9');
INSERT INTO t1 SELECT a + 30, b FROM t1 WHERE a >= 0;
DROP TABLE t1;
CREATE TABLE t1 (a INT, KEY(a))
ENGINE = InnoDB
PARTITION BY KEY (a) PARTITIONS 1;
SELECT 1 FROM t1 WHERE a > (SELECT LAST_INSERT_ID() FROM t1 LIMIT 0)
ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1
(c1 bigint(20) unsigned NOT NULL AUTO_INCREMENT,
 c2 varchar(40) not null default '',
 c3 datetime not  NULL,
 PRIMARY KEY (c1,c3),
 KEY partidx(c3))
ENGINE=InnoDB
PARTITION BY RANGE (TO_DAYS(c3))
(PARTITION p200912 VALUES LESS THAN (to_days('2010-01-01')),
 PARTITION p201103 VALUES LESS THAN (to_days('2011-04-01')),
 PARTITION p201912 VALUES LESS THAN MAXVALUE);
insert into t1(c2,c3) values ("Test row",'2010-01-01 00:00:00');
SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 't1' AND TABLE_SCHEMA = 'test';
SELECT count(*) FROM t1 p where c3 in
(SELECT c3 FROM t1 t WHERE t.c3 < TIMESTAMP'2011-04-26 19:19:44'
 AND t.c3 > TIMESTAMP'2011-04-26 19:18:44');
DROP TABLE t1;
CREATE TABLE t1
(user_num BIGINT,
 hours SMALLINT,
 KEY user_num (user_num))
ENGINE = InnoDB   
PARTITION BY RANGE COLUMNS (hours)
(PARTITION hour_003 VALUES LESS THAN (3),
 PARTITION hour_004 VALUES LESS THAN (4),
 PARTITION hour_005 VALUES LESS THAN (5),
 PARTITION hour_last VALUES LESS THAN (MAXVALUE));
INSERT INTO t1 VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);
SELECT COUNT(*) FROM t1;
ALTER TABLE t1
REORGANIZE PARTITION hour_003, hour_004 INTO
(PARTITION oldest VALUES LESS THAN (4));
SELECT COUNT(*) = 1
FROM information_schema.processlist
WHERE INFO like 'ALTER TABLE t1%REORGANIZE PARTITION hour_003, hour_004%'
AND STATE = 'Waiting for table metadata lock';
SELECT COUNT(*) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
    id INT AUTO_INCREMENT NOT NULL,
    name CHAR(50) NOT NULL,
    myDate DATE NOT NULL,
    PRIMARY KEY (id, myDate),
    INDEX idx_date (myDate)
    ) ENGINE=InnoDB
PARTITION BY RANGE ( TO_DAYS(myDate) ) (
    PARTITION p0 VALUES LESS THAN (734028),
    PARTITION p1 VALUES LESS THAN (734029),
    PARTITION p2 VALUES LESS THAN (734030),
    PARTITION p3 VALUES LESS THAN MAXVALUE
    );
INSERT INTO t1 VALUES 
(NULL, 'Lachlan', '2009-09-13'),
  (NULL, 'Clint', '2009-09-13'),
  (NULL, 'John', '2009-09-14'),
  (NULL, 'Dave', '2009-09-14'),
  (NULL, 'Jeremy', '2009-09-15'),
  (NULL, 'Scott', '2009-09-15'),
  (NULL, 'Jeff', '2009-09-16'),
  (NULL, 'Joe', '2009-09-16');
SELECT * FROM t1 FOR UPDATE;
UPDATE t1 SET name = 'Mattias' WHERE id = 7;
SELECT * FROM t1 WHERE id = 7;
ALTER TABLE t1 DROP PARTITION p3;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT NOT NULL)
ENGINE = InnoDB
PARTITION BY RANGE(a)
(PARTITION p10 VALUES LESS THAN (10),
 PARTITION p30 VALUES LESS THAN (30),
 PARTITION p50 VALUES LESS THAN (50),
 PARTITION p70 VALUES LESS THAN (70),
 PARTITION p90 VALUES LESS THAN (90));
INSERT INTO t1 VALUES (10),(30),(50);
INSERT INTO t1 VALUES (70);
INSERT INTO t1 VALUES (80);
INSERT INTO t1 VALUES (89);
DROP TABLE t1;
CREATE TABLE t2 (
  id INT,
  PRIMARY KEY (id)
) ENGINE=InnoDB;
CREATE TABLE t1 (
  id INT NOT NULL AUTO_INCREMENT,
  parent_id INT DEFAULT NULL,
  PRIMARY KEY (id),
  KEY parent_id (parent_id)
) ENGINE=InnoDB;
ALTER TABLE t1 PARTITION BY HASH (id) PARTITIONS 1;
ALTER TABLE t1 PARTITION BY HASH (id) PARTITIONS 2;
DROP TABLE t1, t2;
create table t1 (a varchar(5), b int signed, c varchar(10), d datetime)
partition by range columns(b,c)
subpartition by hash(to_seconds(d))
( partition p0 values less than (2, 'b'),
  partition p1 values less than (4, 'd'),
  partition p2 values less than (10, 'za'));
insert into t1 values ('a', 3, 'w', '2001-10-27 04:34:00');
insert into t1 values ('r', 7, 'w', '2001-10-27 05:34:00');
insert into t1 values ('g', 10, 'w', '2001-10-27 06:34:00');
update t1 set a = 'c' where a > 'f';
drop table t1;
create table t1 (a varchar(5))
engine=innodb
partition by range columns(a)
( partition p0 values less than ('m'),
  partition p1 values less than ('za'));
insert into t1 values  ('j');
update t1 set a = 'z' where (a >= 'j');
drop table t1;
create table t1 (a int not null,
                 b datetime not null,
                 primary key (a,b))
engine=innodb
partition by range (to_days(b))
subpartition by hash (a)
subpartitions 2
( partition p0 values less than (to_days('2009-01-01')),
  partition p1 values less than (to_days('2009-02-01')),
  partition p2 values less than (to_days('2009-03-01')),
  partition p3 values less than maxvalue);
alter table t1 reorganize partition p1,p2 into
( partition p2 values less than (to_days('2009-03-01')));
drop table t1;
CREATE TABLE t1 (id INT PRIMARY KEY, data INT) ENGINE = InnoDB 
PARTITION BY RANGE(id) ( 
 PARTITION p0 VALUES LESS THAN (5), 
 PARTITION p1 VALUES LESS THAN (10), 
 PARTITION p2 VALUES LESS THAN MAXVALUE 
);
INSERT INTO t1 VALUES (1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8),
                      (9,9), (10,10), (11,11);
UPDATE t1 SET DATA = data*2 WHERE id = 3;
UPDATE t1 SET data = data*2 WHERE data = 2;
DROP TABLE t1;
CREATE TABLE t1 (
  a INT,
  b INT,
  PRIMARY KEY (a),
  INDEX (b))
ENGINE InnoDB
PARTITION BY HASH(a)
PARTITIONS 3;
INSERT INTO t1 VALUES (0,0),(4,0),(2,0);
SELECT a FROM t1 WHERE b = 0 ORDER BY a ASC;
SELECT a FROM t1 WHERE b = 0 ORDER BY a DESC;
ALTER TABLE t1 DROP INDEX b;
SELECT a FROM t1 WHERE b = 0 ORDER BY a ASC;
SELECT a FROM t1 WHERE b = 0 ORDER BY a DESC;
DROP TABLE t1;
CREATE TABLE t1 (
  a VARCHAR(600),
  b VARCHAR(600),
  PRIMARY KEY (a),
  INDEX (b))
ENGINE InnoDB
PARTITION BY KEY(a)
PARTITIONS 3;
INSERT INTO t1 VALUES (concat(repeat('MySQL',100),'1'),repeat('0',257));
INSERT INTO t1 VALUES (concat(repeat('MySQL',100),'3'),repeat('0',257));
INSERT INTO t1 VALUES (concat(repeat('MySQL',100),'2'),repeat('0',257));
SELECT right(a,1) FROM t1 WHERE b = repeat('0',257) ORDER BY a ASC;
SELECT right(a,1) FROM t1 WHERE b = repeat('0',257) ORDER BY a DESC;
ALTER TABLE t1 DROP INDEX b;
SELECT right(a,1) FROM t1 WHERE b = repeat('0',257) ORDER BY a ASC;
SELECT right(a,1) FROM t1 WHERE b = repeat('0',257) ORDER BY a DESC;
DROP TABLE t1;
create table t1 (a int) engine=innodb partition by hash(a);
drop table t1;
create table t1 (a int)
engine = innodb
partition by key (a);
insert into t1 values (0), (1), (2), (3);
drop table t1;
create table t1 (a int auto_increment primary key)
engine = innodb
partition by key (a);
insert into t1 values (NULL), (NULL), (NULL), (NULL);
insert into t1 values (NULL), (NULL), (NULL), (NULL);
drop table t1;
create table t1 (a int)
partition by key (a)
(partition p1 engine = innodb);
alter table t1 rebuild partition p1;
alter table t1 rebuild partition p1;
alter table t1 rebuild partition p1;
alter table t1 rebuild partition p1;
alter table t1 rebuild partition p1;
alter table t1 rebuild partition p1;
alter table t1 rebuild partition p1;
drop table t1;
create table t1 (a date)
engine = innodb
partition by range (year(a))
(partition p0 values less than (2006),
 partition p1 values less than (2007));
drop table t1;
create table t1 (a int)
engine = innodb
partition by list (a)
(partition p0 values in (0));
drop table t1;
create table t1
(
  id int unsigned auto_increment,
  time datetime not null,
  first_name varchar(40),
  last_name varchar(50),
  primary key (id, time),
  index first_index (first_name),
  index last_index (last_name)	
) engine=Innodb partition by range (to_days(time)) (
  partition p1 values less than (to_days('2007-02-07')),
  partition p2 values less than (to_days('2007-02-08')),
  partition p3 values less than MAXVALUE
);
insert into t1 (time, first_name, last_name) values ('2007-02-07', 'Q', 'Robert'),
('2007-02-07', 'Mark', 'Nate'), ('2007-02-07', 'Nate', 'Oscar'),
('2007-02-07', 'Zack', 'Alice'), ('2007-02-07', 'Jack', 'Kathy'),
('2007-02-06', 'Alice', 'Alice'), ('2007-02-06', 'Brian', 'Charles'),
('2007-02-06', 'Charles', 'David'), ('2007-02-06', 'David', 'Eric'),
('2007-02-07', 'Hector', 'Isaac'), ('2007-02-07', 'Oscar', 'Patricia'),
('2007-02-07', 'Patricia', 'Q'), ('2007-02-07', 'X', 'Yuri'),
('2007-02-07', 'Robert', 'Shawn'), ('2007-02-07', 'Kathy', 'Lois'),
('2007-02-07', 'Eric', 'Francis'), ('2007-02-06', 'Shawn', 'Theron'),
('2007-02-06', 'U', 'Vincent'), ('2007-02-06', 'Francis', 'George'),
('2007-02-06', 'George', 'Hector'), ('2007-02-06', 'Vincent', 'Walter'),
('2007-02-06', 'Walter', 'X'), ('2007-02-07', 'Lois', 'Mark'),
('2007-02-07', 'Yuri', 'Zack'), ('2007-02-07', 'Isaac', 'Jack'),
('2007-02-07', 'Sharon', 'Mark'), ('2007-02-07', 'Michael', 'Michelle'),
('2007-02-07', 'Derick', 'Nathan'), ('2007-02-07', 'Peter', 'Xavier'),
('2007-02-07', 'Fred', 'Harold'), ('2007-02-07', 'Katherine', 'Lisa'),
('2007-02-07', 'Tom', 'Rina'), ('2007-02-07', 'Jerry', 'Victor'),
('2007-02-07', 'Alexander', 'Terry'), ('2007-02-07', 'Justin', 'John'),
('2007-02-07', 'Greg', 'Ernest'), ('2007-02-07', 'Robert', 'Q'),
('2007-02-07', 'Nate', 'Mark'), ('2007-02-07', 'Oscar', 'Nate'),
('2007-02-07', 'Alice', 'Zack'), ('2007-02-07', 'Kathy', 'Jack'),
('2007-02-06', 'Alice', 'Alice'), ('2007-02-06', 'Charles', 'Brian'),
('2007-02-06', 'David', 'Charles'), ('2007-02-06', 'Eric', 'David'),
('2007-02-07', 'Isaac', 'Hector'), ('2007-02-07', 'Patricia', 'Oscar'),
('2007-02-07', 'Q', 'Patricia'), ('2007-02-07', 'Yuri', 'X'),
('2007-02-07', 'Shawn', 'Robert'), ('2007-02-07', 'Lois', 'Kathy'),
('2007-02-07', 'Francis', 'Eric'), ('2007-02-06', 'Theron', 'Shawn'),
('2007-02-06', 'Vincent', 'U'), ('2007-02-06', 'George', 'Francis'),
('2007-02-06', 'Hector', 'George'), ('2007-02-06', 'Walter', 'Vincent'),
('2007-02-06', 'X', 'Walter'), ('2007-02-07', 'Mark', 'Lois'),
('2007-02-07', 'Zack', 'Yuri'), ('2007-02-07', 'Jack', 'Isaac'),
('2007-02-07', 'Mark', 'Sharon'), ('2007-02-07', 'Michelle', 'Michael'),
('2007-02-07', 'Nathan', 'Derick'), ('2007-02-07', 'Xavier', 'Peter'),
('2007-02-07', 'Harold', 'Fred'), ('2007-02-07', 'Lisa', 'Katherine'),
('2007-02-07', 'Rina', 'Tom'), ('2007-02-07', 'Victor', 'Jerry'),
('2007-02-07', 'Terry', 'Alexander'), ('2007-02-07', 'John', 'Justin'),
('2007-02-07', 'Ernest', 'Greg');
SELECT * FROM t1 WHERE first_name='Andy' OR last_name='Jake';
drop table t1;
CREATE TABLE t1 (a DOUBLE NOT NULL, KEY(a)) ENGINE=InnoDB
PARTITION BY KEY(a) PARTITIONS 10;
INSERT INTO t1 VALUES(1),(2);
SELECT COUNT(*) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT) ENGINE=InnoDB
  PARTITION BY list(a) (PARTITION p1 VALUES IN (1));
CREATE INDEX i1 ON t1 (a);
DROP TABLE t1;
CREATE TABLE t1 (
	a INT,
	b DATE NOT NULL,
	PRIMARY KEY (a, b)
) ENGINE=InnoDB
PARTITION BY RANGE (a) (
	PARTITION pMAX VALUES LESS THAN MAXVALUE
);
INSERT INTO t1 VALUES (1, '2001-01-01'), (2, '2002-02-02'), (3, '2003-03-03');
SELECT * FROM t1 FOR UPDATE;
ALTER TABLE t1 REORGANIZE PARTITION pMAX INTO
(PARTITION p3 VALUES LESS THAN (3),
 PARTITION pMAX VALUES LESS THAN MAXVALUE);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (i1 int NOT NULL primary key, f1 int) ENGINE = InnoDB
    PARTITION BY HASH(i1) PARTITIONS 2;
INSERT INTO t1 VALUES (1,1), (2,2);
SELECT * FROM t1 WHERE i1 = ( SELECT i1 FROM t1 WHERE f1=0 LIMIT 1 );
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a bigint not null, b int not null, PRIMARY KEY (a))
  ENGINE = InnoDB PARTITION BY KEY(a) PARTITIONS 2;
INSERT INTO t1 values (0,1), (1,2);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a int, PRIMARY KEY (a)) ENGINE=InnoDB
PARTITION BY HASH (a) PARTITIONS 2;
UNLOCK TABLES;
ALTER TABLE t1 DISCARD TABLESPACE;
DROP TABLE t1;
CREATE TABLE t1
(a INT,
 b INT,
 PRIMARY KEY (a))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 3;
ALTER TABLE t1 ADD INDEX idx1 (b);
SELECT b FROM t1 WHERE b = 0;
SELECT b FROM t1 WHERE b = 0;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1
(a INT,
 b INT,
 PRIMARY KEY (a))
ENGINE = InnoDB;
ALTER TABLE t1 ADD INDEX idx1 (b);
SELECT b FROM t1 WHERE b = 0;
SELECT b FROM t1 WHERE b = 0;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
f1 INT(11) NOT NULL,
f2 INT(11) NOT NULL
)
ENGINE=InnoDB
PARTITION BY KEY (f1,f2) PARTITIONS 2;
INSERT INTO t1 VALUES (9585,5);
CREATE TABLE t2 (
f1 INT(11) NOT NULL,
f2 INT(11) NOT NULL,
f3 INT(11) NOT NULL,
f4 INT(11) NOT NULL
)
ENGINE=InnoDB
PARTITION BY KEY (f2,f3) PARTITIONS 2;
INSERT INTO t2 VALUES (10,9585,5,20);
ALTER TABLE t2 CHANGE f3 f3 INT AFTER f4, ALGORITHM=INPLACE;
ALTER TABLE t2 CHANGE f4 f4 INT AFTER f3, ALGORITHM=INPLACE;
ALTER TABLE t2 CHANGE f1 f1 INT AFTER f4, ALGORITHM=INPLACE;
ALTER TABLE t2 CHANGE f1 f1 INT AFTER f2, ALGORITHM=INPLACE;
CREATE TABLE t3 (f1 INT,f2 INT) ENGINE=INNODB
PARTITION BY RANGE(f1) (
PARTITION p0 VALUES LESS THAN (100),
PARTITION p1 VALUES LESS THAN (200),
PARTITION p2 VALUES LESS THAN (600),
PARTITION p3 VALUES LESS THAN MAXVALUE
);
insert into t3 values (90,120);
insert into t3 values (120,300);
ALTER TABLE t3 CHANGE f1 f1 int AFTER f2, ALGORITHM=INPLACE;
CREATE TABLE t4 (
f1 INT(11) NOT NULL,
f2 INT(11) NOT NULL
)
ENGINE=InnoDB
PARTITION BY HASH (MOD(f1,f2)) PARTITIONS 2;
INSERT INTO t4 VALUES (9585,5);
ALTER TABLE t4 CHANGE f1 f1 INT AFTER f2, ALGORITHM=INPLACE;
CREATE TABLE t5 (
    f1 INT,
    f2 INT
)
ENGINE=InnoDB
PARTITION BY RANGE COLUMNS(f1,f2) (
    PARTITION p0 VALUES LESS THAN (10000,12),
    PARTITION p1 VALUES LESS THAN (MAXVALUE, MAXVALUE)
);
INSERT INTO t5 VALUES (1,20000);
ALTER TABLE t5 CHANGE f1 f1 INT AFTER f2, ALGORITHM=INPLACE;
CREATE TABLE t6 (
    a INT,
    b INT
)
ENGINE=InnoDB
PARTITION BY RANGE COLUMNS(a,b)
SUBPARTITION BY KEY(a,b)
SUBPARTITIONS 2 (
    PARTITION p0 VALUES LESS THAN (10000,12),
    PARTITION p1 VALUES LESS THAN (MAXVALUE, MAXVALUE)
);
INSERT INTO t6 VALUES (9585,5);
CREATE TABLE t7 (
f1 INT(11) NOT NULL,
f2 INT(11) NOT NULL,
f3 INT(11) NOT NULL,
f4 INT(11) NOT NULL,
f5 INT(11) NOT NULL

)
ENGINE=InnoDB
PARTITION BY KEY (f1,f5) PARTITIONS 2;
INSERT INTO t7 VALUES (9585,10,20,10,5);
ALTER TABLE t7 CHANGE f5 f5 INT AFTER f3, ALGORITHM=INPLACE;
ALTER TABLE t7 CHANGE f5 f5 INT AFTER f2, ALGORITHM=INPLACE;
DROP TABLE t1,t2,t3,t4,t5,t6,t7;
CREATE TABLE t1 (a int, b int, primary key (a), key (b))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1,1),(2,1),(3,3),(4,1),(5,3),(6,1),(7,1),(8,1),(9,4),
(10,1),(11,3),(12,1),(13,3),(14,1),(15,1),(16,3),(17,1),(18,1),(19,1),(20,3);
ALTER TABLE t1 DISABLE KEYS;
INSERT INTO t1 VALUES (21,1),(22,1),(23,3),(24,1);
ALTER TABLE t1 ENABLE KEYS;
DROP TABLE t1;
CREATE TABLE t1
(a int NOT NULL,
 b int NOT NULL,
 c varchar(10) NOT NULL,
 INDEX(a),
 UNIQUE KEY  (c(5), a, b)
)
ENGINE=InnoDB
PARTITION BY HASH (b) PARTITIONS 2;
SELECT * FROM t1 WHERE a = '92' AND c = '0.73';
SELECT * FROM t1 WHERE a = '1224';
DROP TABLE t1;
CREATE TABLE t1
(
  a int NOT NULL,
  b int NOT NULL DEFAULT 2,
  c int NOT NULL DEFAULT 3,
  PRIMARY KEY (a),
  INDEX i2(b),
  INDEX i3(c)
)
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 (a) VALUES (1),(2),(3),(4),(5),(6),(7),(8);
INSERT INTO t1 (a) SELECT a+8 FROM t1;
UPDATE t1 SET b=a,c=a;
SELECT * FROM t1 WHERE a=3 OR b=4;
DROP TABLE t1;
CREATE TABLE t1 (a int)
PARTITION BY LINEAR HASH (a) PARTITIONS 8;
ALTER TABLE t1 COALESCE PARTITION 2;
DROP TABLE t1;
CREATE TABLE t1 (a int, PRIMARY KEY (a)) ENGINE=InnoDB
PARTITION BY HASH (a) PARTITIONS 2;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE
CREATE_TIME IS NOT NULL AND TABLE_NAME='t1';
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8);
SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE
CREATE_TIME IS NOT NULL AND UPDATE_TIME IS NOT NULL
AND TABLE_NAME='t1' OR FALSE;
DROP TABLE t1;
ALTER TABLE t1 OPTIMIZE PARTITION p0;
ALTER TABLE t1 OPTIMIZE PARTITION p1;
CREATE TABLE t1(c1 INT,c2 CHAR (1),c3 DATE) ENGINE=InnoDB PARTITION BY HASH
(TO_DAYS(c3)) PARTITIONS 12;
ALTER TABLE t1 ADD INDEX(c1);
ALTER TABLE t1 DISCARD PARTITION p2 TABLESPACE;
CREATE TABLE t2 (c1 int,c2 CHAR (1),c3 date,key(c1)) ENGINE=InnoDB
PARTITION BY RANGE (TO_DAYS(c3))
(
PARTITION p0 VALUES LESS THAN (TO_DAYS('1979-01-01')),
PARTITION p1 VALUES LESS THAN (TO_DAYS('1989-01-01')),
PARTITION p2 VALUES LESS THAN (TO_DAYS('1999-01-01'))
);
ALTER TABLE t2 DISCARD PARTITION p2 TABLESPACE;
DROP TABLE t1,t2;
CREATE TABLE t1 ( a INT NOT NULL, b INT NOT NULL, c INT NOT NULL, PRIMARY KEY(a,b)) PARTITION BY RANGE (a)(PARTITION x1 VALUES LESS THAN (1));
SELECT * FROM t1 WHERE (a = 1 and b = 1 and c = 'b') OR (a > 2) ORDER BY a DESC;
CREATE TABLE t(id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, dttm DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, msg
TEXT,PRIMARY KEY (id,dttm))ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 ROW_FORMAT=DYNAMIC PARTITION BY RANGE
COLUMNS(dttm) (PARTITION pf_201612 VALUES LESS THAN ('20170101') ENGINE = INNODB);
SELECT * FROM t WHERE dttm > '2017-01-19' ORDER BY id DESC;
DROP TABLE t,t1;
create table test12 (name varchar(30),age bigint,grade bigint,date datetime
not null,partition_id int not null,
  PRIMARY KEY (`name`,`PARTITION_ID`),
  KEY `IDX_DATE` (`date`,`name`,`partition_id`),
  KEY `IDX_AGE` (`age`,`partition_id`) ) PARTITION BY RANGE
COLUMNS(PARTITION_ID)
(PARTITION p0 VALUES LESS THAN (0) ENGINE = InnoDB,
 PARTITION P1 VALUES LESS THAN (1) ENGINE = InnoDB,
 PARTITION P2 VALUES LESS THAN (2) ENGINE = InnoDB,
 PARTITION P3 VALUES LESS THAN (3) ENGINE = InnoDB,
 PARTITION P4 VALUES LESS THAN (4) ENGINE = InnoDB,
 PARTITION P5 VALUES LESS THAN (5) ENGINE = InnoDB,
 PARTITION P6 VALUES LESS THAN (6) ENGINE = InnoDB,
 PARTITION P7 VALUES LESS THAN (7) ENGINE = InnoDB,
 PARTITION P8 VALUES LESS THAN (8) ENGINE = InnoDB,
 PARTITION P9 VALUES LESS THAN (9) ENGINE = InnoDB);
insert into test12 values('Tom1',20,1,'2017-08-25
12:12:12',1),('Tom2',21,1,'2017-08-25 12:12:12',1),('Tom3',23,1,'2017-08-25
12:12:12',1);
drop table test12;
CREATE TABLE t1 (fld1 INT(11) NOT NULL, fld2 INT(11) NOT NULL,
fld3 DATE NOT NULL,  fld4 DATE NOT NULL,
PRIMARY KEY (fld1, fld3),  KEY(fld1)) PARTITION
BY RANGE (YEAR(fld3))
(PARTITION p01 VALUES LESS THAN (1985) ENGINE = InnoDB,
PARTITION p02 VALUES LESS THAN (1986) ENGINE = InnoDB,
PARTITION p03 VALUES LESS THAN MAXVALUE ENGINE = InnoDB);
INSERT INTO t1 VALUES('11', '11111', '1984-11-16',
'2008-11-16'), ('12', '11112', '1985-11-16', '2008-11-16'),
('13', '11113', '1986-11-16', '2008-11-16');
SELECT TABLE_NAME, COUNT(UPDATE_TIME) FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1' ORDER BY
PARTITION_ORDINAL_POSITION;
ALTER TABLE t1 ENGINE=INNODB;
SELECT TABLE_NAME, COUNT(UPDATE_TIME) FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME = 't1' ORDER BY
PARTITION_ORDINAL_POSITION;
UPDATE t1 SET fld2 = 71000 WHERE fld1 = 12 AND fld3 = '1985-11-16';
SELECT TABLE_NAME, COUNT(UPDATE_TIME)
FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_SCHEMA = 'test' AND
TABLE_NAME = 't1' ORDER BY PARTITION_ORDINAL_POSITION;
DROP TABLE t1;
CREATE TABLE `t1` (
  `id` int(11) NOT NULL,
  `dt` datetime NOT NULL,
  `data` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`,`dt`),
  KEY `idx_dt` (`dt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY RANGE (to_days(dt))
(PARTITION p20170218 VALUES LESS THAN (736744) ENGINE = InnoDB,
 PARTITION p20170219 VALUES LESS THAN (736745) ENGINE = InnoDB,
 PARTITION pMax VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
INSERT INTO t1 VALUES (1, '2018-04-25 10:18:00', '1');
INSERT INTO t1 VALUES (2, '2018-04-25 10:18:01', '2');
INSERT INTO t1 VALUES (3, '2018-04-25 10:18:02', '3');
SELECT * FROM t1;
UPDATE t1 SET data = '11' WHERE id = 1;
UPDATE t1 SET data = '22' WHERE id = 2;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1
(a VARCHAR(10),
 b VARCHAR(10),
 PRIMARY KEY (a DESC, b DESC),
 KEY ab_asc (a ASC, b ASC),
 KEY a_asc_b_desc (a ASC, b DESC),
 key a_desc_b_asc (a DESC, b ASC))
ENGINE = InnoDB
PARTITION BY KEY (a, b) PARTITIONS 3;
INSERT INTO t1 VALUES ("0", "0"), ("1", "1"), ("2", "2"), ("3", "3"),
("4", "4"), ("55", "55"), ("54", "54"), ("1", "2"), ("1", "4"), ("1", "3"),
("55", "54"), ("0", "1");
SELECT * FROM t1 FORCE INDEX (`PRIMARY`);
SELECT * FROM t1 FORCE INDEX (`ab_asc`);
SELECT * FROM t1 FORCE INDEX (`a_asc_b_desc`);
SELECT * FROM t1 FORCE INDEX (`a_desc_b_asc`);
SELECT * FROM t1 ORDER BY a DESC, b DESC;
SELECT * FROM t1 ORDER BY a, b;
SELECT * FROM t1 ORDER BY a, b DESC;
SELECT * FROM t1 ORDER BY a DESC, b;
SELECT * FROM t1 FORCE INDEX (`PRIMARY`) ORDER BY a, b;
SELECT * FROM t1 FORCE INDEX (`PRIMARY`) ORDER BY a DESC, b;
SELECT * FROM t1 FORCE INDEX (`PRIMARY`) ORDER BY a, b DESC;
SELECT * FROM t1 FORCE INDEX (`PRIMARY`) ORDER BY a DESC, b;
DROP TABLE t1;
