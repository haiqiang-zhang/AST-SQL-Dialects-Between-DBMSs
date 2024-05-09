CREATE TABLE t1 (id int,facility char(20));
CREATE TABLE t2 (facility char(20));
INSERT INTO t1 VALUES (NULL,NULL);
INSERT INTO t1 VALUES (-1,'');
INSERT INTO t1 VALUES (0,'');
INSERT INTO t1 VALUES (1,'/L');
INSERT INTO t1 VALUES (2,'A01');
INSERT INTO t1 VALUES (3,'ANC');
INSERT INTO t1 VALUES (4,'F01');
INSERT INTO t1 VALUES (5,'FBX');
INSERT INTO t1 VALUES (6,'MT');
INSERT INTO t1 VALUES (7,'P');
INSERT INTO t1 VALUES (8,'RV');
INSERT INTO t1 VALUES (9,'SRV');
INSERT INTO t1 VALUES (10,'VMT');
INSERT INTO t2 SELECT DISTINCT FACILITY FROM t1;
select id from t1 group by id;
select * from t1 order by id;
select id-5,facility from t1 order by "id-5";
select id >= 0 and id <= 5 as grp,count(*) from t1 group by grp;
SELECT DISTINCT FACILITY FROM t1;
SELECT FACILITY FROM t2;
SELECT count(*) from t1,t2 where t1.facility=t2.facility;
select count(facility) from t1;
select count(*) from t1;
select count(*) from t1 where facility IS NULL;
select count(*) from t1 where facility = NULL;
select count(*) from t1 where facility IS NOT NULL;
select count(*) from t1 where id IS NULL;
select count(*) from t1 where id IS NOT NULL;
drop table t1,t2;
CREATE TABLE t1 (UserId int(11) DEFAULT '0' NOT NULL);
INSERT INTO t1 VALUES (20);
INSERT INTO t1 VALUES (27);
SELECT UserId FROM t1 WHERE Userid=22;
SELECT UserId FROM t1 WHERE UserId=22 group by Userid;
SELECT DISTINCT UserId FROM t1 WHERE UserId=22 group by Userid;
SELECT DISTINCT UserId FROM t1 WHERE UserId=22;
drop table t1;
CREATE TABLE t1 (a int(10) unsigned not null primary key,b int(10) unsigned);
INSERT INTO t1 VALUES (1,1),(2,1),(3,1),(4,1);
CREATE TABLE t2 (a int(10) unsigned not null, key (A));
INSERT INTO t2 VALUES (1),(2);
CREATE TABLE t3 (a int(10) unsigned, key(A), b text);
INSERT INTO t3 VALUES (1,'1'),(2,'2');
SELECT DISTINCT t3.b FROM t3,t2,t1 WHERE t3.a=t1.b AND t1.a=t2.a;
INSERT INTO t2 values (1),(2),(3);
INSERT INTO t3 VALUES (1,'1'),(2,'2'),(1,'1'),(2,'2');
SELECT distinct t3.a FROM t3,t2,t1 WHERE t3.a=t1.b AND t1.a=t2.a;
create temporary table t4 select * from t3;
insert into t3 select * from t4;
insert into t4 select * from t3;
insert into t3 select * from t4;
insert into t4 select * from t3;
insert into t3 select * from t4;
insert into t4 select * from t3;
insert into t3 select * from t4;
select distinct t1.a from t1,t3 where t1.a=t3.a;
select distinct 1 from t1,t3 where t1.a=t3.a;
drop table t1,t2,t3,t4;
CREATE TABLE t1 (name varchar(255));
INSERT INTO t1 VALUES ('aa'),('ab'),('ac'),('ad'),('ae');
SELECT DISTINCT * FROM t1 LIMIT 2;
SELECT DISTINCT name FROM t1 LIMIT 2;
SELECT DISTINCT 1 FROM t1 LIMIT 2;
drop table t1;
CREATE TABLE t1 (
  ID int(11) NOT NULL auto_increment,
  NAME varchar(75) DEFAULT '' NOT NULL,
  LINK_ID int(11) DEFAULT '0' NOT NULL,
  PRIMARY KEY (ID),
  KEY NAME (NAME),
  KEY LINK_ID (LINK_ID)
);
INSERT INTO t1 (ID, NAME, LINK_ID) VALUES (1,'Mike',0),(2,'Jack',0),(3,'Bill',0);
CREATE TABLE t2 (
  ID int(11) NOT NULL auto_increment,
  NAME varchar(150) DEFAULT '' NOT NULL,
  PRIMARY KEY (ID),
  KEY NAME (NAME)
);
SELECT DISTINCT
    t2.id AS key_link_id,
    t2.name AS link
