
--
-- Test bug reported by joc@presence-pc.com
--

CREATE TABLE t1 (
  `pseudo` char(35) NOT NULL default '',
  `pseudo1` char(35) NOT NULL default '',
  `same` tinyint(1) unsigned NOT NULL default '1',
  PRIMARY KEY  (`pseudo1`),
  KEY `pseudo` (`pseudo`)
) ENGINE=MyISAM;
INSERT INTO t1 (pseudo,pseudo1,same) VALUES ('joce', 'testtt', 1),('joce', 'tsestset', 1),('dekad', 'joce', 1);
SELECT pseudo FROM t1 WHERE pseudo1='joce' UNION SELECT pseudo FROM t1 WHERE pseudo='joce';
SELECT pseudo1 FROM t1 WHERE pseudo1='joce' UNION SELECT pseudo1 FROM t1 WHERE pseudo='joce';
SELECT * FROM t1 WHERE pseudo1='joce' UNION SELECT * FROM t1 WHERE pseudo='joce' order by pseudo desc,pseudo1 desc;
SELECT pseudo1 FROM t1 WHERE pseudo='joce' UNION SELECT pseudo FROM t1 WHERE pseudo1='joce';
SELECT pseudo1 FROM t1 WHERE pseudo='joce' UNION ALL SELECT pseudo FROM t1 WHERE pseudo1='joce';
SELECT pseudo1 FROM t1 WHERE pseudo='joce' UNION SELECT 1;
drop table t1;

--
-- Test for another bug with UNION and LEFT JOIN
--
CREATE TABLE t1 (  id int(3) unsigned default '0') ENGINE=MyISAM;
INSERT INTO t1 (id) VALUES("1");
CREATE TABLE t2 ( id int(3) unsigned default '0',  id_master int(5) default '0',  text1 varchar(5) default NULL,  text2 varchar(5) default NULL) ENGINE=MyISAM;
INSERT INTO t2 (id, id_master, text1, text2) VALUES("1", "1",
"foo1", "bar1");
INSERT INTO t2 (id, id_master, text1, text2) VALUES("2", "1",
"foo2", "bar2");
INSERT INTO t2 (id, id_master, text1, text2) VALUES("3", "1", NULL,
"bar3");
INSERT INTO t2 (id, id_master, text1, text2) VALUES("4", "1",
"foo4", "bar4");
SELECT 1 AS id_master, 1 AS id, NULL AS text1, 'ABCDE' AS text2 UNION SELECT id_master, t2.id, text1, text2 FROM t1 LEFT JOIN t2 ON t1.id = t2.id_master;
SELECT 1 AS id_master, 1 AS id, 'ABCDE' AS text1, 'ABCDE' AS text2 UNION SELECT id_master, t2.id, text1, text2 FROM t1 LEFT JOIN t2 ON t1.id = t2.id_master;
drop tables t1,t2;

--
-- Column 'name' cannot be null (error with union and left join) (bug #2508)
--
create table t1 (   RID int(11) not null default '0',   IID int(11) not null default '0',    nada varchar(50)  not null,NAME varchar(50) not null,PHONE varchar(50) not null) engine=MyISAM;
insert into t1 ( RID,IID,nada,NAME,PHONE) values (1, 1, 'main', 'a', '111'), (2, 1, 'main', 'b', '222'), (3, 1, 'main', 'c', '333'), (4, 1, 'main', 'd', '444'), (5, 1, 'main', 'e', '555'), (6, 2, 'main', 'c', '333'), (7, 2, 'main', 'd', '454'), (8, 2, 'main', 'e', '555'), (9, 2, 'main', 'f', '666'), (10, 2, 'main', 'g', '777');
select A.NAME, A.PHONE, B.NAME, B.PHONE from t1 A left join t1 B on A.NAME = B.NAME and B.IID = 2 where A.IID = 1 and (A.PHONE <> B.PHONE or B.NAME is null) union select A.NAME, A.PHONE, B.NAME, B.PHONE from t1 B left join t1 A on B.NAME = A.NAME and A.IID = 1 where B.IID = 2 and (A.PHONE <> B.PHONE or A.NAME is null);
drop  table t1;

-- Following scenario is to test the functionality of MyISAM

create table t1 (a varchar(5)) engine=myisam;
create table t2 engine=myisam select * from t1 union select 'abcdefghijkl';
select row_format from information_schema.TABLES where table_schema="test" and table_name="t2";
alter table t2 ROW_FORMAT=fixed;
drop table t1,t2;
