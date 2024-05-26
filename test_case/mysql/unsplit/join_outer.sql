drop table if exists t0,t1,t2,t3,t4,t5;
CREATE TABLE t1 (
  grp int(11) default NULL,
  a bigint(20) unsigned default NULL,
  c char(10) NOT NULL default ''
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1,1,'a'),(2,2,'b'),(2,3,'c'),(3,4,'E'),(3,5,'C'),(3,6,'D'),(NULL,NULL,'');
create table t2 (id int, a bigint unsigned not null, c char(10), d int, primary key (a));
insert into t2 values (1,1,"a",1),(3,4,"A",4),(3,5,"B",5),(3,6,"C",6),(4,7,"D",7);
select t1.*,t2.* from t1 JOIN t2 where t1.a=t2.a;
select t1.*,t2.* from t1 left join t2 on (t1.a=t2.a) order by t1.grp,t1.a,t2.c;
select t1.*,t2.* from { oj t2 left outer join t1 on (t1.a=t2.a) };
select t1.*,t2.* from t1 as t0,{ oj t2 left outer join t1 on (t1.a=t2.a) } WHERE t0.a=2;
select t1.*,t2.* from t1 left join t2 using (a);
select t1.*,t2.* from t1 left join t2 using (a) where t1.a=t2.a;
select t1.*,t2.* from t1 left join t2 using (a,c);
select t1.*,t2.* from t1 left join t2 using (c);
select t1.*,t2.* from t1 natural left outer join t2;
select t1.*,t2.* from t1 left join t2 on (t1.a=t2.a) where t2.id=3;
select t1.*,t2.* from t1 left join t2 on (t1.a=t2.a) where t2.id is null;
select t1.*,t2.*,t3.a from t1 left join t2 on (t1.a=t2.a) left join t1 as t3 on (t2.a=t3.a);
select t1.*,t2.* from t1 inner join t2 using (a);
select t1.*,t2.* from t1 inner join t2 on (t1.a=t2.a);
select t1.*,t2.* from t1 natural join t2;
drop table t1,t2;
CREATE TABLE t1 (
 usr_id INT unsigned NOT NULL,
 uniq_id INT unsigned NOT NULL AUTO_INCREMENT,
        start_num INT unsigned NOT NULL DEFAULT 1,
        increment INT unsigned NOT NULL DEFAULT 1,
 PRIMARY KEY (uniq_id),
 INDEX usr_uniq_idx (usr_id, uniq_id),
 INDEX uniq_usr_idx (uniq_id, usr_id)
);
CREATE TABLE t2 (
 id INT unsigned NOT NULL DEFAULT 0,
 usr2_id INT unsigned NOT NULL DEFAULT 0,
 max INT unsigned NOT NULL DEFAULT 0,
 c_amount INT unsigned NOT NULL DEFAULT 0,
 d_max INT unsigned NOT NULL DEFAULT 0,
 d_num INT unsigned NOT NULL DEFAULT 0,
 orig_time INT unsigned NOT NULL DEFAULT 0,
 c_time INT unsigned NOT NULL DEFAULT 0,
 active ENUM ("no","yes") NOT NULL,
 PRIMARY KEY (id,usr2_id),
 INDEX id_idx (id),
 INDEX usr2_idx (usr2_id)
);
INSERT INTO t1 VALUES (3,NULL,0,50),(3,NULL,0,200),(3,NULL,0,25),(3,NULL,0,84676),(3,NULL,0,235),(3,NULL,0,10),(3,NULL,0,3098),(3,NULL,0,2947),(3,NULL,0,8987),(3,NULL,0,8347654),(3,NULL,0,20398),(3,NULL,0,8976),(3,NULL,0,500),(3,NULL,0,198);
SELECT t1.usr_id,t1.uniq_id,t1.increment,
t2.usr2_id,t2.c_amount,t2.max
FROM t1
LEFT JOIN t2 ON t2.id = t1.uniq_id
WHERE t1.uniq_id = 4
ORDER BY t2.c_amount;
SELECT t1.usr_id,t1.uniq_id,t1.increment,
t2.usr2_id,t2.c_amount,t2.max
FROM t2
RIGHT JOIN t1 ON t2.id = t1.uniq_id
WHERE t1.uniq_id = 4
ORDER BY t2.c_amount;
INSERT INTO t2 VALUES (2,3,3000,6000,0,0,746584,837484,'yes');
INSERT INTO t2 VALUES (7,3,1000,2000,0,0,746294,937484,'yes');
SELECT t1.usr_id,t1.uniq_id,t1.increment,t2.usr2_id,t2.c_amount,t2.max FROM t1 LEFT JOIN t2 ON t2.id = t1.uniq_id WHERE t1.uniq_id = 4 ORDER BY t2.c_amount;
SELECT t1.usr_id,t1.uniq_id,t1.increment,t2.usr2_id,t2.c_amount,t2.max FROM t1 LEFT JOIN t2 ON t2.id = t1.uniq_id WHERE t1.uniq_id = 4;
drop table t1,t2;
CREATE TABLE t1 (
  cod_asig int(11) DEFAULT '0' NOT NULL,
  desc_larga_cat varchar(80) DEFAULT '' NOT NULL,
  desc_larga_cas varchar(80) DEFAULT '' NOT NULL,
  desc_corta_cat varchar(40) DEFAULT '' NOT NULL,
  desc_corta_cas varchar(40) DEFAULT '' NOT NULL,
  cred_total double(3,1) DEFAULT '0.0' NOT NULL,
  pre_requisit int(11),
  co_requisit int(11),
  preco_requisit int(11),
  PRIMARY KEY (cod_asig)
);
INSERT INTO t1 VALUES (10360,'asdfggfg','Introduccion a los  Ordenadores I','asdfggfg','Introduccio Ordinadors I',6.0,NULL,NULL,NULL);
INSERT INTO t1 VALUES (10361,'Components i Circuits Electronics I','Componentes y Circuitos Electronicos I','Components i Circuits Electronics I','Comp. i Circ. Electr. I',6.0,NULL,NULL,NULL);
INSERT INTO t1 VALUES (10362,'Laboratori d`Ordinadors','Laboratorio de Ordenadores','Laboratori d`Ordinadors','Laboratori Ordinadors',4.5,NULL,NULL,NULL);
INSERT INTO t1 VALUES (10363,'Tecniques de Comunicacio Oral i Escrita','Tecnicas de Comunicacion Oral y Escrita','Tecniques de Comunicacio Oral i Escrita','Tec. Com. Oral i Escrita',4.5,NULL,NULL,NULL);
INSERT INTO t1 VALUES (11403,'Projecte Fi de Carrera','Proyecto Fin de Carrera','Projecte Fi de Carrera','PFC',9.0,NULL,NULL,NULL);
INSERT INTO t1 VALUES (11404,'+lgebra lineal','Algebra lineal','+lgebra lineal','+lgebra lineal',15.0,NULL,NULL,NULL);
INSERT INTO t1 VALUES (11405,'+lgebra lineal','Algebra lineal','+lgebra lineal','+lgebra lineal',18.0,NULL,NULL,NULL);
CREATE TABLE t2 (
  idAssignatura int(11) DEFAULT '0' NOT NULL,
  Grup int(11) DEFAULT '0' NOT NULL,
  Places smallint(6) DEFAULT '0' NOT NULL,
  PlacesOcupades int(11) DEFAULT '0',
  PRIMARY KEY (idAssignatura,Grup)
);
INSERT INTO t2 VALUES (10360,12,333,0);
INSERT INTO t2 VALUES (10361,30,2,0);
INSERT INTO t2 VALUES (10361,40,3,0);
INSERT INTO t2 VALUES (10360,45,10,0);
INSERT INTO t2 VALUES (10362,10,12,0);
INSERT INTO t2 VALUES (10360,55,2,0);
INSERT INTO t2 VALUES (10360,70,0,0);
INSERT INTO t2 VALUES (10360,565656,0,0);
INSERT INTO t2 VALUES (10360,32767,7,0);
INSERT INTO t2 VALUES (10360,33,8,0);
INSERT INTO t2 VALUES (10360,7887,85,0);
INSERT INTO t2 VALUES (11405,88,8,0);
INSERT INTO t2 VALUES (10360,0,55,0);
INSERT INTO t2 VALUES (10360,99,0,0);
INSERT INTO t2 VALUES (11411,30,10,0);
INSERT INTO t2 VALUES (11404,0,0,0);
INSERT INTO t2 VALUES (10362,11,111,0);
INSERT INTO t2 VALUES (10363,33,333,0);
INSERT INTO t2 VALUES (11412,55,0,0);
INSERT INTO t2 VALUES (50003,66,6,0);
INSERT INTO t2 VALUES (11403,5,0,0);
INSERT INTO t2 VALUES (11406,11,11,0);
INSERT INTO t2 VALUES (11410,11410,131,0);
INSERT INTO t2 VALUES (11416,11416,32767,0);
INSERT INTO t2 VALUES (11409,0,0,0);
CREATE TABLE t3 (
  id int(11) NOT NULL auto_increment,
  dni_pasaporte char(16) DEFAULT '' NOT NULL,
  idPla int(11) DEFAULT '0' NOT NULL,
  cod_asig int(11) DEFAULT '0' NOT NULL,
  any smallint(6) DEFAULT '0' NOT NULL,
  quatrimestre smallint(6) DEFAULT '0' NOT NULL,
  estat char(1) DEFAULT 'M' NOT NULL,
  PRIMARY KEY (id),
  UNIQUE dni_pasaporte (dni_pasaporte,idPla),
  UNIQUE dni_pasaporte_2 (dni_pasaporte,idPla,cod_asig,any,quatrimestre)
);
INSERT INTO t3 VALUES (1,'11111111',1,10362,98,1,'M');
CREATE TABLE t4 (
  id int(11) NOT NULL auto_increment,
  papa int(11) DEFAULT '0' NOT NULL,
  fill int(11) DEFAULT '0' NOT NULL,
  idPla int(11) DEFAULT '0' NOT NULL,
  PRIMARY KEY (id),
  KEY papa (idPla,papa),
  UNIQUE papa_2 (idPla,papa,fill)
);
INSERT INTO t4 VALUES (1,-1,10360,1);
INSERT INTO t4 VALUES (2,-1,10361,1);
INSERT INTO t4 VALUES (3,-1,10362,1);
SELECT DISTINCT fill,desc_larga_cat,cred_total,Grup,Places,PlacesOcupades FROM t4 LEFT JOIN t3 ON t3.cod_asig=fill AND estat='S'   AND dni_pasaporte='11111111'   AND t3.idPla=1 , t2,t1 WHERE fill=t1.cod_asig   AND Places>PlacesOcupades   AND fill=idAssignatura   AND t4.idPla=1   AND papa=-1;
SELECT DISTINCT fill,t3.idPla FROM t4 LEFT JOIN t3 ON t3.cod_asig=t4.fill AND t3.estat='S' AND t3.dni_pasaporte='1234' AND t3.idPla=1;
INSERT INTO t3 VALUES (3,'1234',1,10360,98,1,'S');
SELECT DISTINCT fill,t3.idPla FROM t4 LEFT JOIN t3 ON t3.cod_asig=t4.fill AND t3.estat='S' AND t3.dni_pasaporte='1234' AND t3.idPla=1;
drop table t1,t2;
create table t1 (id int not null, str char(10), index(str));
insert into t1 values (1, null), (2, null), (3, "foo"), (4, "bar");
select * from t1 where str is not null order by id;
select * from t1 where str is null;
drop table t1;
CREATE TABLE t1 (
  t1_id bigint(21) NOT NULL auto_increment,
  PRIMARY KEY (t1_id)
);
CREATE TABLE t2 (
  t2_id bigint(21) NOT NULL auto_increment,
  PRIMARY KEY (t2_id)
);
CREATE TABLE t5 (
  seq_0_id bigint(21) DEFAULT '0' NOT NULL,
  seq_1_id bigint(21) DEFAULT '0' NOT NULL,
  KEY seq_1_id (seq_1_id),
  KEY seq_0_id (seq_0_id)
);
insert into t1 values (1);
insert into t2 values (1);
insert into t5 values (1,1);
drop table t1,t2,t3,t4,t5;
create table t1 (n int, m int, o int, key(n));
create table t2 (n int not null, m int, o int, primary key(n));
insert into t1 values (1, 2, 11), (1, 2, 7), (2, 2, 8), (1,2,9),(1,3,9);
insert into t2 values (1, 2, 3),(2, 2, 8), (4,3,9),(3,2,10);
select t1.*, t2.* from t1 left join t2 on t1.n = t2.n and
t1.m = t2.m where t1.n = 1;
select t1.*, t2.* from t1 left join t2 on t1.n = t2.n and
t1.m = t2.m where t1.n = 1 order by t1.o,t1.m;
drop table t1,t2;
CREATE TABLE t1 (id1 INT NOT NULL PRIMARY KEY, dat1 CHAR(1), id2 INT);
INSERT INTO t1 VALUES (1,'a',1);
INSERT INTO t1 VALUES (2,'b',1);
INSERT INTO t1 VALUES (3,'c',2);
CREATE TABLE t2 (id2 INT NOT NULL PRIMARY KEY, dat2 CHAR(1));
INSERT INTO t2 VALUES (1,'x');
INSERT INTO t2 VALUES (2,'y');
INSERT INTO t2 VALUES (3,'z');
SELECT t2.id2 FROM t2 LEFT OUTER JOIN t1 ON t1.id2 = t2.id2 WHERE id1 IS NULL;
SELECT t2.id2 FROM t2 NATURAL LEFT OUTER JOIN t1 WHERE id1 IS NULL;
drop table t1,t2;
create table t1 ( color varchar(20), name varchar(20) );
insert into t1 values ( 'red', 'apple' );
insert into t1 values ( 'yellow', 'banana' );
insert into t1 values ( 'green', 'lime' );
insert into t1 values ( 'black', 'grape' );
insert into t1 values ( 'blue', 'blueberry' );
create table t2 ( count int, color varchar(20) );
insert into t2 values (10, 'green');
insert into t2 values (5, 'black');
insert into t2 values (15, 'white');
insert into t2 values (7, 'green');
select * from t1;
select * from t2;
select * from t2 natural join t1;
select t2.count, t1.name from t2 natural join t1;
select t2.count, t1.name from t2 inner join t1 using (color);
drop table t1;
drop table t2;
CREATE TABLE t1 (
  pcode varchar(8) DEFAULT '' NOT NULL
);
INSERT INTO t1 VALUES ('kvw2000'),('kvw2001'),('kvw3000'),('kvw3001'),('kvw3002'),('kvw3500'),('kvw3501'),('kvw3502'),('kvw3800'),('kvw3801'),('kvw3802'),('kvw3900'),('kvw3901'),('kvw3902'),('kvw4000'),('kvw4001'),('kvw4002'),('kvw4200'),('kvw4500'),('kvw5000'),('kvw5001'),('kvw5500'),('kvw5510'),('kvw5600'),('kvw5601'),('kvw6000'),('klw1000'),('klw1020'),('klw1500'),('klw2000'),('klw2001'),('klw2002'),('kld2000'),('klw2500'),('kmw1000'),('kmw1500'),('kmw2000'),('kmw2001'),('kmw2100'),('kmw3000'),('kmw3200');
CREATE TABLE t2 (
  pcode varchar(8) DEFAULT '' NOT NULL,
  KEY pcode (pcode)
);
INSERT INTO t2 VALUES ('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw2000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3000'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw3500'),('kvw6000'),('kvw6000'),('kld2000');
SELECT t1.pcode, IF(ISNULL(t2.pcode), 0, COUNT(*)) AS count FROM t1
LEFT JOIN t2 ON t1.pcode = t2.pcode GROUP BY t1.pcode;
SELECT SQL_BIG_RESULT t1.pcode, IF(ISNULL(t2.pcode), 0, COUNT(*)) AS count FROM t1 LEFT JOIN t2 ON t1.pcode = t2.pcode GROUP BY t1.pcode;
drop table t1,t2;
CREATE TABLE t1 (
  id int(11),
  pid int(11),
  rep_del tinyint(4),
  KEY id (id),
  KEY pid (pid)
);
INSERT INTO t1 VALUES (1,NULL,NULL);
INSERT INTO t1 VALUES (2,1,NULL);
select * from t1 LEFT JOIN t1 t2 ON (t1.id=t2.pid) AND t2.rep_del IS NULL;
create index rep_del ON t1(rep_del);
select * from t1 LEFT JOIN t1 t2 ON (t1.id=t2.pid) AND t2.rep_del IS NULL;
drop table t1;
CREATE TABLE t2 (
  id int(11) DEFAULT '0' NOT NULL,
  idx int(11) DEFAULT '0' NOT NULL,
  UNIQUE id (id,idx)
);
INSERT INTO t2 VALUES (1,1);
create table t1 (bug_id mediumint, reporter mediumint);
insert into t1 values (1,1),(2,1);
drop table t1,t2;
create table t1 (fooID smallint unsigned auto_increment, primary key (fooID));
create table t2 (fooID smallint unsigned not null, barID smallint unsigned not null, primary key (fooID,barID));
insert into t1 (fooID) values (10),(20),(30);
insert into t2 values (10,1),(20,2),(30,3);
select * from t2 left join t1 on t1.fooID = t2.fooID and t1.fooID = 30;
select * from t2 left join t1 ignore index(primary) on t1.fooID = t2.fooID and t1.fooID = 30;
drop table t1,t2;
create table t1 (i int);
create table t2 (i int);
create table t3 (i int);
insert into t1 values(1),(2);
insert into t2 values(2),(3);
insert into t3 values(2),(4);
select * from t1 natural left join t2 natural left join t3;
select * from t1 natural left join t2 where (t2.i is not null)=0;
select * from t1 natural left join t2 where (t2.i is not null) is not null;
select * from t1 natural left join t2 where (i is not null)=0;
select * from t1 natural left join t2 where (i is not null) is not null;
drop table t1,t2,t3;
create table t1 (f1 integer,f2 integer,f3 integer);
create table t2 (f2 integer,f4 integer);
create table t3 (f3 integer,f5 integer);
select * from t1
         left outer join t2 using (f2)
         left outer join t3 using (f3);
drop table t1,t2,t3;
create table t1 (a1 int, a2 int);
create table t2 (b1 int not null, b2 int);
create table t3 (c1 int, c2 int);
insert into t1 values (1,2), (2,2), (3,2);
insert into t2 values (1,3), (2,3);
insert into t3 values (2,4),        (3,4);
select * from t1 left join t2  on  b1 = a1 left join t3  on  c1 = a1  and  b1 is null;
drop table t1, t2, t3;
create table t1 (
  a int(11),
  b char(10),
  key (a)
);
insert into t1 (a) values (1),(2),(3),(4);
create table t2 (a int);
select * from t1 left join t2 on t1.a=t2.a where not (t2.a <=> t1.a);
select * from t1 left join t2 on t1.a=t2.a having not (t2.a <=> t1.a);
drop table t1,t2;
create table t1 (
  match_id tinyint(3) unsigned not null auto_increment,
  home tinyint(3) unsigned default '0',
  unique key match_id (match_id),
  key match_id_2 (match_id)
);
insert into t1 values("1", "2");
create table t2 (
  player_id tinyint(3) unsigned default '0',
  match_1_h tinyint(3) unsigned default '0',
  key player_id (player_id)
);
insert into t2 values("1", "5");
insert into t2 values("2", "9");
insert into t2 values("3", "3");
insert into t2 values("4", "7");
insert into t2 values("5", "6");
insert into t2 values("6", "8");
insert into t2 values("7", "4");
insert into t2 values("8", "12");
insert into t2 values("9", "11");
insert into t2 values("10", "10");
select s.*, '*', m.*, (s.match_1_h - m.home) UUX from 
  (t2 s left join t1 m on m.match_id = 1) 
  order by UUX desc;
select s.*, '*', m.*, (s.match_1_h - m.home) UUX from 
  t2 s straight_join t1 m where m.match_id = 1 
  order by UUX desc;
drop table t1, t2;
create table t1 (a int, b int, unique index idx (a, b));
create table t2 (a int, b int, c int, unique index idx (a, b));
insert into t1 values (1, 10), (1,11), (2,10), (2,11);
insert into t2 values (1,10,3);
select t1.a, t1.b, t2.c from t1 left join t2
                                on t1.a=t2.a and t1.b=t2.b and t2.c=3
   where t1.a=1 and t2.c is null;
drop table t1, t2;
CREATE TABLE t1 (
  ts_id bigint(20) default NULL,
  inst_id tinyint(4) default NULL,
  flag_name varchar(64) default NULL,
  flag_value text,
  UNIQUE KEY ts_id (ts_id,inst_id,flag_name)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
CREATE TABLE t2 (
  ts_id bigint(20) default NULL,
  inst_id tinyint(4) default NULL,
  flag_name varchar(64) default NULL,
  flag_value text,
  UNIQUE KEY ts_id (ts_id,inst_id,flag_name)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES
  (111056548820001, 0, 'flag1', NULL),
  (111056548820001, 0, 'flag2', NULL),
  (2, 0, 'other_flag', NULL);
INSERT INTO t2 VALUES
  (111056548820001, 3, 'flag1', 'sss');
SELECT t1.flag_name,t2.flag_value 
  FROM t1 LEFT JOIN t2 
          ON (t1.ts_id = t2.ts_id AND t1.flag_name = t2.flag_name AND
              t2.inst_id = 3) 
  WHERE t1.inst_id = 0 AND t1.ts_id=111056548820001 AND
        t2.flag_value IS  NULL;
DROP TABLE t1,t2;
CREATE TABLE t1 (
  id int(11) unsigned NOT NULL auto_increment,
  text_id int(10) unsigned default NULL,
  PRIMARY KEY  (id)
);
INSERT INTO t1 VALUES("1", "0");
INSERT INTO t1 VALUES("2", "10");
CREATE TABLE t2 (
  text_id char(3) NOT NULL default '',
  language_id char(3) NOT NULL default '',
  text_data text,
  PRIMARY KEY  (text_id,language_id)
);
INSERT INTO t2 VALUES("0", "EN", "0-EN");
INSERT INTO t2 VALUES("0", "SV", "0-SV");
INSERT INTO t2 VALUES("10", "EN", "10-EN");
INSERT INTO t2 VALUES("10", "SV", "10-SV");
SELECT t1.id, t1.text_id, t2.text_data
  FROM t1 LEFT JOIN t2
               ON t1.text_id = t2.text_id
                  AND t2.language_id = 'SV'
  WHERE (t1.id LIKE '%' OR t2.text_data LIKE '%');
DROP TABLE t1, t2;
CREATE TABLE t0 (a0 int PRIMARY KEY);
CREATE TABLE t1 (a1 int PRIMARY KEY);
CREATE TABLE t2 (a2 int);
CREATE TABLE t3 (a3 int);
INSERT INTO t0 VALUES (1);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1), (2);
INSERT INTO t3 VALUES (1), (2);
SELECT * FROM t1 LEFT JOIN t2 ON a1=0;
SELECT * FROM t1 LEFT JOIN (t2,t3) ON a1=0;
SELECT * FROM t0, t1 LEFT JOIN (t2,t3) ON a1=0 WHERE a0=a1;
INSERT INTO t0 VALUES (0);
INSERT INTO t1 VALUES (0);
SELECT * FROM t0, t1 LEFT JOIN (t2,t3) ON a1=5 WHERE a0=a1 AND a0=1;
drop table t1,t2;
create table t1 (a int, b int);
insert into t1 values (1,1),(2,2),(3,3);
create table t2 (a int, b int);
insert into t2 values (1,1), (2,2);
select * from t2 right join t1 on t2.a=t1.a;
select straight_join * from t2 right join t1 on t2.a=t1.a;
DROP TABLE t0,t1,t2,t3;
CREATE TABLE t1 (a int PRIMARY KEY, b int);
CREATE TABLE t2 (a int PRIMARY KEY, b int);
INSERT INTO t1 VALUES (1,1), (2,1), (3,1), (4,2);
INSERT INTO t2 VALUES (1,2), (2,2);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a=t2.a;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a=t2.a WHERE t1.b=1;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a=t2.a
  WHERE t1.b=1 XOR (NOT ISNULL(t2.a) AND t2.b=1);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a=t2.a WHERE not(0+(t1.a=30 and t2.b=1));
DROP TABLE t1,t2;
create table t1 (a int, b varchar(20));
create table t2 (a int, c varchar(20));
insert into t1 values (1,"aaaaaaaaaa"),(2,"bbbbbbbbbb");
insert into t2 values (1,"cccccccccc"),(2,"dddddddddd");
select group_concat(t1.b,t2.c) from t1 left join t2 using(a) group by t1.a;
drop table t1, t2;
create table t1 (gid smallint(5) unsigned not null, x int(11) not null, y int(11) not null, art int(11) not null, primary key  (gid,x,y));
insert t1 values (1, -5, -8, 2), (1, 2, 2, 1), (1, 1, 1, 1);
create table t2 (gid smallint(5) unsigned not null, x int(11) not null, y int(11) not null, id int(11) not null, primary key  (gid,id,x,y), key id (id));
insert t2 values (1, -5, -8, 1), (1, 1, 1, 1), (1, 2, 2, 1);
create table t3 ( set_id smallint(5) unsigned not null, id tinyint(4) unsigned not null, name char(12) not null, primary key  (id,set_id));
insert t3 values (0, 1, 'a'), (1, 1, 'b'), (0, 2, 'c'), (1, 2, 'd'), (1, 3, 'e'), (1, 4, 'f'), (1, 5, 'g'), (1, 6, 'h');
drop tables t1,t2,t3;
CREATE TABLE t1 (EMPNUM INT, GRP INT);
INSERT INTO t1 VALUES (0, 10);
INSERT INTO t1 VALUES (2, 30);
CREATE TABLE t2 (EMPNUM INT, NAME CHAR(5));
INSERT INTO t2 VALUES (0, 'KERI');
INSERT INTO t2 VALUES (9, 'BARRY');
CREATE VIEW v1 AS
SELECT COALESCE(t2.EMPNUM,t1.EMPNUM) AS EMPNUM, NAME, GRP
  FROM t2 LEFT OUTER JOIN t1 ON t2.EMPNUM=t1.EMPNUM;
SELECT * FROM v1;
SELECT * FROM v1 WHERE EMPNUM < 10;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (c11 int);
CREATE TABLE t2 (c21 int);
INSERT INTO t1 VALUES (30), (40), (50);
INSERT INTO t2 VALUES (300), (400), (500);
SELECT * FROM t1 LEFT JOIN t2 ON (c11=c21 AND c21=30) WHERE c11=40;
DROP TABLE t1, t2;
CREATE TABLE t1 (a int PRIMARY KEY, b int);
CREATE TABLE t2 (a int PRIMARY KEY, b int);
INSERT INTO t1 VALUES (1,2), (2,1), (3,2), (4,3), (5,6), (6,5), (7,8), (8,7), (9,10);
INSERT INTO t2 VALUES (3,0), (4,1), (6,4), (7,5);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t2.b <= t1.a AND t1.a <= t1.b;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t1.a BETWEEN t2.b AND t1.b;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE NOT(t1.a NOT BETWEEN t2.b AND t1.b);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t2.b > t1.a OR t1.a > t1.b;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t1.a NOT BETWEEN t2.b AND t1.b;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE NOT(t1.a BETWEEN t2.b AND t1.b);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t1.a = t2.a OR t2.b > t1.a OR t1.a > t1.b;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE NOT(t1.a != t2.a AND t1.a BETWEEN t2.b AND t1.b);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t1.a = t2.a AND (t2.b > t1.a OR t1.a > t1.b);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE NOT(t1.a != t2.a OR t1.a BETWEEN t2.b AND t1.b);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t1.a = t2.a OR t1.a = t2.b;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t1.a IN(t2.a, t2.b);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE NOT(t1.a NOT IN(t2.a, t2.b));
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t1.a != t1.b AND t1.a != t2.b;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t1.a NOT IN(t1.b, t2.b);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE NOT(t1.a IN(t1.b, t2.b));
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t2.a != t2.b OR (t1.a != t2.a AND t1.a != t2.b);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE NOT(t2.a = t2.b AND t1.a IN(t2.a, t2.b));
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE t2.a != t2.b AND t1.a != t1.b AND t1.a != t2.b;
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.a WHERE NOT(t2.a = t2.b OR t1.a IN(t1.b, t2.b));
DROP TABLE t1,t2;
DROP VIEW IF EXISTS v1,v2;
DROP TABLE IF EXISTS t1,t2;
CREATE TABLE t1 (a int);
CREATE table t2 (b int);
INSERT INTO t1 VALUES (1), (2), (3), (4), (1), (1), (3);
INSERT INTO t2 VALUES (2), (3);
CREATE VIEW v1 AS SELECT a FROM t1 JOIN t2 ON t1.a=t2.b;
CREATE VIEW v2 AS SELECT b FROM t2 JOIN t1 ON t2.b=t1.a;
SELECT v1.a, v2. b 
  FROM v1 LEFT OUTER JOIN v2 ON (v1.a=v2.b) AND (v1.a >= 3)
    GROUP BY v1.a;
SELECT v1.a, v2. b 
  FROM { OJ v1 LEFT OUTER JOIN v2 ON (v1.a=v2.b) AND (v1.a >= 3) }
    GROUP BY v1.a;
DROP VIEW v1,v2;
DROP TABLE t1,t2;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (b int);
INSERT INTO t1 VALUES (1), (2), (3), (4);
INSERT INTO t2 VALUES (2), (3);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.b WHERE (1=1);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.b WHERE (1 OR 1);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.b WHERE (0 OR 1);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.b WHERE (1=1 OR 2=2);
SELECT * FROM t1 LEFT JOIN t2 ON t1.a = t2.b WHERE (1=1 OR 1=0);
DROP TABLE t1,t2;
CREATE TABLE t1 (
  f1 varchar(16) collate latin1_swedish_ci PRIMARY KEY,
  f2 varchar(16) collate latin1_swedish_ci
);
CREATE TABLE t2 (
  f1 varchar(16) collate latin1_swedish_ci PRIMARY KEY,
  f3 varchar(16) collate latin1_swedish_ci
);
INSERT INTO t1 VALUES ('bla','blah');
INSERT INTO t2 VALUES ('bla','sheep');
SELECT * FROM t1 JOIN t2 USING(f1) WHERE f1='Bla';
SELECT * FROM t1 LEFT JOIN t2 USING(f1) WHERE f1='bla';
SELECT * FROM t1 LEFT JOIN t2 USING(f1) WHERE f1='Bla';
DROP TABLE t1,t2;
CREATE TABLE t1 (id int PRIMARY KEY, a varchar(8));
CREATE TABLE t2 (id int NOT NULL, b int NOT NULL, INDEX idx(id));
INSERT INTO t1 VALUES
  (1,'aaaaaaa'), (5,'eeeeeee'), (4,'ddddddd'), (2,'bbbbbbb'), (3,'ccccccc');
INSERT INTO t2 VALUES
  (3,10), (2,20), (5,30), (3,20), (5,10), (3,40), (3,30), (2,10), (2,40);
SELECT t1.id, a FROM t1 LEFT JOIN t2 ON t1.id=t2.id WHERE t2.b IS NULL;
SELECT t1.id, a FROM t1 LEFT JOIN t2 ON t1.id=t2.id WHERE t2.b IS NULL;
DROP TABLE t1,t2;
CREATE TABLE t1 (c int  PRIMARY KEY, e int NOT NULL);
INSERT INTO t1 VALUES (1,0), (2,1);
CREATE TABLE t2 (d int PRIMARY KEY);
INSERT INTO t2 VALUES (1), (2), (3);
SELECT * FROM t1 LEFT JOIN t2 ON e<>0 WHERE c=1 AND d IS NULL;
SELECT * FROM t1 LEFT JOIN t2 ON e<>0 WHERE c=1 AND d<=>NULL;
DROP TABLE t1,t2;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 ( a INT, b INT );
INSERT INTO t2 VALUES (1, 1),(1, 2),(1, 3),(2, 4),(2, 5);
SELECT t1.a, COUNT( t2.b ), SUM( t2.b ), MAX( t2.b )
FROM t1 LEFT JOIN t2 USING( a )
GROUP BY t1.a WITH ROLLUP;
DROP TABLE t1, t2;
CREATE TABLE t1(f1 INT, f2 INT, f3 INT);
INSERT INTO t1 VALUES (1, NULL, 3);
CREATE TABLE t2(f1 INT, f2 INT);
INSERT INTO t2 VALUES (2, 1);
SELECT * FROM t1 LEFT JOIN t2 ON t1.f2 = t2.f2
WHERE (COALESCE(t1.f1, t2.f1), f3) IN ((1, 3), (2, 2));
DROP TABLE t1, t2;
CREATE TABLE t1( a INT );
INSERT INTO t1 VALUES (1),(2);
SELECT 1
FROM t1 tt3 LEFT  OUTER JOIN t1 tt4 ON 1
            LEFT  OUTER JOIN t1 tt5 ON 1
            LEFT  OUTER JOIN t1 tt6 ON 1
            LEFT  OUTER JOIN t1 tt7 ON 1
            LEFT  OUTER JOIN t1 tt8 ON 1
            RIGHT OUTER JOIN t1 tt2 ON 1
            RIGHT OUTER JOIN t1 tt1 ON 1
            STRAIGHT_JOIN    t1 tt9 ON 1;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT NOT NULL);
INSERT INTO t1 VALUES (9),(0);
CREATE TABLE t2 (f1 INT NOT NULL);
INSERT INTO t2 VALUES
(5),(3),(0),(3),(1),(0),(1),(7),(1),(0),(0),(8),(4),(9),(0),(2),(0),(8),(5),(1);
SELECT STRAIGHT_JOIN COUNT(*) FROM t1 ta1
RIGHT JOIN t2 ta2 JOIN t2 ta3 ON ta2.f1 ON ta3.f1;
DROP TABLE t1, t2;
CREATE TABLE t1(f1 INT, PRIMARY KEY (f1));
INSERT INTO t1 VALUES (1),(2);
DROP TABLE t1;
CREATE TABLE t1 (f1 INT NOT NULL, PRIMARY KEY (f1));
CREATE TABLE t2 (f1 INT NOT NULL, f2 INT NOT NULL, PRIMARY KEY (f1, f2));
INSERT INTO t1 VALUES (4);
INSERT INTO t2 VALUES (3, 3);
INSERT INTO t2 VALUES (7, 7);
SELECT * FROM t1 LEFT JOIN t2 ON t2.f1 = t1.f1
WHERE t1.f1 = 4
GROUP BY t2.f1, t2.f2;
SELECT * FROM t1 LEFT JOIN t2 ON t2.f1 = t1.f1
WHERE t1.f1 = 4 AND t2.f1 IS NOT NULL AND t2.f2 IS NOT NULL
GROUP BY t2.f1, t2.f2;
DROP TABLE t1,t2;
CREATE TABLE t1 (pk INT PRIMARY KEY, 
                 col_int INT, 
                 col_int_unique INT UNIQUE KEY);
INSERT INTO t1 VALUES (1,NULL,2), (2,0,0);
CREATE TABLE t2 (pk INT PRIMARY KEY,
                 col_int INT,
                 col_int_unique INT UNIQUE KEY);
INSERT INTO t2 VALUES (1,0,1), (2,0,2);
SELECT * FROM t1 LEFT JOIN t2
  ON t1.col_int_unique = t2.col_int_unique AND t1.col_int = t2.col_int 
  WHERE t1.pk=1;
SELECT * FROM t1 LEFT JOIN t2
  ON t1.col_int_unique = t2.col_int_unique AND t1.col_int = t2.col_int 
  WHERE t1.pk=1;
DROP TABLE t1,t2;
CREATE TABLE `BB` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `time_key` time DEFAULT NULL,
  `varchar_key` varchar(1) DEFAULT NULL,
  `varchar_nokey` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`pk`),
  KEY `time_key` (`time_key`),
  KEY `varchar_key` (`varchar_key`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
INSERT INTO `BB` VALUES (10,'18:27:58',NULL,NULL);
SELECT table1.time_key AS field1, table2.pk 
FROM BB table1  LEFT JOIN BB table2 
 ON table2.varchar_nokey = table1.varchar_key
 HAVING field1;
DROP TABLE BB;
CREATE TABLE `BB` (
  `col_datetime_key` datetime DEFAULT NULL,
  `col_varchar_key` varchar(1) DEFAULT NULL,
  `col_varchar_nokey` varchar(1) DEFAULT NULL,
  KEY `col_datetime_key` (`col_datetime_key`),
  KEY `col_varchar_key` (`col_varchar_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `BB` VALUES ('1900-01-01 00:00:00',NULL,NULL);
SELECT table1.col_datetime_key  
FROM BB table1 RIGHT JOIN BB table2 
 ON table2 .col_varchar_nokey = table1.col_varchar_key
 WHERE 7;
ALTER TABLE BB DISABLE KEYS;
SELECT table1.col_datetime_key  
FROM BB table1 RIGHT JOIN BB table2
 ON table2 .col_varchar_nokey = table1.col_varchar_key
 WHERE 7;
DROP TABLE BB;
CREATE TABLE t1 (i INT NOT NULL);
INSERT INTO t1 VALUES (0),    (2),(3),(4);
CREATE TABLE t2 (i INT NOT NULL);
INSERT INTO t2 VALUES (0),(1),    (3),(4);
CREATE TABLE t3 (i INT NOT NULL);
INSERT INTO t3 VALUES (0),(1),(2),    (4);
CREATE TABLE t4 (i INT NOT NULL);
INSERT INTO t4 VALUES (0),(1),(2),(3);
SELECT * FROM
 t1 LEFT JOIN
 ( t2 LEFT JOIN
   ( t3 LEFT JOIN
     t4
     ON t4.i = t3.i
   )
   ON t3.i = t2.i
 )
 ON t2.i = t1.i;
SELECT * FROM
 t1 LEFT JOIN
 ( t2 LEFT JOIN
   ( t3 LEFT JOIN
     t4
     ON t4.i = t3.i
   )
   ON t3.i = t2.i
 )
 ON t2.i = t1.i
 WHERE t4.i IS NULL;
SELECT * FROM
 t1 LEFT JOIN
 ( ( t2 LEFT JOIN
     t3
     ON t3.i = t2.i
   )
 )
 ON t2.i = t1.i
 WHERE t3.i IS NULL;
SELECT * FROM
 t1 LEFT JOIN
 ( ( t2 LEFT JOIN
     t3
     ON t3.i = t2.i
   )
   JOIN t4
   ON t4.i=t2.i
 )
 ON t2.i = t1.i
 WHERE t3.i IS NULL;
SELECT * FROM
 t1 LEFT JOIN
 ( ( t2 LEFT JOIN
     t3
     ON t3.i = t2.i
   )
   JOIN (t4 AS t4a JOIN t4 AS t4b ON t4a.i=t4b.i)
   ON t4a.i=t2.i
 )
 ON t2.i = t1.i
 WHERE t3.i IS NULL;
SELECT * FROM
 t1 LEFT JOIN
 ( ( t2 LEFT JOIN
     t3
     ON t3.i = t2.i
   )
   JOIN (t4 AS t4a, t4 AS t4b)
   ON t4a.i=t2.i
 )
 ON t2.i = t1.i
 WHERE t3.i IS NULL;
DROP TABLE t1,t2,t3,t4;
CREATE TABLE h (pk INT NOT NULL, col_int_key INT);
INSERT INTO h VALUES (1,NULL),(4,2),(5,2),(3,4),(2,8);
CREATE TABLE m (pk INT NOT NULL, col_int_key INT);
INSERT INTO m VALUES (1,2),(2,7),(3,5),(4,7),(5,5),(6,NULL),(7,NULL),(8,9);
CREATE TABLE k (pk INT NOT NULL, col_int_key INT);
INSERT INTO k VALUES (1,9),(2,2),(3,5),(4,2),(5,7),(6,0),(7,5);
SELECT TABLE1.pk FROM k TABLE1
RIGHT JOIN h TABLE2 ON TABLE1.col_int_key=TABLE2.col_int_key
RIGHT JOIN m TABLE4 ON TABLE2.col_int_key=TABLE4.col_int_key;
SELECT TABLE1.pk FROM k TABLE1
RIGHT JOIN h TABLE2 ON TABLE1.col_int_key=TABLE2.col_int_key
RIGHT JOIN m TABLE4 ON TABLE2.col_int_key=TABLE4.col_int_key
WHERE TABLE1.pk IS NULL;
DROP TABLE h,m,k;
CREATE TABLE t1 ( a INT ) ENGINE = MYISAM;
INSERT INTO t1 VALUES (1);
PREPARE prep_stmt FROM '
 SELECT 1 AS f FROM t1
 LEFT JOIN t1 t2
  RIGHT JOIN t1 t3
    JOIN t1 t4
   ON 1
  ON 1
 ON 1
 GROUP BY f';
DROP TABLE t1;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (a int);
CREATE TABLE t3 (a int);
CREATE TABLE t4 (a int);
INSERT INTO t1 VALUES (null),(null);
DROP TABLE t1,t2,t3,t4;
CREATE TABLE t1 (
  pk INT NOT NULL,
  col_int_key INT,
  col_int INT,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
);
INSERT INTO t1 VALUES (6, -448724992, NULL);
CREATE TABLE t2 (
  col_int INT,
  col_varchar_10 VARCHAR(10)
);
INSERT INTO t2 VALUES (6,'afasdkiyum');
CREATE TABLE t3 (
  col_varchar_10 VARCHAR(10),
  col_int INT
);
CREATE TABLE t4 (
  pk INT NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t4 VALUES (1);
INSERT INTO t4 VALUES (2);
SELECT t1.col_int
FROM t1
  LEFT JOIN t2
    LEFT JOIN t3
      JOIN t4
      ON t3.col_int  = t4.pk
    ON t2.col_varchar_10 = t3.col_varchar_10
  ON t2.col_int = t1.pk
WHERE   t1.col_int_key IS NULL OR t4.pk < t3.col_int;
DROP TABLE t1,t2,t3,t4;
CREATE TABLE t1 (pk int(11));
PREPARE prep_stmt_9846 FROM '
SELECT alias1.pk AS field1 FROM
t1 AS alias1
LEFT JOIN
( 
  t1 AS alias2
  RIGHT  JOIN
  ( 
    t1 AS alias3
    JOIN t1 AS alias4
    ON 1
  )
  ON 1
)
ON 1
GROUP BY field1';
deallocate prepare prep_stmt_9846;
drop table t1;
CREATE TABLE t1 (
  col_varchar_10 VARCHAR(10),
  col_int_key INTEGER,
  col_varchar_10_key VARCHAR(10),
  pk INTEGER NOT NULL,
  PRIMARY KEY (pk),
  KEY (col_int_key),
  KEY (col_varchar_10_key)
);
INSERT INTO t1 VALUES ('q',NULL,'o',1);
CREATE TABLE t2 (
  pk INTEGER NOT NULL AUTO_INCREMENT,
  col_varchar_10_key VARCHAR(10),
  col_int_key INTEGER,
  col_varchar_10 VARCHAR(10),
  PRIMARY KEY (pk),
  KEY (col_varchar_10_key),
  KEY col_int_key (col_int_key)
);
INSERT INTO t2 VALUES
(1,'r',NULL,'would'),(2,'tell',-655032320,'t'),
(3,'d',9,'a'),(4,'gvafasdkiy',6,'ugvafasdki'),
(5,'that\'s',NULL,'she'),(6,'bwftwugvaf',7,'cbwftwugva'),
(7,'f',-700055552,'mkacbwftwu'),(8,'a',9,'be'),
(9,'d',NULL,'u'),(10,'ckiixcsxmk',NULL,'o');
SELECT DISTINCT t2.col_int_key 
FROM
t1
LEFT JOIN t2
ON t1.col_varchar_10 = t2.col_varchar_10_key 
WHERE t2.pk
ORDER BY t2.col_int_key;
DROP TABLE t1,t2;
CREATE TABLE t1 (i1 int);
INSERT INTO t1 VALUES (100), (101);
CREATE TABLE t2 (i2 int, i3 int);
INSERT INTO t2 VALUES (20,1),(10,2);
CREATE TABLE t3 (i4 int(11));
INSERT INTO t3 VALUES (1),(2);
drop table t1,t2,t3;
CREATE TABLE t1 (
  pk int(11) NOT NULL,
  col_varchar_10_latin1_key varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES (1,'1');
CREATE TABLE t2 (
  pk int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t2 VALUES (1);
CREATE TABLE t3 (
  pk int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t3 VALUES (1);
CREATE TABLE t4 (
  pk int(11) NOT NULL,
  col_int int(11) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_varchar_10_latin1_key varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t4 VALUES (1,1,1,'1');
CREATE TABLE t5 (
  col_int int(11) DEFAULT NULL,
  col_varchar_10_utf8_key varchar(10) CHARACTER SET utf8mb3 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t5 VALUES (1,'1');
CREATE TABLE t6 (
  col_int_key int(11) DEFAULT NULL,
  col_varchar_10_latin1_key varchar(10) DEFAULT NULL,
  pk int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t6 VALUES (1,'1',1);
SELECT * FROM t5 LEFT JOIN t6 ON t5.col_int=1000
WHERE t6.col_int_key IS TRUE;
SELECT * FROM t5 LEFT JOIN t6 ON t5.col_int=1000
WHERE t6.col_int_key IS NOT TRUE;
drop table t1,t2,t3,t4,t5,t6;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT NOT NULL);
INSERT INTO t1 VALUES(1),(2);
INSERT INTO t2 VALUES(1),(2);
DROP TABLE t1,t2;
CREATE TABLE t1 (p1 INT PRIMARY KEY, a CHAR(1));
CREATE TABLE t2 (p2 INT PRIMARY KEY, b CHAR(1));
INSERT INTO t1 VALUES (1,'a'),(2,'b'),(3,'c');
INSERT INTO t2 VALUES (1,'h'),(2,'i'),(3,'j'),(4,'k');
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
DROP VIEW v1, v2;
DROP TABLE t1, t2;
CREATE TABLE t1 (ik INT, vc varchar(1)) charset utf8mb4 ENGINE=Innodb;
SELECT straight_join t1.vc, t1.ik
FROM t1 JOIN t1 AS t2 ON t1.vc=t2.vc LEFT JOIN t1 AS t3 ON t1.vc=t3.vc;
DROP TABLE t1;
CREATE TABLE t1(a INT) ENGINE=INNODB;
DROP TABLE t1;
create table t1(a int, unique key(a)) engine=innodb;
insert into t1 values(1);
select * from t1 left join t1 as t2
              on t2.a=12
         where t1.a=1;
drop table t1;
CREATE TABLE t1 (
  pk INT,
  col_int_key INT,
  col_varchar_key VARCHAR(1),
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key, col_int_key)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES (23,4,'d');
INSERT INTO t1 VALUES (24,8,'g');
INSERT INTO t1 VALUES (25,NULL,'x');
INSERT INTO t1 VALUES (26,NULL,'f');
INSERT INTO t1 VALUES (27,0,'p');
INSERT INTO t1 VALUES (28,NULL,'j');
INSERT INTO t1 VALUES (29,8,'c');
CREATE TABLE t2 (
  pk INT,
  col_int_key INT,
  col_varchar_key VARCHAR(1),
  PRIMARY KEY (pk)
) ENGINE=MyISAM;
SELECT 9
  FROM t1 AS table1
    RIGHT JOIN t1 AS table2
    ON table2.col_int_key = table1.col_int_key
      AND table1.col_varchar_key = (
        SELECT subquery2_t2.col_varchar_key
        FROM t2
          STRAIGHT_JOIN ( t2 AS subquery2_t2
            JOIN t1 AS subquery2_t3
          ) ON ( subquery2_t3.col_int_key = subquery2_t2.pk )
      );
CREATE TABLE a (id INTEGER);
CREATE TABLE b (id INTEGER);
CREATE ALGORITHM=MERGE VIEW vmerge AS SELECT 1 AS id, id AS b_id FROM b;
CREATE ALGORITHM=TEMPTABLE VIEW vmat AS SELECT 1 AS id, id AS b_id FROM b;
INSERT INTO a(id) VALUES (1);
SELECT *
FROM a LEFT JOIN vmerge AS v ON a.id = v.id;
SELECT *
FROM a LEFT JOIN vmat AS v ON a.id = v.id;
SELECT *
FROM a LEFT JOIN (SELECT 1 AS one, id FROM b) AS v ON a.id = v.id;
SELECT *
FROM a LEFT JOIN (SELECT DISTINCT 1 AS one, id FROM b) AS v ON a.id = v.id;
SELECT *
FROM a LEFT JOIN vmerge AS v ON a.id = v.id
UNION DISTINCT
SELECT *
FROM a LEFT JOIN vmerge AS v ON a.id = v.id;
SELECT *
FROM a LEFT JOIN vmerge AS v ON a.id = v.id
UNION ALL
SELECT *
FROM a LEFT JOIN vmerge AS v ON a.id = v.id;
DROP VIEW vmerge, vmat;
DROP TABLE a, b;
CREATE TABLE small (
  id INTEGER not null,
  PRIMARY KEY (id)
);
CREATE TABLE big (
  id INTEGER not null,
  PRIMARY KEY (id)
);
INSERT INTO small VALUES (1), (2);
INSERT INTO big VALUES (1), (2), (3), (4);
CREATE VIEW small_view AS
SELECT *, IF (id % 2 = 1, 1, 0) AS is_odd
FROM small;
CREATE VIEW big_view AS
SELECT big.*, small_view.id AS small_id, small_view.is_odd
FROM big LEFT JOIN small_view ON small_view.id = big.id;
SELECT * FROM big_view;
SELECT big.*, small.id AS small_id, small.is_odd
FROM big LEFT JOIN
     (SELECT id, IF (id % 2 = 1, 1, 0) AS is_odd FROM small) AS small
     ON big.id = small.id;
SELECT big.*, dt.*
FROM big LEFT JOIN (SELECT id as dt_id,
                           id IS NULL AS nul,
                           id IS NOT NULL AS nnul,
                           id IS TRUE AS t,
                           id IS NOT TRUE AS nt,
                           id IS FALSE AS f,
                           id IS NOT FALSE AS nf,
                           id IS UNKNOWN AS u,
                           id IS NOT UNKNOWN AS nu
                    FROM small) AS dt
     ON big.id=dt.dt_id;
SELECT big.*, dt.*
FROM big LEFT JOIN (SELECT id as dt_id,
                           id = 1 AS eq,
                           id <> 1 AS ne,
                           id > 1 AS gt,
                           id >= 1 AS ge,
                           id < 1 AS lt,
                           id <= 1 AS le,
                           id <=> 1 AS equal
                    FROM small) AS dt
     ON big.id=dt.dt_id;
SELECT big.*, dt.*
FROM big LEFT JOIN (SELECT id as dt_id,
                           CASE id WHEN 0 THEN 0 ELSE 1 END AS simple,
                           CASE WHEN id=0 THEN NULL ELSE 1 END AS cond,
                           NULLIF(1, NULL) AS nullif,
                           IFNULL(1, NULL) AS ifnull,
                           COALESCE(id) AS coal,
                           INTERVAL(NULL, 1, 2, 3) as intv,
                           IF (id % 2 = 1, NULL, 1) AS iff
                    FROM small) AS dt
     ON big.id=dt.dt_id;
DROP VIEW small_view, big_view;
DROP TABLE small, big;
DROP TABLE t1,t2;
CREATE TABLE t1(c1 INT,	c2 INT,	c3 CHAR(1), KEY(c3))ENGINE=InnoDB;
CREATE TABLE t2(c1 INT,	c2 INT,	c3 CHAR(1), KEY(c3))ENGINE=InnoDB;
SELECT b.c2 AS f1 FROM (t2 AS a JOIN
                        ((t2 AS b JOIN t2 AS c ON (c.c3=b.c3)))
                        ON (c.c1=b.c2))
     WHERE (c.c3 IN (SELECT subquery1_b.c3 AS subquery1_f1
                     FROM (t1 AS subquery1_a JOIN t2 AS subquery1_b ON
                           (subquery1_b.c1=subquery1_a.c1)))) AND
           (a.c1=a.c1 AND (SELECT''FROM DUAL) IS NULL);
DROP TABLE t1, t2;
CREATE TABLE t1 (
  col_int INT,
  pk INT NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t1 VALUES
 (2,1), (2,2), (6,3), (4,4), (7,5),
 (188,6), (0,7), (6,8), (0,9), (9,10);
CREATE TABLE t2 (
  pk INT NOT NULL,
  col_int INT,
  PRIMARY KEY (pk)
);
INSERT INTO t2 VALUES
 (1,0), (2,0), (3,2), (4,NULL), (5,2),
 (6,3), (7,3), (8,100), (9,3), (10,6);
SELECT table2.pk, table1.col_int
FROM t2 AS table1
     LEFT JOIN t1 AS table2
     ON table2.pk < table1.col_int AND
        table2.pk = table1.col_int;
SELECT table2.pk, table1.col_int
FROM t2 AS table1
     LEFT JOIN (SELECT * FROM t1) AS table2
     ON table2.pk < table1.col_int AND
        table2.pk = table1.col_int;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  col_int INT DEFAULT NULL,
  col_int_key INT DEFAULT NULL,
  pk INT NOT NULL,
  PRIMARY KEY (pk),
  KEY test_idx (col_int_key,col_int)
);
INSERT INTO t1 VALUES (0, -7, 1), (9, NULL, 15), (182, NULL, 25);
CREATE TABLE t2 (
  col_int INT DEFAULT NULL,
  pk INT NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t2 VALUES (NULL, 4), (-208, 5), (5, 6), (NULL, 75);
CREATE TABLE t3 (
  col_datetime_key DATETIME DEFAULT NULL,
  pk INT NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t3 VALUES ('1970-01-01 00:00:00', 5);
CREATE TABLE t4 (
  col_int INT DEFAULT NULL,
  pk INT NOT NULL,
  col_int_key INT DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
);
INSERT INTO t4 VALUES (0, 15, 6), (9, 16, 6);
SELECT alias2.col_datetime_key
FROM
    t1 AS alias1
      LEFT JOIN t3 AS alias2
        LEFT JOIN t2 AS alias3
          LEFT JOIN t4 AS alias4
          ON alias3.pk = alias4.col_int_key
        ON alias2.pk = alias3.col_int
      ON alias1.col_int = alias4.col_int;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE ta (
  a1 varchar(1024) NOT NULL,
  a2 int NOT NULL,
  KEY user_id(a2)
);
INSERT INTO ta (a1, a2) VALUES ('row1', 4), ('row2', 4);
CREATE TABLE tb (
  b1 int NOT NULL,
  b2 varchar(1024) NOT NULL,
  b3 int NOT NULL,
  PRIMARY KEY (b1)
);
INSERT INTO tb (b1, b2, b3) VALUES
 (1, 'text1', 0), (2, 'text2', 0), (3, 'text3', 1), (4, 'text4', 1);
SELECT ta.a1, tb.b1, tb.b2
FROM ta LEFT OUTER JOIN tb
     ON ta.a2 = tb.b1 AND tb.b3 = 0;
DROP TABLE ta, tb;
CREATE TABLE m (
  machineid VARCHAR(32) NOT NULL,
  orderid bigint unsigned DEFAULT NULL,
  extra bigint unsigned DEFAULT NULL,
  PRIMARY KEY (machineid)
);
INSERT INTO m (machineid, orderid)
VALUES ('m1', NULL), ('m2', 2), ('m3', NULL), ('m4', NULL);
CREATE TABLE o (
  orderid bigint unsigned NOT NULL,
  machineid VARCHAR(32) DEFAULT NULL,
  PRIMARY KEY (orderid)
);
INSERT INTO o (orderid, machineid)
VALUES (1, 'm2'), (2, 'm2');
SELECT o.*,'|' as sep, m.*
FROM o LEFT JOIN m
     ON m.machineid = o.machineid AND
        m.orderid = o.orderid;
DROP TABLE m, o;
CREATE TABLE t1 (
  adslot varchar(5) NOT NULL
);
INSERT INTO t1(adslot) VALUES ('1'), ('2'), ('3');
CREATE TABLE t2 (
  ionumber varchar(20) NOT NULL,
  adslot varchar(5) NOT NULL
);
INSERT INTO t2 (ionumber, adslot) VALUES ('01602', 1), ('01602', 3);
CREATE TABLE t3 (
  ionumber varchar(20) NOT NULL,
  ioattribute varchar(5) NOT NULL,
  PRIMARY KEY (ionumber)
);
INSERT INTO t3 VALUES ('01602', 'BOB'), ('01603', 'SALLY');
SELECT s.adslot, lid.ionumber1, lid.ionumber2, lid.ioattribute
FROM t1 s LEFT JOIN
     (SELECT lid.adslot,
             i.ionumber as ionumber1,
             lid.ionumber as ionumber2,
             i.ioattribute
      FROM t2 lid JOIN t3 i
           USING (ionumber)
     ) AS lid
    USING (adslot);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (a INT);
INSERT t1 values (1),(2),(15),(24),(5);
CREATE TABLE t2 (t1_a INT, b VARCHAR(10));
SELECT t1.a, subq.st_value
FROM t1
LEFT JOIN (SELECT t2.t1_a, 'red' AS st_value
           FROM t2) AS subq
  ON subq.t1_a = t1.a;
SELECT t1.a, subq.st_value
FROM t1
LEFT JOIN (SELECT t2.t1_a, 'red' AS st_value
           FROM t2) AS subq
  ON subq.t1_a = t1.a
ORDER BY t1.a;
SELECT t1.a, subq.st_value
FROM (SELECT t2.t1_a, 'red' AS st_value
      FROM t2) AS subq
LEFT JOIN t1
  ON subq.t1_a = t1.a
ORDER BY t1.a;
DROP TABLE t1, t2;
CREATE TABLE t1 (i INT NOT NULL);
INSERT INTO t1 VALUES (0),(2),(3),(4);
CREATE TABLE t2 (i INT NOT NULL);
INSERT INTO t2 VALUES (0),(1),(3),(4);
CREATE TABLE t3 (i INT NOT NULL);
INSERT INTO t3 VALUES (0),(1),(2),(4);
CREATE TABLE t4 (i INT NOT NULL);
INSERT INTO t4 VALUES (0),(1),(2),(3);
SELECT *
FROM t1 LEFT JOIN
     (
       (t2 LEFT JOIN t3 ON t3.i= t2.i)
       LEFT JOIN t4 ON t3.i= t4.i
     )ON t2.i= t1.i;
SELECT *
FROM t1 LEFT JOIN
     (
       (t2 INNER JOIN t3 ON t3.i= t2.i)
       LEFT JOIN t4 ON t3.i= t4.i
     )ON t2.i= t1.i;
SELECT *
FROM t1 LEFT JOIN t2 ON t2.i= t1.i
        LEFT JOIN t3 ON t3.i= t2.i
        LEFT JOIN t4 ON t3.i= t4.i;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (id INT);
CREATE TABLE t2 (id INT);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1);
SELECT *
FROM (SELECT id
      FROM t1) AS a
    LEFT JOIN
    (SELECT id, 2 AS tall
     FROM t2) AS b
    ON a.id = b.id
WHERE b.tall IS NOT NULL;
DROP TABLE t1, t2;
CREATE TABLE t1(doc text);
CREATE TABLE t2(a INTEGER DEFAULT NULL);
INSERT INTO t2 VALUES(1);
SELECT je
FROM t2 LEFT JOIN (SELECT 1 AS je FROM t1 LIMIT 1) AS dt ON FALSE;
SELECT je
FROM t2 LEFT JOIN (SELECT 1 AS je FROM t1 LIMIT 1) AS dt ON FALSE
GROUP BY je;
SELECT je
FROM t2 LEFT JOIN (SELECT 1 AS je FROM t1) AS dt ON FALSE;
SELECT je
FROM t2 LEFT JOIN (SELECT 1 AS je FROM t1) AS dt ON FALSE
GROUP BY je;
DROP TABLE t1, t2;
SELECT (SELECT * FROM (SELECT 'a') t) AS f1 HAVING (f1 = 'a' OR TRUE);
SELECT (SELECT * FROM (SELECT 'a') t) + 1 AS f1 HAVING (f1 = 'a' OR TRUE);
SELECT 1 + (SELECT * FROM (SELECT 'a') t) AS f1 HAVING (f1 = 'a' OR TRUE);
CREATE TABLE t1 (pk INTEGER, f1 INTEGER, primary key(pk));
CREATE TABLE t2 (pk INTEGER, f1 INTEGER, primary key(pk));
CREATE TABLE t3 (pk INTEGER);
INSERT INTO t1 VALUES (1,1),(2,1),(3,1);
INSERT INTO t2 VALUES (1,1),(2,1),(3,1);
INSERT INTO t3 VALUES (1);
SELECT  * FROM (t1 RIGHT JOIN
                (SELECT * FROM t3 WHERE (DAYNAME('1995')))  AS table2 ON
                (( t1.f1 ,t1.pk) IN (SELECT 7,4 UNION SELECT 9,2))) WHERE
(NOT EXISTS (SELECT t1.f1 FROM (t1 INNER JOIN t2 ON (t1.pk=t2.f1))
             WHERE 0 IS NOT NULL)) AND t1.f1 >  50;
DROP TABLE t3,t1,t2;
CREATE TABLE t1 (col_varchar varchar(1) DEFAULT NULL);
INSERT INTO t1 VALUES ('Z');
CREATE TABLE t2 (col_varchar varchar(1) DEFAULT NULL);
INSERT INTO t2 VALUES ('Z');
PREPARE prep_stmt FROM " SELECT 1 FROM ( ( SELECT * FROM t1 WHERE col_varchar
>= 1 )  AS table1 RIGHT JOIN t2 ON ( ( NULL < NULL ) IS NULL OR 1 = 0 ) ) ";
DROP TABLE t1,t2;
CREATE TABLE t1(c1 INT);
INSERT INTO t1 VALUES(1),(2);
CREATE TABLE t2(c2 INT);
INSERT INTO t2 VALUES(1);
SELECT * FROM t1 LEFT JOIN t2 ON c1=c2;
SELECT * FROM t1 LEFT JOIN t2 ON c1=c2 WHERE c2 IS NULL;
SELECT * FROM t1 LEFT JOIN t2 ON c1=c2 WHERE c2 IS NOT NULL;
SELECT * FROM t1 LEFT JOIN t2 ON c1=c2 WHERE (c2 IS NOT NULL) = 1;
SELECT * FROM t1 LEFT JOIN t2 ON c1=c2 WHERE (c2 IS NOT NULL) IS TRUE;
SELECT * FROM t1 LEFT JOIN t2 ON c1=c2 WHERE (c2 IS NOT NULL) = 0;
SELECT * FROM t1 LEFT JOIN t2 ON c1=c2 WHERE (c2 IS NOT NULL) IS FALSE;
DROP TABLE t1,t2;
CREATE TABLE t1 (
  pk int primary key auto_increment,
  col_int_unique int unique
) ENGINE=InnoDB;
INSERT INTO t1(col_int_unique) values (6),(7);
CREATE TABLE t2 (
  pk int primary key auto_increment,
  col_int_key int(11) DEFAULT NULL,
  col_int_unique int(11) DEFAULT NULL,
  UNIQUE KEY `ix2` (col_int_key,col_int_unique),
  KEY col_int_key (col_int_key)
) ENGINE=InnoDB;
CREATE TABLE t3 (
  pk int NOT NULL
) ENGINE=InnoDB;
INSERT INTO t3(pk) values (6),(7);
SELECT STRAIGHT_JOIN t1.col_int_unique, t2.col_int_key, t3.pk
  FROM
    (t1 LEFT JOIN t2 ON t1.col_int_unique = t2.col_int_key)
        LEFT JOIN t3 ON t3.pk = t1.col_int_unique AND
	                t1.col_int_unique = t2.col_int_key;
DROP TABLE t1,t2,t3;
CREATE TABLE t1 (
  col_int_unique INT DEFAULT NULL,
  col_int_key INT DEFAULT NULL,
  UNIQUE KEY col_int_unique (col_int_unique)
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (5,0);
CREATE TABLE t2 (
  col_char_16_unique char(16) DEFAULT NULL,
  col_int_key INT DEFAULT NULL,
  col_int_unique INT DEFAULT NULL,
  UNIQUE KEY col_int_unique (col_int_unique)
) ENGINE=InnoDB;
INSERT INTO t2 VALUES ("just",21,5);
CREATE TABLE t3 (
  col_int INT DEFAULT NULL,
  col_char_16_unique CHAR(16) DEFAULT NULL,
  UNIQUE KEY col_char_16_unique (col_char_16_unique)
) ENGINE=InnoDB;
INSERT INTO t3 VALUES (9,"foo");
CREATE TABLE t4 (
  col_int INT DEFAULT NULL,
  col_int_unique INT DEFAULT NULL,
  UNIQUE KEY col_int_unique (col_int_unique)
) ENGINE=InnoDB;
INSERT INTO t4 VALUES (9,5);
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (
  pk INTEGER NOT NULL
);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (2);
CREATE TABLE t2 (
  pk INTEGER NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t2 VALUES (3);
CREATE TABLE t3 (
  f1 INTEGER,
  f2 INTEGER,
  KEY k2 (f2)
);
INSERT INTO t3 VALUES (NULL,NULL);
INSERT INTO t3 VALUES (NULL,295010100);
INSERT INTO t3 VALUES (NULL,NULL);
INSERT INTO t3 VALUES (NULL,-1762438755);
INSERT INTO t3 VALUES (NULL,4);
SELECT * FROM t1 LEFT JOIN t2 ON t1.pk = t2.pk LEFT JOIN t3 ON t2.pk = t3.f2 WHERE t2.pk < 5;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  col_int INTEGER,
  a INTEGER,
  b varchar(10),
  KEY key_a (a)
);
INSERT INTO t1 VALUES (5,NULL,'p');
INSERT INTO t1 VALUES (6,NULL,'');
INSERT INTO t1 VALUES (7,NULL,'');
INSERT INTO t1 VALUES (8,NULL,'Z');
INSERT INTO t1 VALUES (9,4,'g');
INSERT INTO t1 VALUES (10,NULL,'if');
INSERT INTO t1 VALUES (11,NULL,'j');
INSERT INTO t1 VALUES (12,9,'');
CREATE TABLE t2 (
  a INTEGER,
  b varchar(10),
  KEY key_b (b)
);
INSERT INTO t2 VALUES (1,'j');
INSERT INTO t2 VALUES (2,'o');
INSERT INTO t2 VALUES (3,'z');
INSERT INTO t2 VALUES (4,'really');
SELECT t1.col_int as t1_ci, t1.a as t1_a, t1.b as t1_b, t2.a as t2_a, t2.b as t2_b, t3.col_int as t3_ci, t3.a as t3_a, t3.b as t3_b
  FROM t1
  LEFT JOIN ( t2 LEFT JOIN t1 AS t3 ON t2.a=t3.a )
    ON t1.b = t2.b;
DROP TABLE t1, t2;
CREATE TABLE t1 ( f1 INTEGER );
INSERT INTO t1 VALUES (1), (2), (3), (4), (5);
CREATE TABLE t2 AS SELECT * FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  id INTEGER NOT NULL,
  b INTEGER,
  PRIMARY KEY (id)
);
INSERT INTO t1 VALUES (17,NULL);
INSERT INTO t1 VALUES (136,564);
INSERT INTO t1 VALUES (137,NULL);
CREATE TABLE t2 (
  id INTEGER NOT NULL,
  PRIMARY KEY (id)
);
INSERT INTO t2 VALUES (564);
SELECT * FROM t1 LEFT JOIN t2 ON t1.b = t2.id GROUP BY t1.id;
DROP TABLE t1, t2;
CREATE TABLE t1 (x INTEGER);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (x INTEGER);
INSERT INTO t2 VALUES (1), (2), (3), (4);
DROP TABLE t1, t2;
CREATE TABLE t1 (f1 INT, f2 INT);
CREATE TABLE t2 (f1 INT, f2 INT);
CREATE TABLE t3 (f1 INT, f2 INT);
INSERT INTO t1 VALUES(1, 10), (2, 20), (3, 30), (4, 40);
INSERT INTO t2 VALUES(1, 10), (2, 20), (5, 30), (6, 40);
INSERT INTO t3 VALUES(1, 20), (3, 30), (7, 40), (8, 50);
SELECT t1.f1
FROM t1 JOIN t2 ON t1.f1 = t2.f2 AND 1=2;
SELECT t1.f1
FROM t1 JOIN t2 ON t1.f1 = t2.f2
WHERE 1=2;
SELECT t1.f1
FROM t1 JOIN t2 ON t1.f1 = t2.f2 AND 1=2 JOIN t3 ON t2.f1=t3.f1 AND 1=2;
SELECT t1.f1
FROM t1 JOIN t2 ON t1.f1 = t2.f2 JOIN t3 ON t2.f1=t3.f1
WHERE 1=2;
SELECT t1.f1,t2.f1
FROM t1 LEFT JOIN t2 ON t1.f1=t2.f1 AND t1.f2=t2.f2 AND 1=2;
SELECT t1.f1,t2.f1
FROM t1 LEFT JOIN t2 ON t1.f1=t2.f1 AND t1.f2=t2.f2
WHERE 1=2;
SELECT t1.f1,t2.f1
FROM t1 LEFT JOIN t2 ON t1.f1=t2.f1 AND 1=2 LEFT JOIN t3 ON t2.f1=t3.f1 AND 1=2;
SELECT t1.f1,t2.f1
FROM t1 LEFT JOIN t2 ON t1.f1=t2.f1 AND 1=2 LEFT JOIN t3 ON t2.f1=t3.f1
WHERE 1=2;
SELECT f1,f2
FROM t1 WHERE EXISTS (SELECT t2.f1,t2.f2 FROM t2 WHERE 1=2);
SELECT f1,f2
FROM t1 WHERE NOT EXISTS (SELECT t2.f1,t2.f2 FROM t2 WHERE 1=2);
SELECT t2.f1,t2.f2
FROM t1 RIGHT JOIN t2 ON t1.f1=t2.f1 AND 1=2;
SELECT t2.f1,t2.f2
FROM t1 RIGHT JOIN t2 ON t1.f1=t2.f1 AND 1=2
WHERE t1.f1>NULL;
SELECT t3.f1
FROM t1 JOIN t2 ON t1.f1=t2.f1 AND 1=2 LEFT JOIN t3 ON t1.f1=t3.f1 AND 1=2
WHERE 1=2;
SELECT t3.f1
FROM t1 JOIN t2 ON t1.f1=t2.f1 LEFT JOIN t3 ON t1.f1=t3.f1 AND 1=2;
SELECT t2.f1
FROM t1 RIGHT JOIN t2 ON t1.f1=t2.f1 AND 1=2 LEFT JOIN t3 ON t1.f1=t3.f1 AND 1=2;
DROP TABLES t1,t2,t3;
CREATE TABLE t0(c0 INT);
CREATE TABLE t1(c0 INT);
CREATE TABLE t2(c0 INT);
INSERT INTO t0 VALUES (1), (2);
INSERT INTO t2 VALUES (3);
SELECT *
FROM t0 LEFT JOIN t1 ON FALSE
     RIGHT JOIN t2 ON (t1.c0 IS NOT NULL) = (t2.c0 = 1000);
DROP TABLE t0, t1, t2;
