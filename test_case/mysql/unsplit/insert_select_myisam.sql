CREATE TABLE t1(
 Month date NOT NULL,
 Type tinyint(3) unsigned NOT NULL auto_increment,
 Field int(10) unsigned NOT NULL,
 Count int(10) unsigned NOT NULL,
 UNIQUE KEY Month (Month,Type,Field)
)engine=myisam;
insert into t1 Values
(20030901, 1, 1, 100),
(20030901, 1, 2, 100),
(20030901, 2, 1, 100),
(20030901, 2, 2, 100),
(20030901, 3, 1, 100);
select * from t1;
Select null, Field, Count From t1 Where Month=20030901 and Type=2;
create table t2(No int not null, Field int not null, Count int not null);
select * from t2;
drop table t1, t2;
CREATE TABLE t1 (
  ID           int(11) NOT NULL auto_increment,
  NO           int(11) NOT NULL default '0',
  SEQ          int(11) NOT NULL default '0',
  PRIMARY KEY  (ID),
  KEY t1$NO    (SEQ,NO)
) ENGINE=MyISAM;
INSERT INTO t1 (SEQ, NO) SELECT "1" AS SEQ, IF(MAX(NO) IS NULL, 0, MAX(NO)) + 1 AS NO FROM t1 WHERE (SEQ = 1);
select SQL_BUFFER_RESULT * from t1 WHERE (SEQ = 1);
drop table t1;
create table t1(f1 int);
insert into t1 values(1),(2),(3);
create table t2 (key(f1)) engine=myisam select sql_buffer_result f1 from t1;
drop table t1,t2;