FROM t1
LEFT JOIN t2 ON t1.link_id=t2.id
GROUP BY t1.id
ORDER BY link;
drop table t1,t2;
create table t1 (
    id		int not null,
    name	tinytext not null,
    unique	(id)
);
create table t2 (
    id		int not null,
    idx		int not null,
    unique	(id, idx)
);
create table t3 (
    id		int not null,
    idx		int not null,
    unique	(id, idx)
);
insert into t1 values (1,'yes'), (2,'no');
insert into t2 values (1,1);
insert into t3 values (1,1);
SELECT DISTINCT
    t1.id
from
    t1
    straight_join
    t2
    straight_join
    t3
    straight_join
    t1 as j_lj_t2 left join t2 as t2_lj
        on j_lj_t2.id=t2_lj.id
    straight_join
    t1 as j_lj_t3 left join t3 as t3_lj
        on j_lj_t3.id=t3_lj.id
WHERE
    ((t1.id=j_lj_t2.id AND t2_lj.id IS NULL) OR (t1.id=t2.id AND t2.idx=2))
    AND ((t1.id=j_lj_t3.id AND t3_lj.id IS NULL) OR (t1.id=t3.id AND t3.idx=2));
SELECT DISTINCT
    t1.id
from
    t1
    straight_join
    t2
    straight_join
    t3
    straight_join
    t1 as j_lj_t2 left join t2 as t2_lj
        on j_lj_t2.id=t2_lj.id
    straight_join
    t1 as j_lj_t3 left join t3 as t3_lj
        on j_lj_t3.id=t3_lj.id
WHERE
    ((t1.id=j_lj_t2.id AND t2_lj.id IS NULL) OR (t1.id=t2.id AND t2.idx=2))
    AND ((t1.id=j_lj_t3.id AND t3_lj.id IS NULL) OR (t1.id=t3.id AND t3.idx=2));
drop table t1,t2,t3;
create table t1 (a int not null, b int not null, t time);
insert into t1 values (1,1,"00:06:15"),(1,2,"00:06:15"),(1,2,"00:30:15"),(1,3,"00:06:15"),(1,3,"00:30:15");
select a,sec_to_time(sum(time_to_sec(t))) from t1 group by a,b;
select distinct a,sec_to_time(sum(time_to_sec(t))) from t1 group by a,b;
create table t2 (a int not null primary key, b int);
insert into t2 values (1,1),(2,2),(3,3);
select t1.a,sec_to_time(sum(time_to_sec(t))) from t1 left join t2 on (t1.b=t2.a) group by t1.a,t2.b;
select distinct t1.a,sec_to_time(sum(time_to_sec(t))) from t1 left join t2 on (t1.b=t2.a) group by t1.a,t2.b;
drop table t1,t2;
create table t1 (a int not null,b char(5), c text);
insert into t1 (a) values (1),(2),(3),(4),(1),(2),(3),(4);
select distinct a from t1 group by b,a having a > 2 order by a desc;
select distinct a,c from t1 group by b,c,a having a > 2 order by a desc;
drop table t1;
create table t1 (a char(1), key(a)) engine=myisam;
insert into t1 values('1'),('1');
select * from t1 where a >= '1';
select distinct a from t1 order by a desc;
select distinct a from t1 where a >= '1' order by a desc;
drop table t1;
CREATE TABLE t1 (email varchar(50), infoID BIGINT, dateentered DATETIME);
CREATE TABLE t2 (infoID BIGINT, shipcode varchar(10));
INSERT INTO t1 (email, infoID, dateentered) VALUES
      ('test1@testdomain.com', 1, '2002-07-30 22:56:38'),
      ('test1@testdomain.com', 1, '2002-07-27 22:58:16'),
      ('test2@testdomain.com', 1, '2002-06-19 15:22:19'),
      ('test2@testdomain.com', 2, '2002-06-18 14:23:47'),
      ('test3@testdomain.com', 1, '2002-05-19 22:17:32');
INSERT INTO t2(infoID, shipcode) VALUES
      (1, 'Z001'),
      (2, 'R002');
SELECT DISTINCTROW email, shipcode FROM t1, t2 WHERE t1.infoID=t2.infoID;
drop table t1,t2;
CREATE TABLE t1 (privatemessageid int(10) unsigned NOT NULL auto_increment,  folderid smallint(6) NOT NULL default '0',  userid int(10) unsigned NOT NULL default '0',  touserid int(10) unsigned NOT NULL default '0',  fromuserid int(10) unsigned NOT NULL default '0',  title varchar(250) NOT NULL default '',  message mediumtext NOT NULL,  dateline int(10) unsigned NOT NULL default '0',  showsignature smallint(6) NOT NULL default '0',  iconid smallint(5) unsigned NOT NULL default '0',  messageread smallint(6) NOT NULL default '0',  readtime int(10) unsigned NOT NULL default '0',  receipt smallint(6) unsigned NOT NULL default '0',  deleteprompt smallint(6) unsigned NOT NULL default '0',  multiplerecipients smallint(6) unsigned NOT NULL default '0',  PRIMARY KEY  (privatemessageid),  KEY userid (userid)) ENGINE=MyISAM;
INSERT INTO t1 VALUES (128,0,33,33,8,':D','',996121863,1,0,2,996122850,2,0,0);
CREATE TABLE t2 (a int primary key, b int, c int);
INSERT t2 VALUES (3,4,5);
DROP TABLE t1,t2;
CREATE table t1 (  `id` int(11) NOT NULL auto_increment,  `name` varchar(50) NOT NULL default '',  PRIMARY KEY  (`id`)) ENGINE=MyISAM AUTO_INCREMENT=3;
INSERT INTO t1 VALUES (1, 'aaaaa');
INSERT INTO t1 VALUES (3, 'aaaaa');
INSERT INTO t1 VALUES (2, 'eeeeeee');
select distinct left(name,1) as name from t1;
drop  table t1;
CREATE TABLE t1 (
  ID int(11) NOT NULL auto_increment,
  NAME varchar(75) DEFAULT '' NOT NULL,
  LINK_ID int(11) DEFAULT '0' NOT NULL,
  PRIMARY KEY (ID),
  KEY NAME (NAME),
  KEY LINK_ID (LINK_ID)
);
INSERT INTO t1 (ID, NAME, LINK_ID) VALUES (1,'Mike',0);
INSERT INTO t1 (ID, NAME, LINK_ID) VALUES (2,'Jack',0);
INSERT INTO t1 (ID, NAME, LINK_ID) VALUES (3,'Bill',0);
CREATE TABLE t2 (
  ID int(11) NOT NULL auto_increment,
  NAME varchar(150) DEFAULT '' NOT NULL,
  PRIMARY KEY (ID),
  KEY NAME (NAME)
);
SELECT DISTINCT
    t2.id AS key_link_id,
    t2.name AS link
FROM t1
LEFT JOIN t2 ON t1.link_id=t2.id
GROUP BY t1.id
ORDER BY link;
drop table t1,t2;
CREATE TABLE t1 (
  html varchar(5) default NULL,
  rin int(11) default '0',
  rout int(11) default '0'
) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('1',1,0);
drop table t1;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5);
SELECT DISTINCT a, 1 FROM t1;
SELECT DISTINCT 1, a FROM t1;
CREATE TABLE t2 (a int, b int);
INSERT INTO t2 VALUES (1,1),(2,2),(2,3),(2,4),(3,5);
SELECT DISTINCT a, b, 2 FROM t2;
SELECT DISTINCT 2, a, b FROM t2;
SELECT DISTINCT a, 2, b FROM t2;
DROP TABLE t1,t2;
CREATE TABLE t1(a INT PRIMARY KEY, b INT);
INSERT INTO t1 VALUES (1,1), (2,1), (3,1);
CREATE TABLE t2(a INT, b INT NOT NULL, c INT NOT NULL, d INT, 
                PRIMARY KEY (a,b));
INSERT INTO t2 VALUES (1,1,1,50), (1,2,3,40), (2,1,3,4);
CREATE UNIQUE INDEX c_b_unq ON t2 (c,b);
DROP TABLE t1,t2;
create table t1 (id int, dsc varchar(50));
insert into t1 values (1, "line number one"), (2, "line number two"), (3, "line number three");
select distinct id, IFNULL(dsc, '-') from t1;
drop table t1;
CREATE TABLE t1 (a int primary key, b int);
INSERT INTO t1 (a,b) values (1,1), (2,3), (3,2);
SELECT DISTINCT a, b FROM t1 ORDER BY b;
DROP TABLE t1;
CREATE TABLE t1 (
  ID int(11) NOT NULL auto_increment,
  x varchar(20) default NULL,
  y decimal(10,0) default NULL,
  PRIMARY KEY  (ID),
  KEY (y)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES
(1,'ba','-1'),
(2,'ba','1150'),
(306,'ba','-1'),
(307,'ba','1150'),
(611,'ba','-1'),
(612,'ba','1150');
select count(distinct x,y) from t1;
select count(distinct concat(x,y)) from t1;
drop table t1;
CREATE TABLE t1 (a INT, b INT, PRIMARY KEY (a,b));
INSERT INTO t1 VALUES (1, 101);
INSERT INTO t1 SELECT a + 1, a + 101 FROM t1;
INSERT INTO t1 SELECT a + 2, a + 102 FROM t1;
INSERT INTO t1 SELECT a + 4, a + 104 FROM t1;
INSERT INTO t1 SELECT a + 8, a + 108 FROM t1;
SELECT DISTINCT a,a FROM t1 WHERE b < 12 ORDER BY a;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT NOT NULL, fruit_id INT NOT NULL, fruit_name varchar(20)
default NULL);
INSERT INTO t1 VALUES (1,1,'ORANGE');
INSERT INTO t1 VALUES (2,2,'APPLE');
INSERT INTO t1 VALUES (3,2,'APPLE');
INSERT INTO t1 VALUES (4,3,'PEAR');
SELECT DISTINCT fruit_id, fruit_name INTO @v1, @v2 FROM t1 WHERE fruit_name = 
'APPLE';
SELECT @v1, @v2;
SELECT DISTINCT fruit_id, fruit_name INTO @v3, @v4 FROM t1 GROUP BY fruit_id, 
fruit_name HAVING fruit_name = 'APPLE';
SELECT @v3, @v4;
SELECT DISTINCT @v5:= fruit_id, @v6:= fruit_name INTO @v7, @v8 FROM t1 WHERE 
fruit_name = 'APPLE';
SELECT @v5, @v6, @v7, @v8;
SELECT DISTINCT @v5 + fruit_id, CONCAT(@v6, fruit_name) INTO @v9, @v10 FROM t1 
WHERE fruit_name = 'APPLE';
SELECT @v5, @v6, @v7, @v8, @v9, @v10;
SELECT DISTINCT @v11:= @v5 + fruit_id, @v12:= CONCAT(@v6, fruit_name) INTO 
@v13, @v14 FROM t1 WHERE fruit_name = 'APPLE';
SELECT @v11, @v12, @v13, @v14;
SELECT DISTINCT @v13, @v14 INTO @v15, @v16 FROM t1 WHERE fruit_name = 'APPLE';
SELECT @v15, @v16;
SELECT DISTINCT 2 + 2, 'Bob' INTO @v17, @v18 FROM t1 WHERE fruit_name = 
'APPLE';
SELECT @v17, @v18;
DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (fruit_id INT NOT NULL, fruit_name varchar(20)
default NULL);
SELECT @v19, @v20;
SELECT * FROM t2;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (a CHAR(1));
SELECT a FROM t1 WHERE a=0;
SELECT DISTINCT a FROM t1 WHERE a=0;
DROP TABLE t1;
CREATE TABLE t1 (a DATE);
INSERT INTO t1 VALUES ('1972-07-29'), ('1972-02-06');
CREATE TABLE t2 (a CHAR(5) CHARACTER SET latin1 COLLATE latin1_general_ci);
INSERT INTO t2 VALUES (0xf6);
INSERT INTO t2 VALUES ('oe');
SELECT COUNT(*) FROM (SELECT DISTINCT a FROM t2) dt;
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT, UNIQUE (a));
INSERT INTO t1 VALUES (4),(null),(2),(1),(null),(3);
SELECT DISTINCT a FROM t1;
SELECT a FROM t1 GROUP BY a;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES(1,1),(1,2),(1,3);
SELECT DISTINCT a, b FROM t1;
SELECT DISTINCT a, a, b FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT, b INT, c INT, d INT, e INT,
                PRIMARY KEY(a,b,c,d,e),
                KEY(a,b,d,c)
);
INSERT IGNORE INTO t1(a, b, c) VALUES (1, 1, 1),
                                      (1, 1, 2),
                                      (1, 1, 3),
                                      (1, 2, 1),
                                      (1, 2, 2),
                                      (1, 2, 3);
SELECT DISTINCT a, b, d, c FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 int, c2 VARCHAR(20));
INSERT INTO t1 VALUES (1, '1'), (1, '1'), (2, '2'), (3, '1'), (3, '1'), (4, '4');
DROP TABLE t1;
CREATE TABLE t1 (a INT(1), b INT(1));
INSERT INTO t1 VALUES (1111, 2222), (3333, 4444);
SELECT DISTINCT CONCAT(a,b) AS c FROM t1 ORDER BY 1;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8);
INSERT INTO t1 SELECT a+8 FROM t1;
INSERT INTO t1 SELECT a+16 FROM t1;
INSERT INTO t1 SELECT a+32 FROM t1;
INSERT INTO t1 SELECT a+64 FROM t1;
INSERT INTO t1 VALUE(NULL);
SELECT COUNT(DISTINCT a) FROM t1;
SELECT COUNT(DISTINCT (a+0)) FROM t1;
DROP TABLE t1;
create table tb(
id int auto_increment primary key,
v varchar(32))
engine=myisam charset=gbk;
insert into tb(v) values("aaa");
insert into tb(v) (select v from tb);
insert into tb(v) (select v from tb);
insert into tb(v) (select v from tb);
insert into tb(v) (select v from tb);
insert into tb(v) (select v from tb);
insert into tb(v) (select v from tb);
update tb set v=concat(v, id);
select count(distinct case when id<=64 then id end) from tb;
select count(distinct case when id<=63 then id end) from tb;
drop table tb;
CREATE TABLE t1 (
  a INT,
  b INT NOT NULL
);
INSERT INTO t1 VALUES (1,2), (3,3);
SELECT DISTINCT subselect.b
FROM t1 LEFT JOIN 
     (SELECT it_b.* FROM t1 as it_a LEFT JOIN t1 as it_b ON true) AS subselect 
     ON t1.a = subselect.b;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (2),(3);
CREATE TABLE t2 (b INT);
CREATE TABLE t3 (
  a INT,
  b INT,
  PRIMARY KEY (b)
);
INSERT INTO t3 VALUES (2001,1), (2007,2);
SELECT DISTINCT t3.a AS t3_date
FROM t1
     LEFT JOIN t2 ON false
     LEFT JOIN t3 ON t2.b = t3.b
LIMIT 1;
DROP TABLE t1,t2,t3;
CREATE TABLE t1 (a INTEGER, b INTEGER);
INSERT INTO t1 VALUES (1,3), (2,4), (1,5),
(1,3), (2,1), (1,5), (1,7), (3,1),
(3,2), (3,1), (2,4);
SELECT DISTINCT (COUNT(DISTINCT b) + 1) AS c FROM t1 GROUP BY a;
DROP TABLE t1;
CREATE TABLE t1(c1 int, c2 VARCHAR(1) COLLATE utf8mb4_0900_as_cs);
INSERT INTO t1 VALUES (1, 'a');
INSERT INTO t1 VALUES (2, 'A');
DROP TABLE t1;
CREATE TABLE t(a INT, b INT);
INSERT INTO t VALUES(1,2);
INSERT INTO t VALUES(2,4);
SELECT  LEAST(1,COUNT(DISTINCT a)) FROM t GROUP BY a;
SELECT DISTINCT LEAST(1,COUNT(DISTINCT a)) FROM t GROUP BY a;
DROP TABLE t;
CREATE TABLE t1 (
  pk integer NOT NULL,
  f1 integer,
  f2 varchar(10),
  f3 varchar(255)
);
INSERT INTO t1 VALUES (14,7,'G','W');
INSERT INTO t1 VALUES (16,8,'W','p');
INSERT INTO t1 VALUES (23,NULL,'q','w');
SELECT DISTINCT table1.pk FROM t1 AS table1 LEFT JOIN t1 AS table2 ON table1.f2=table2.f3 WHERE table2.f1 IS NULL;
DROP TABLE t1;
CREATE TABLE t1 (
  pk integer
);
INSERT INTO t1 VALUES (3);
CREATE TABLE t2 (
  pk integer,
  f1 integer
);
INSERT INTO t2 VALUES (12,4);
CREATE TABLE t3 (
  pk integer,
  f2 integer,
  f3 integer
);
INSERT INTO t3 VALUES (56,0,4);
INSERT INTO t3 VALUES (97,3,4);
SELECT /*+JOIN_ORDER(t2,t3,t1) */ DISTINCT t2.pk FROM t1 LEFT JOIN t2 RIGHT OUTER JOIN t3 ON t2.f1 = t3.f3 ON t1.pk = t3.f2 WHERE t3.pk <> t2.pk;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( f FLOAT );
INSERT INTO t1 VALUES (0.0);
SELECT DISTINCT COUNT(*) AS num FROM t1 GROUP BY f HAVING num=1;
DROP TABLE t1;
CREATE TABLE t1 (
  a INTEGER NOT NULL,
  b BIT(62) NOT NULL
);
SELECT DISTINCT b FROM t1 GROUP BY a, b;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(1, 1), (2, 2), (3, 3);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER, f2 VARCHAR(10));
INSERT INTO t1 VALUES (1,"aaa"), (1,"bbb"),(1,"aaaa"),(1,"bbbb");
SELECT DISTINCT f1, LENGTH(F2) FROM t1 GROUP BY f1,LENGTH(F2) ORDER BY 1,2;
DROP TABLE t1;
CREATE TABLE t1 ( a INTEGER );
CREATE TABLE t2 ( a INTEGER );
CREATE TABLE t3 ( a INTEGER );
SELECT DISTINCT t1.a
  FROM t1, t2, t3
  WHERE t1.a = t2.a AND t2.a IS NULL
  HAVING t1.a = 8
  ORDER BY t1.a;
DROP TABLE t1, t2, t3;
CREATE TABLE t1(f1 INTEGER);
INSERT INTO t1 VALUES (1),(NULL);
SELECT DISTINCT f1 FROM t1 GROUP BY f1 WITH ROLLUP ORDER BY f1, ANY_VALUE(GROUPING(f1));
DROP TABLE t1;
CREATE TABLE t1(f1 integer,f2 integer);
INSERT INTO t1 VALUES (1,100000), (2,100000);
SELECT SQL_SMALL_RESULT DISTINCT t1.f1/t1.f2 FROM t1;
SELECT SQL_BIG_RESULT DISTINCT t1.f1/t1.f2 FROM t1;
DROP TABLE t1;
CREATE TABLE t1(v INTEGER);
INSERT INTO t1 VALUES
 (-2007568257), (-2007568260), (-2007570000), (-2007567234), (-2007567230),
 (2007568257), (2007568260), (2007570000), (2007567234), (2007567230);
SELECT SQL_SMALL_RESULT DISTINCT CAST(v AS FLOAT) FROM t1;
SELECT SQL_BIG_RESULT DISTINCT CAST(v AS FLOAT) FROM t1;
DROP TABLE t1;
