drop table if exists t1,t2,t3,t4,t9,`t1a``b`,v1,v2,v3,v4,v5,v6;
drop view if exists t1,t2,`t1a``b`,v1,v2,v3,v4,v5,v6;
drop database if exists mysqltest;
create temporary table t1 (a int, b int);
drop table t1;
create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);
create view v1 (c) as select b+1 from t1;
select c from v1;
select is_updatable from information_schema.views where table_name='v1';
create temporary table t1 (a int, b int);
select * from t1;
select c from v1;
drop table t1;
create algorithm=temptable view v2 (c) as select b+1 from t1;
select c from v2;
create view v3 (c) as select c+1 from v1;
select c from v3;
create algorithm=temptable view v4 (c) as select c+1 from v2;
select c from v4;
create view v5 (c) as select c+1 from v2;
select c from v5;
create algorithm=temptable view v6 (c) as select c+1 from v1;
select c from v6;
drop view v1,v2,v3,v4,v5,v6;
create view v1 (c,d,e,f) as select a,b,
a in (select a+2 from t1), a = all (select a from t1) from t1;
create view v2 as select c, d from v1;
select * from v1;
select * from v2;
create or replace view v1 (c,d,e,f) as select a,b, a in (select a+2 from t1), a = all (select a from t1) from t1;
drop view v2;
create or replace view v2 as select c, d from v1;
alter view v1 (c,d) as select a,max(b) from t1 group by a;
select * from v1;
select * from v2;
drop view v1,v2;
drop table t1;
create table t1 (a int);
insert into t1 values (1), (2), (3);
create view v1 (a) as select a+1 from t1;
create view v2 (a) as select a-1 from t1;
select * from t1 natural left join v1;
select * from v2 natural left join t1;
select * from v2 natural left join v1;
drop view v1, v2;
drop table t1;
create table t1 (a int);
insert into t1 values (1), (2), (3), (1), (2), (3);
create view v1 as select distinct a from t1;
select * from v1;
select * from t1;
drop view v1;
drop table t1;
create table t1 (a int);
create view v1 as select a from t1 WITH CHECK OPTION;
create view v2 as select a from t1 WITH CASCADED CHECK OPTION;
create view v3 as select a from t1 WITH LOCAL CHECK OPTION;
drop view v3 RESTRICT;
drop view v2 CASCADE;
drop view v1;
drop table t1;
create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);
create view v1 (c) as select b+1 from t1;
select test.c from v1 test;
create algorithm=temptable view v2 (c) as select b+1 from t1;
select test.c from v2 test;
select test1.* from v1 test1, v2 test2 where test1.c=test2.c;
select test2.* from v1 test1, v2 test2 where test1.c=test2.c;
drop table t1;
drop view v1,v2;
create table t1 (a int);
insert into t1 values (1), (2), (3), (4);
create view v1 as select a+1 from t1 order by 1 desc limit 2;
select * from v1;
drop view v1;
drop table t1;
create table t1 (a int);
insert into t1 values (1), (2), (3), (4);
create view v1 as select a+1 from t1;
create table t2 select * from v1;
select * from t2;
drop view v1;
drop table t1,t2;
create table t1 (a int, b int, primary key(a));
insert into t1 values (10,2), (20,3), (30,4), (40,5), (50,10);
create view v1 (a,c) as select a, b+1 from t1;
create algorithm=temptable view v2 (a,c) as select a, b+1 from t1;
select is_updatable from information_schema.views where table_name='v2';
select is_updatable from information_schema.views where table_name='v1';
update v1 set a=a+c;
select * from v1;
select * from t1;
drop table t1;
drop view v1,v2;
create table t1 (a int, b int, primary key(a));
insert into t1 values (10,2), (20,3), (30,4), (40,5), (50,10);
create table t2 (x int);
insert into t2 values (10), (20);
create view v1 (a,c) as select a, b+1 from t1;
create algorithm=temptable view v2 (a,c) as select a, b+1 from t1;
update t2,v1 set v1.a=v1.a+v1.c where t2.x=v1.a;
select * from v1;
select * from t1;
drop table t1,t2;
drop view v1,v2;
create table t1 (a int, b int, primary key(b));
insert into t1 values (1,20), (2,30), (3,40), (4,50), (5,100);
create view v1 (c) as select b from t1 where a<3;
select * from v1;
update v1 set c=c+1;
select * from t1;
create view v2 (c) as select b from t1 where a>=3;
select * from v1, v2;
drop view v1, v2;
drop table t1;
create table t1 (a int, b int, primary key(a));
insert into t1 values (1,2), (2,3), (3,4), (4,5), (5,10);
create view v1 (a,c) as select a, b+1 from t1;
create algorithm=temptable view v2 (a,c) as select a, b+1 from t1;
delete from v1 where c < 4;
select * from v1;
select * from t1;
drop table t1;
drop view v1,v2;
create table t1 (a int, b int, primary key(a));
insert into t1 values (1,2), (2,3), (3,4), (4,5), (5,10);
create table t2 (x int);
insert into t2 values (1), (2), (3), (4);
create view v1 (a,c) as select a, b+1 from t1;
create algorithm=temptable view v2 (a,c) as select a, b+1 from t1;
delete v1 from t2,v1 where t2.x=v1.a;
select * from v1;
select * from t1;
drop table t1,t2;
drop view v1,v2;
create table t1 (a int, b int, c int, primary key(a,b));
insert into t1 values (10,2,-1), (20,3,-2), (30,4,-3), (40,5,-4), (50,10,-5);
create view v1 (x,y) as select a, b from t1;
create view v2 (x,y) as select a, c from t1;
update v1 set x=x+1;
update v2 set x=x+1;
update v1 set x=x+1 limit 1;
update v2 set x=x+1 limit 1;
delete from v2 limit 1;
update v1 set x=x+1 limit 1;
update v2 set x=x+1 limit 1;
select * from t1;
drop table t1;
drop view v1,v2;
create table t1 (a int, b int, c int, primary key(a,b));
insert into t1 values (10,2,-1), (20,3,-2);
create view v1 (x,y,z) as select c, b, a from t1;
create view v2 (x,y) as select b, a from t1;
create view v3 (x,y,z) as select b, a, b from t1;
create view v4 (x,y,z) as select c+1, b, a from t1;
create algorithm=temptable view v5 (x,y,z) as select c, b, a from t1;
insert into v1 values (-60,4,30);
insert into v1 (z,y,x) values (50,6,-100);
insert into v2 values (5,40);
select * from t1;
drop table t1;
drop view v1,v2,v3,v4,v5;
create table t1 (a int, b int, c int, primary key(a,b));
insert into t1 values (10,2,-1), (20,3,-2);
create table t2 (a int, b int, c int, primary key(a,b));
insert into t2 values (30,4,-60);
create view v1 (x,y,z) as select c, b, a from t1;
create view v2 (x,y) as select b, a from t1;
create view v3 (x,y,z) as select b, a, b from t1;
create view v4 (x,y,z) as select c+1, b, a from t1;
create algorithm=temptable view v5 (x,y,z) as select c, b, a from t1;
insert into v1 select c, b, a from t2;
insert into v1 (z,y,x) select a+20,b+2,-100 from t2;
insert into v2 select b+1, a+10 from t2;
select * from t1;
drop table t1, t2;
drop view v1,v2,v3,v4,v5;
create table t1 (a int, primary key(a));
insert into t1 values (1), (2), (3);
create view v1 (x) as select a from t1 where a > 1;
select t1.a, v1.x from t1 left join v1 on (t1.a= v1.x);
drop table t1;
drop view v1;
create table t1 (a int, primary key(a));
insert into t1 values (1), (2), (3), (200);
create view v1 (x) as select a from t1 where a > 1;
create view v2 (y) as select x from v1 where x < 100;
select * from v2;
drop table t1;
drop view v1,v2;
create table t1 (a int, primary key(a));
insert into t1 values (1), (2), (3), (200);
create ALGORITHM=TEMPTABLE view v1 (x) as select a from t1;
create view v2 (y) as select x from v1;
drop table t1;
drop view v1,v2;
create table t1 (a int not null auto_increment, b int not null, primary key(a), unique(b));
create view v1 (x) as select b from t1;
insert into v1 values (1);
select last_insert_id();
insert into t1 (b) values (2);
select last_insert_id();
select * from t1;
drop view v1;
drop table t1;
create table t1 (t_column int);
create view v1 as select 'a';
select * from v1, t1;
drop view v1;
drop table t1;
create table `t1a``b` (col1 char(2));
create view v1 as select * from `t1a``b`;
select * from v1;
drop view v1;
drop table `t1a``b`;
create table t1 (col1 char(5),col2 char(5));
create view v1 as select * from t1;
drop table t1;
create table t1 (col1 char(5),newcol2 char(5));
drop table t1;
drop view v1;
create table t1 (col1 int,col2 char(22));
insert into t1 values(5,'Hello, world of views');
create view v1 as select * from t1;
create view v2 as select * from v1;
update v2 set col2='Hello, view world';
select is_updatable from information_schema.views where
table_schema != 'sys' and table_schema != 'information_schema';
select * from t1;
drop view v2, v1;
drop table t1;
create table t1 (a int, b int);
create view v1 as select a, sum(b) from t1 group by a;
drop view v1;
drop table t1;
create table t1 (col1 char(5),col2 char(5));
create view v1 (col1,col2) as select col1,col2 from t1;
insert into v1 values('s1','p1'),('s1','p2'),('s1','p3'),('s1','p4'),('s2','p1'),('s3','p2'),('s4','p4');
select distinct first.col2 from t1 first where first.col2 in (select second.col2 from t1 second where second.col1<>first.col1);
select distinct first.col2 from v1 first where first.col2 in (select second.col2 from t1 second where second.col1<>first.col1);
drop view v1;
drop table t1;
create table t1 (a int);
create view v1 as select a from t1;
insert into t1 values (1);
PREPARE stmt FROM 'UPDATE v1 SET a = ?';
DEALLOCATE PREPARE stmt;
PREPARE stmt FROM 'insert into v1 values (?)';
DEALLOCATE PREPARE stmt;
PREPARE stmt FROM 'insert into v1 (a) values (?)';
DEALLOCATE PREPARE stmt;
select * from t1;
drop view v1;
drop table t1;
CREATE VIEW v1 AS SELECT EXISTS (SELECT 1 UNION SELECT 2);
select * from v1;
drop view v1;
create table t1 (col1 int,col2 char(22));
create view v1 as select * from t1;
drop view v1;
drop table t1;
CREATE VIEW v1 (f1,f2,f3,f4) AS SELECT connection_id(), pi(), current_user(), version();
drop view v1;
create table t1 (s1 int);
create table t2 (s2 int);
insert into t1 values (1), (2);
insert into t2 values (2), (3);
create view v1 as select * from t1,t2 union all select * from t1,t2;
select * from v1;
drop view v1;
drop tables t1, t2;
create table t1 (col1 int);
insert into t1 values (1);
create view v1 as select count(*) from t1;
insert into t1 values (null);
select * from v1;
drop view v1;
drop table t1;
create table t1 (a int);
create table t2 (a int);
create view v1 as select a from t1;
create view v2 as select a from t2 where a in (select a from v1);
drop view v2, v1;
drop table t1, t2;
CREATE VIEW `v 1` AS select 5 AS `5`;
drop view `v 1`;
create database mysqltest;
create table mysqltest.t1 (a int, b int);
drop database mysqltest;
CREATE TABLE t1 (c1 int not null auto_increment primary key, c2 varchar(20), fulltext(c2));
insert into t1 (c2) VALUES ('real Beer'),('Water'),('Kossu'),('Coca-Cola'),('Vodka'),('Wine'),('almost real Beer');
select * from t1 WHERE match (c2) against ('Beer');
CREATE VIEW v1 AS SELECT  * from t1 WHERE match (c2) against ('Beer');
select * from v1;
drop view v1;
drop table t1;
create table t1 (a int);
insert into t1 values (1),(1),(2),(2),(3),(3);
create view v1 as select a from t1;
select distinct a from v1;
select distinct a from v1 limit 2;
select distinct a from t1 limit 2;
prepare stmt1 from "select distinct a from v1 limit 2";
deallocate prepare stmt1;
drop view v1;
drop table t1;
create table t1 (tg_column bigint);
create view v1 as select count(tg_column) as vg_column from t1;
select avg(vg_column) from v1;
drop view v1;
drop table t1;
create table t1 (col1 bigint not null, primary key (col1));
create table t2 (col1 bigint not null, key (col1));
create view v1 as select * from t1;
create view v2 as select * from t2;
insert into v1 values (1);
insert into v2 values (1);
create view v3 (a,b) as select v1.col1 as a, v2.col1 as b from v1, v2 where v1.col1 = v2.col1;
select * from v3;
drop view v3, v2, v1;
drop table t2, t1;
create table t2 (col1 char collate latin1_german2_ci);
create view v2 as select col1 collate latin1_german1_ci from t2;
drop view v2;
drop table t2;
create table t1 (a int);
insert into t1 values (1), (2);
create view v1 as select 5 from t1 order by 1;
select * from v1;
drop view v1;
drop table t1;
create table t1 (s1 int);
drop table t1;
create view v1 as select 99999999999999999999999999999999999999999999999999999 as col1;
drop view v1;
create table tÃÂÃÂ¼ (cÃÂÃÂ¼ char);
create view vÃÂÃÂ¼ as select cÃÂÃÂ¼ from tÃÂÃÂ¼;
select * from vÃÂÃÂ¼;
drop view vÃÂÃÂ¼;
drop table tÃÂÃÂ¼;
create table t1 (a int, b int);
insert into t1 values (1,2), (1,3), (2,4), (2,5), (3,10);
create view v1(c) as select a+1 from t1 where b >= 4;
select c from v1 where exists (select * from t1 where a=2 and b=c);
drop view v1;
drop table t1;
create view v1 as select cast(1 as char(3));
select * from v1;
drop view v1;
create table t1 (a int);
create view v1 as select a from t1;
create view v3 as select a from t1;
create database mysqltest;
drop table t1;
drop database mysqltest;
create table t1 (a int);
drop view v1;
drop table t1;
create table t1 (s1 int, primary key (s1));
create view v1 as select * from t1;
insert into v1 values (1) on duplicate key update s1 = 7;
insert into v1 values (1) on duplicate key update s1 = 7;
select * from t1;
drop view v1;
drop table t1;
create table t1 (col1 int);
create table t2 (col1 int);
create table t3 (col1 datetime not null);
create view v1 as select * from t1;
create view v2 as select * from v1;
create algorithm=temptable view v4 as select * from t1;
insert into t1 values (1),(2),(3);
insert into t1 (col1) values ((select max(col1) from v4));
select * from t1;
drop view v4,v3,v2,v1;
drop table t1,t2,t3;
create table t1 (s1 int);
create view v1 as select * from t1;
drop view v1;
drop table t1;
create table t1(a int);
insert into t1 values (0), (1), (2), (3);
create table t2 (a int);
insert into t2 select a from t1 where a > 1;
create view v1 as select a from t1 where a > 1;
select * from t1 left join (t2 as t, v1) on v1.a=t1.a;
select * from t1 left join (t2 as t, t2) on t2.a=t1.a;
drop view v1;
drop table t1, t2;
create table t1 (s1 char) charset latin1;
create view v1 as select s1 collate latin1_german1_ci as s1 from t1;
insert into v1 values ('a');
select * from v1;
update v1 set s1='b';
select * from v1;
update v1,t1 set v1.s1='c' where t1.s1=v1.s1;
select * from v1;
prepare stmt1 from "update v1,t1 set v1.s1=? where t1.s1=v1.s1";
select * from v1;
select * from v1;
deallocate prepare stmt1;
drop view v1;
drop table t1;
create table t1 (a int);
create table t2 (a int);
create view v1 as select * from t1;
lock tables t1 read, v1 read;
select * from v1;
unlock tables;
drop view v1;
drop table t1, t2;
create table t1 (a int);
create view v1 as select * from t1 where a < 2 with check option;
insert into v1 values(1);
insert ignore into v1 values (2),(3),(0);
select * from t1;
delete from t1;
insert into v1 SELECT 1;
create table t2 (a int);
insert into t2 values (2),(3),(0);
insert ignore into v1 SELECT a from t2;
select * from t1 order by a desc;
update v1 set a=-1 where a=0;
select * from t1 order by a desc;
update v1 set a=0 where a=0;
insert into t2 values (1);
update v1,t2 set v1.a=v1.a-1 where v1.a=t2.a;
select * from t1 order by a desc;
update v1 set a=a+1;
update ignore v1,t2 set v1.a=v1.a+1 where v1.a=t2.a;
select * from t1;
drop view v1;
drop table t1, t2;
create table t1 (a int);
create view v1 as select * from t1 where a < 2 with check option;
create view v2 as select * from v1 where a > 0 with local check option;
create view v3 as select * from v1 where a > 0 with cascaded check option;
insert into v2 values (1);
insert into v3 values (1);
select * from t1;
drop view v3,v2,v1;
drop table t1;
create table t1 (a int, primary key (a));
create view v1 as select * from t1 where a < 2 with check option;
insert into v1 values (1) on duplicate key update a=2;
insert ignore into v1 values (1) on duplicate key update a=2;
select * from t1;
drop view v1;
drop table t1;
create table t1 (s1 int);
create view v1 as select * from t1;
create view v2 as select * from v1;
drop view v2,v1;
drop table t1;
create table t1 (a int);
create view v1 as select * from t1;
alter algorithm=undefined view v1 as select * from t1 with check option;
alter algorithm=merge view v1 as select * from t1 with cascaded check option;
alter algorithm=temptable view v1 as select * from t1;
drop view v1;
drop table t1;
create table t1 (s1 int);
create table t2 (s1 int);
create view v2 as select * from t2 where s1 in (select s1 from t1);
insert into v2 values (5);
insert into t1 values (5);
select * from v2;
update v2 set s1 = 0;
select * from v2;
select * from t2;
alter view v2 as select * from t2 where s1 in (select s1 from t1) with check option;
insert into v2 values (5);
insert into t1 values (1);
update v2 set s1 = 1;
select * from v2;
select * from t2;
insert into t1 values (0);
drop view v2;
drop table t1, t2;
create table t1 (t time);
create view v1 as select substring_index(t,':',2) as t from t1;
insert into t1 (t) values ('12:24:10');
select substring_index(t,':',2) from t1;
select substring_index(t,':',2) from v1;
drop view v1;
drop table t1;
create table t1 (s1 tinyint);
create view v1 as select * from t1 where s1 <> 0 with local check option;
create view v2 as select * from v1 with cascaded check option;
drop view v2, v1;
drop table t1;
create table t1 (s1 int);
create view v1 as select * from t1 where s1 < 5 with check option;
insert ignore into v1 values (6);
insert ignore into v1 values (6),(3);
select * from t1;
drop view v1;
drop table t1;
create table t1 (s1 tinyint);
create view v1 as select * from t1 where s1 <> 127 with check option;
insert into v1 values (0);
select * from v1;
select * from t1;
drop view v1;
drop table t1;
create table t1 (s1 tinyint);
create view v1 as select * from t1 where s1 <> 0;
create view v2 as select * from v1 where s1 <> 1 with cascaded check option;
select * from v2;
select * from t1;
drop view v2, v1;
drop table t1;
create table t1 (a text, b text);
create view v1 as select * from t1 where a <> 'Field A' with check option;
select concat('|',a,'|'), concat('|',b,'|') from t1;
select concat('|',a,'|'), concat('|',b,'|') from v1;
delete from t1;
select concat('|',a,'|'), concat('|',b,'|') from t1;
select concat('|',a,'|'), concat('|',b,'|') from v1;
drop view v1;
drop table t1;
create table t1 (a int, b char(10)) charset latin1;
create view v1 as select * from t1 where a != 0 with check option;
select * from t1;
select * from v1;
delete from t1;
select * from t1;
select * from v1;
drop view v1;
drop table t1;
create table t1 (a text, b text);
create view v1 as select * from t1 where a <> 'Field A' with check option;
select concat('|',a,'|'), concat('|',b,'|') from t1;
select concat('|',a,'|'), concat('|',b,'|') from v1;
delete from t1;
select concat('|',a,'|'), concat('|',b,'|') from t1;
select concat('|',a,'|'), concat('|',b,'|') from v1;
drop view v1;
drop table t1;
create table t1 (s1 smallint);
create view v1 as select * from t1 where 20 < (select (s1) from t1);
create view v2 as select * from t1;
create view v3 as select * from t1 where 20 < (select (s1) from v2);
create view v4 as select * from v2 where 20 < (select (s1) from t1);
drop view v4, v3, v2, v1;
drop table t1;
create table t1 (a int);
create view v1 as select * from t1;
drop table t1;
drop view v1;
create table t1 (a int);
create table t2 (a int);
create table t3 (a int);
insert into t1 values (1), (2), (3);
insert into t2 values (1), (3);
insert into t3 values (1), (2), (4);
create view v3 (a,b) as select t1.a as a, t2.a as b from t1 left join t2 on (t1.a=t2.a);
select * from t3 left join v3 on (t3.a = v3.a);
create view v1 (a) as select a from t1;
create view v2 (a) as select a from t2;
create view v4 (a,b) as select v1.a as a, v2.a as b from v1 left join v2 on (v1.a=v2.a);
select * from t3 left join v4 on (t3.a = v4.a);
drop view v4,v3,v2,v1;
drop tables t1,t2,t3;
create table t1 (a int, primary key (a), b int);
create table t2 (a int, primary key (a));
insert into t1 values (1,100), (2,200);
insert into t2 values (1), (3);
create view v3 (a,b) as select t1.a as a, t2.a as b from t1, t2;
update v3 set a= 10 where a=1;
select * from t1;
select * from t2;
create view v2 (a,b) as select t1.b as a, t2.a as b from t1, t2;
select * from v3;
select * from v2;
prepare stmt1 from "update v3 set a= ? where a=?";
select * from v3;
select * from v3;
deallocate prepare stmt1;
drop view v3,v2;
drop tables t1,t2;
create table t1 (a int, primary key (a), b int);
create table t2 (a int, primary key (a), b int);
insert into t2 values (1000, 2000);
create view v3 (a,b) as select t1.a as a, t2.a as b from t1, t2;
insert into v3(a) values (1);
insert into v3(b) values (10);
insert into v3(a) select a from t2;
insert into v3(a) values (1) on duplicate key update a=a+10000+VALUES(a);
select * from t1;
select * from t2;
delete from t1;
select * from v3;
drop view v3;
drop tables t1,t2;
create table t1(f1 int);
create view v1 as select f1 from t1;
select * from v1 where F1 = 1;
drop view v1;
drop table t1;
create table t1(c1 int);
create table t2(c2 int);
insert into t1 values (1),(2),(3);
insert into t2 values (1);
SELECT c1 FROM t1 WHERE c1 IN (SELECT c2 FROM t2);
SELECT c1 FROM t1 WHERE EXISTS (SELECT c2 FROM t2 WHERE c2 = c1);
create view v1 as SELECT c1 FROM t1 WHERE c1 IN (SELECT c2 FROM t2);
create view v2 as SELECT c1 FROM t1 WHERE EXISTS (SELECT c2 FROM t2 WHERE c2 = c1);
select * from v1;
select * from v2;
select * from (select c1 from v2) X;
drop view v2, v1;
drop table t1, t2;
CREATE TABLE t1 (C1 INT, C2 INT);
CREATE TABLE t2 (C2 INT);
CREATE VIEW v1 AS SELECT C2 FROM t2;
CREATE VIEW v2 AS SELECT C1 FROM t1 LEFT OUTER JOIN v1 USING (C2);
SELECT * FROM v2;
drop view v2, v1;
drop table t1, t2;
create table t1 (col1 char(5),col2 int,col3 int);
insert into t1 values ('one',10,25), ('two',10,50), ('two',10,50), ('one',20,25), ('one',30,25);
create view v1 as select * from t1;
select col1,group_concat(col2,col3) from t1 group by col1;
select col1,group_concat(col2,col3) from v1 group by col1;
drop view v1;
drop table t1;
create table t1 (s1 int, s2 char);
create view v1 as select s1, s2 from t1;
select s2 from v1 vq1 where 2 = (select count(*) aa from v1 vq2 having vq1.s2 = aa);
drop view v1;
drop table t1;
CREATE TABLE t1 (a1 int);
CREATE TABLE t2 (a2 int);
INSERT INTO t1 VALUES (1), (2), (3), (4);
INSERT INTO t2 VALUES (1), (2), (3);
CREATE VIEW v1(a,b) AS SELECT a1,a2 FROM t1 JOIN t2 ON a1=a2 WHERE a1>1;
SELECT * FROM v1;
CREATE TABLE t3 SELECT * FROM v1;
SELECT * FROM t3;
DROP VIEW v1;
DROP TABLE t1,t2,t3;
create table t1 (a int);
create table t2 like t1;
create table t3 like t1;
create view v1 as select t1.a x, t2.a y from t1 join t2 where t1.a=t2.a;
insert into t3 select x from v1;
insert into t2 select x from v1;
drop view v1;
drop table t1,t2,t3;
CREATE TABLE t1 (col1 int PRIMARY KEY, col2 varchar(10));
INSERT INTO t1 VALUES(1,'trudy');
INSERT INTO t1 VALUES(2,'peter');
INSERT INTO t1 VALUES(3,'sanja');
INSERT INTO t1 VALUES(4,'monty');
INSERT INTO t1 VALUES(5,'david');
INSERT INTO t1 VALUES(6,'kent');
INSERT INTO t1 VALUES(7,'carsten');
INSERT INTO t1 VALUES(8,'ranger');
INSERT INTO t1 VALUES(10,'matt');
CREATE TABLE t2 (col1 int, col2 int, col3 char(1));
INSERT INTO t2 VALUES (1,1,'y');
INSERT INTO t2 VALUES (1,2,'y');
INSERT INTO t2 VALUES (2,1,'n');
INSERT INTO t2 VALUES (3,1,'n');
INSERT INTO t2 VALUES (4,1,'y');
INSERT INTO t2 VALUES (4,2,'n');
INSERT INTO t2 VALUES (4,3,'n');
INSERT INTO t2 VALUES (6,1,'n');
INSERT INTO t2 VALUES (8,1,'y');
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT a.col1,a.col2,b.col2,b.col3
  FROM t1 a LEFT JOIN t2 b ON a.col1=b.col1
    WHERE b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM t2 b WHERE b.col1=a.col1);
SELECT a.col1,a.col2,b.col2,b.col3
  FROM v1 a LEFT JOIN t2 b ON a.col1=b.col1
    WHERE b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM t2 b WHERE b.col1=a.col1);
CREATE VIEW v2 AS SELECT * FROM t2;
SELECT a.col1,a.col2,b.col2,b.col3
  FROM v2 b RIGHT JOIN v1 a ON a.col1=b.col1
    WHERE b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM v2 b WHERE b.col1=a.col1);
SELECT a.col1,a.col2,b.col2,b.col3
  FROM v2 b RIGHT JOIN v1 a ON a.col1=b.col1
    WHERE a.col1 IN (1,5,9) AND
         (b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM v2 b WHERE b.col1=a.col1));
CREATE VIEW v3 AS SELECT * FROM t1 WHERE col1 IN (1,5,9);
SELECT a.col1,a.col2,b.col2,b.col3
  FROM v2 b RIGHT JOIN v3 a ON a.col1=b.col1
    WHERE b.col2 IS NULL OR
          b.col2=(SELECT MAX(col2) FROM v2 b WHERE b.col1=a.col1);
DROP VIEW v1,v2,v3;
DROP TABLE t1,t2;
create table t1 as select 1 A union select 2 union select 3;
create table t2 as select * from t1;
create view v1 as select * from t1 where a in (select * from t2);
select * from v1 A, v1 B where A.a = B.a;
create table t3 as select a a,a b from t2;
create view v2 as select * from t3 where
  a in (select * from t1) or b in (select * from t2);
select * from v2 A, v2 B where A.a = B.b;
drop view v1, v2;
drop table t1, t2, t3;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (b int);
INSERT INTO t1 VALUES (1), (2), (3), (4);
INSERT INTO t2 VALUES (4), (2);
CREATE VIEW v1 AS SELECT * FROM t1,t2 WHERE t1.a=t2.b;
SELECT * FROM v1;
CREATE VIEW v2 AS SELECT * FROM v1;
SELECT * FROM v2;
DROP VIEW v2,v1;
DROP TABLE t1, t2;
create table t1 (a int);
create view v1 as select sum(a) from t1 group by a;
drop view v1;
drop table t1;
CREATE TABLE t1(a char(2) primary key, b char(2));
CREATE TABLE t2(a char(2), b char(2), index i(a));
INSERT INTO t1 VALUES ('a','1'), ('b','2');
INSERT INTO t2 VALUES ('a','5'), ('a','6'), ('b','5'), ('b','6');
CREATE VIEW v1 AS
  SELECT t1.b as c, t2.b as d FROM t1,t2 WHERE t1.a=t2.a;
SELECT d, c FROM v1 ORDER BY d,c;
DROP VIEW v1;
DROP TABLE t1, t2;
create table t1 (s1 int);
create view  v1 as select sum(distinct s1) from t1;
select * from v1;
drop view v1;
create view  v1 as select avg(distinct s1) from t1;
select * from v1;
drop view v1;
drop table t1;
create view v1 as select cast(1 as decimal);
select * from v1;
drop view v1;
create table t1(f1 int);
create table t2(f2 int);
insert into t1 values(1),(2),(3);
insert into t2 values(1),(2),(3);
create view v1 as select * from t1,t2 where f1=f2;
create table t3 (f1 int, f2 int);
insert into t3 select * from v1 order by 1;
select * from t3;
drop view v1;
drop table t1,t2,t3;
create view v1 as select '\\','\\shazam';
select * from v1;
drop view v1;
create view v1 as select '\'','\shazam';
select * from v1;
drop view v1;
create view v1 as select 'k','K';
select * from v1;
drop view v1;
create table t1 (s1 int);
create view v1 as select s1, 's1' from t1;
select * from v1;
drop view v1;
create view v1 as select 's1', s1 from t1;
select * from v1;
drop view v1;
create view v1 as select 's1', s1, 1 as Name_exp_s1 from t1;
select * from v1;
drop view v1;
create view v1 as select 1 as Name_exp_s1, 's1', s1  from t1;
select * from v1;
drop view v1;
create view v1 as select 1 as s1, 's1', 's1' from t1;
select * from v1;
drop view v1;
create view v1 as select 's1', 's1', 1 as s1 from t1;
select * from v1;
drop view v1;
create view v1 as select s1, 's1', 's1' from t1;
select * from v1;
drop view v1;
create view v1 as select 's1', 's1', s1 from t1;
select * from v1;
drop view v1;
drop table t1;
create view v1 as SELECT TIME_FORMAT(SEC_TO_TIME(3600),'%H:%i') as t;
select * from v1;
drop view v1;
create table t1 (a timestamp default now());
create table t2 (b timestamp default now());
create view v1 as select a,b,t1.a < now() from t1,t2 where t1.a < now();
drop view v1;
drop table t1, t2;
CREATE TABLE t1 ( a varchar(50) );
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a = CURRENT_USER();
DROP VIEW v1;
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a = VERSION();
DROP VIEW v1;
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a = DATABASE();
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (col1 time);
CREATE TABLE t2 (col1 time);
CREATE VIEW v1 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t1;
CREATE VIEW v2 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t2;
CREATE VIEW v3 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t1;
CREATE VIEW v4 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t2;
CREATE VIEW v5 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t1;
CREATE VIEW v6 AS SELECT CONVERT_TZ(col1,'GMT','MET') FROM t2;
DROP TABLE t1;
drop view v1, v2, v3, v4, v5, v6;
drop table t2;
drop function if exists f1;
drop function if exists f2;
CREATE TABLE t1 (col1 time);
CREATE TABLE t2 (col1 time);
CREATE TABLE t3 (col1 time);
DROP TABLE t1;
drop table t2,t3;
create table t1 (f1 date);
insert into t1 values ('2005-01-01'),('2005-02-02');
create view v1 as select * from t1;
select * from v1 where f1='2005.02.02';
select * from v1 where '2005.02.02'=f1;
drop view v1;
drop table t1;
CREATE VIEW v1 AS SELECT SUBSTRING_INDEX("dkjhgd:kjhdjh", ":", 1);
SELECT * FROM v1;
drop view v1;
create table t1 (f59 int, f60 int, f61 int);
insert into t1 values (19,41,32);
create view v1 as select f59, f60 from t1 where f59 in
         (select f59 from t1);
drop view v1;
drop table t1;
create table t1 (s1 int);
create view v1 as select var_samp(s1) from t1;
drop view v1;
drop table t1;
CREATE TABLE t1 (col1 INT NOT NULL, col2 INT NOT NULL);
CREATE VIEW v1 (vcol1) AS SELECT col1 FROM t1;
CREATE VIEW v2 (vcol1) AS SELECT col1 FROM t1 WHERE col2 > 2;
drop view v2,v1;
drop table t1;
create table t1 (f1 int);
insert into t1 values (1);
create view v1 as select f1 from t1;
select f1 as alias from v1;
drop view v1;
drop table t1;
CREATE TABLE t1 (s1 int, s2 int);
INSERT  INTO t1 VALUES (1,2);
CREATE VIEW v1 AS SELECT s2 AS s1, s1 AS s2 FROM t1;
SELECT * FROM v1;
CREATE PROCEDURE p1 () SELECT * FROM v1;
ALTER VIEW v1 AS SELECT s1 AS s1, s2 AS s2 FROM t1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT s2 AS s1, s1 AS s2 FROM t1;
DROP PROCEDURE p1;
DROP VIEW v1;
DROP TABLE t1;
create table t1 (f1 int, f2 int);
create view v1 as select f1 as f3, f2 as f1 from t1;
insert into t1 values (1,3),(2,1),(3,2);
select * from v1 order by f1;
drop view v1;
drop table t1;
CREATE TABLE t1 (f1 char);
INSERT INTO t1 VALUES ('A');
CREATE VIEW  v1 AS SELECT * FROM t1;
INSERT INTO t1 VALUES('B');
SELECT * FROM v1;
SELECT * FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 ( bug_table_seq   INTEGER NOT NULL);
CREATE OR REPLACE VIEW v1 AS SELECT * from t1;
DROP PROCEDURE IF EXISTS p1;
INSERT INTO t1 VALUES (1);
DROP VIEW v1;
DROP TABLE t1;
create table t1(f1 datetime);
insert into t1 values('2005.01.01 12:0:0');
create view v1 as select f1, subtime(f1, '1:1:1') as sb from t1;
select * from v1;
drop view v1;
drop table t1;
CREATE TABLE t1 (
  aid int PRIMARY KEY,
  fn varchar(20) NOT NULL,
  ln varchar(20) NOT NULL
);
CREATE TABLE t2 (
  aid int NOT NULL,
  pid int NOT NULL
);
INSERT INTO t1 VALUES(1,'a','b'), (2,'c','d');
INSERT INTO t2 values (1,1), (2,1), (2,2);
CREATE VIEW v1 AS SELECT t1.*,t2.pid FROM t1,t2 WHERE t1.aid = t2.aid;
SELECT pid,GROUP_CONCAT(CONCAT(fn,' ',ln) ORDER BY 1) FROM t1,t2
  WHERE t1.aid = t2.aid GROUP BY pid;
SELECT pid,GROUP_CONCAT(CONCAT(fn,' ',ln) ORDER BY 1) FROM v1 GROUP BY pid;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (id int PRIMARY KEY, f varchar(255));
CREATE VIEW v1 AS SELECT id, f FROM t1 WHERE id <= 2;
INSERT INTO t1 VALUES (2, 'foo2');
INSERT INTO t1 VALUES (1, 'foo1');
SELECT * FROM v1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (pk int PRIMARY KEY, b int);
CREATE TABLE t2 (pk int PRIMARY KEY, fk int, INDEX idx(fk));
CREATE TABLE t3 (pk int PRIMARY KEY, fk int, INDEX idx(fk));
CREATE TABLE t4 (pk int PRIMARY KEY, fk int, INDEX idx(fk));
CREATE TABLE t5 (pk int PRIMARY KEY, fk int, INDEX idx(fk));
CREATE VIEW v1 AS
  SELECT t1.pk as a FROM t1,t2,t3,t4,t5
    WHERE t1.b IS NULL AND
          t1.pk=t2.fk AND t2.pk=t3.fk AND t3.pk=t4.fk AND t4.pk=t5.fk;
SELECT a FROM v1;
DROP VIEW v1;
DROP TABLE t1,t2,t3,t4,t5;
create view v1 as select timestampdiff(day,'1997-01-01 00:00:00','1997-01-02 00:00:00') as f1;
select * from v1;
drop view v1;
create table t1(a int);
create procedure p1() create view v1 as select * from t1;
drop table t1;
drop procedure p1;
create table t1 (f1 int);
create table t2 (f1 int);
insert into t1 values (1);
insert into t2 values (2);
create view v1 as select * from t1 union select * from t2 union all select * from t2;
select * from v1;
drop view v1;
drop table t1,t2;
CREATE TEMPORARY TABLE t1 (a int);
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP VIEW  IF EXISTS v1;
CREATE TABLE t1 (f4 CHAR(5));
CREATE VIEW v1 AS SELECT * FROM t1;
ALTER TABLE t1 CHANGE COLUMN f4 f4x CHAR(5);
DROP TABLE t1;
DROP VIEW v1;
create table t1 (f1 char);
create view v1 as select strcmp(f1,'a') from t1;
select * from v1;
drop view v1;
drop table t1;
create table t1 (f1 int, f2 int,f3 int);
insert into t1 values (1,10,20),(2,0,0);
create view v1 as select * from t1;
drop view v1;
drop table t1;
create table t1 (
  r_object_id char(16) NOT NULL,
  group_name varchar(32) NOT NULL
) engine = InnoDB;
create table t2 (
  r_object_id char(16) NOT NULL,
  i_position int(11) NOT NULL,
  users_names varchar(32) default NULL
) Engine = InnoDB;
create view v1 as select r_object_id, group_name from t1;
create view v2 as select r_object_id, i_position, users_names from t2;
create unique index r_object_id on t1(r_object_id);
create index group_name on t1(group_name);
create unique index r_object_id_i_position on t2(r_object_id,i_position);
create index users_names on t2(users_names);
insert into t1 values('120001a080000542','tstgroup1');
insert into t2 values('120001a080000542',-1, 'guser01');
insert into t2 values('120001a080000542',-2, 'guser02');
select v1.r_object_id, v2.users_names from v1, v2
where (v1.group_name='tstgroup1') and v2.r_object_id=v1.r_object_id
order by users_names;
drop view v1, v2;
drop table t1, t2;
create table t1 (s1 int);
create view abc as select * from t1 as abc;
drop table t1;
drop view abc;
create table t1(f1 char(1));
create view v1 as select * from t1;
select * from (select f1 as f2 from v1) v where v.f2='a';
drop view v1;
drop table t1;
create view v1 as SELECT CONVERT_TZ('2004-01-01 12:00:00','GMT','MET');
select * from v1;
drop view v1;
CREATE TABLE t1 (date DATE NOT NULL);
INSERT INTO  t1 VALUES ('2005-09-06');
CREATE VIEW v1 AS SELECT DAYNAME(date) FROM t1;
CREATE VIEW v2 AS SELECT DAYOFWEEK(date) FROM t1;
CREATE VIEW v3 AS SELECT WEEKDAY(date) FROM t1;
SELECT DAYNAME('2005-09-06');
SELECT DAYNAME(date) FROM t1;
SELECT * FROM v1;
SELECT DAYOFWEEK('2005-09-06');
SELECT DAYOFWEEK(date) FROM t1;
SELECT * FROM v2;
SELECT WEEKDAY('2005-09-06');
SELECT WEEKDAY(date) FROM t1;
SELECT * FROM v3;
DROP TABLE t1;
DROP VIEW  v1, v2, v3;
CREATE TABLE t1 ( a int, b int );
INSERT INTO t1 VALUES (1,1),(2,2),(3,3);
CREATE VIEW v1 AS SELECT a,b FROM t1;
SELECT t1.a FROM t1 GROUP BY t1.a HAVING a > 1;
SELECT v1.a FROM v1 GROUP BY v1.a HAVING a > 1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 ( a int, b int );
INSERT INTO t1 VALUES (1,1),(2,2),(3,3);
CREATE VIEW v1 AS SELECT a,b FROM t1;
SELECT t1.a FROM t1 GROUP BY t1.a HAVING t1.a > 1;
SELECT v1.a FROM v1 GROUP BY v1.a HAVING v1.a > 1;
SELECT t_1.a FROM t1 AS t_1 GROUP BY t_1.a HAVING t_1.a IN (1,2,3);
SELECT v_1.a FROM v1 AS v_1 GROUP BY v_1.a HAVING v_1.a IN (1,2,3);
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT, INDEX(a,b));
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 (a INT);
INSERT INTO t1 VALUES (1,1),(2,2),(3,3);
INSERT INTO t2 VALUES (1,1),(2,2),(3,3);
INSERT INTO t3 VALUES (1),(2),(3);
CREATE VIEW v1 AS SELECT t1.* FROM t1,t2 WHERE t1.a=t2.a AND t1.b=t2.b;
CREATE VIEW v2 AS SELECT t3.* FROM t1,t3 WHERE t1.a=t3.a;
DROP VIEW v1,v2;
DROP TABLE t1,t2,t3;
create table t1 (f1 int);
create view v1 as select t1.f1 as '123
456' from t1;
select * from v1;
drop view v1;
drop table t1;
create table t1 (f1 int, f2 int);
insert into t1 values(1,1),(1,2),(1,3);
create view v1 as select f1 ,group_concat(f2 order by f2 asc) from t1 group by f1;
create view v2 as select f1 ,group_concat(f2 order by f2 desc) from t1 group by f1;
select * from v1;
select * from v2;
drop view v1,v2;
drop table t1;
create table t1 (x int, y int);
create table t2 (x int, y int, z int);
create table t3 (x int, y int, z int);
create table t4 (x int, y int, z int);
create view v1 as
select t1.x
from (
  (t1 join t2 on ((t1.y = t2.y)))
  join
  (t3 left join t4 on (t3.y = t4.y) and (t3.z = t4.z))
);
prepare stmt1 from "select count(*) from v1 where x = ?";
drop view v1;
drop table t1,t2,t3,t4;
CREATE TABLE t1(id INT);
CREATE VIEW v1 AS SELECT id FROM t1;
DROP TABLE t1;
DROP VIEW v1;
create definer = current_user() sql security invoker view v1 as select 1;
drop view v1;
create definer = current_user sql security invoker view v1 as select 1;
drop view v1;
create table t1 (id INT, primary key(id));
insert into t1 values (1),(2);
create view v1 as select * from t1;
drop view v1;
drop table t1;
create table t1(f1 int, f2 int);
insert into t1 values (null, 10), (null,2);
select f1, sum(f2) from t1 group by f1;
create view v1 as select * from t1;
select f1, sum(f2) from v1 group by f1;
drop view v1;
drop table t1;
drop procedure if exists p1;
CREATE VIEW v1 AS SELECT 42 AS Meaning;
DROP FUNCTION IF EXISTS f1;
create table t1 (id numeric, warehouse_id numeric);
insert into t1 (id, warehouse_id) values(3, 2);
insert into t1 (id, warehouse_id) values(4, 2);
insert into t1 (id, warehouse_id) values(5, 1);
drop table t1;
CREATE TABLE t1 (a int PRIMARY KEY, b int);
INSERT INTO t1 VALUES (2,20), (3,10), (1,10), (0,30), (5,10);
SELECT MAX(a) FROM t1;
SELECT MIN(a) FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (x varchar(10));
INSERT INTO t1 VALUES (null), ('foo'), ('bar'), (null);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT IF(x IS NULL, 'blank', 'not blank') FROM v1 GROUP BY x;
SELECT IF(x IS NULL, 'blank', 'not blank') AS x FROM t1 GROUP BY x;
SELECT IF(x IS NULL, 'blank', 'not blank') AS x FROM v1;
SELECT IF(x IS NULL, 'blank', 'not blank') AS y FROM v1 GROUP BY y;
SELECT IF(x IS NULL, 'blank', 'not blank') AS x FROM v1 GROUP BY x;
DROP VIEW v1;
DROP TABLE t1;
drop table if exists t1;
drop view if exists v1;
create table t1 (id int);
create view v1 as select * from t1;
drop table t1;
drop view v1;
create table t1(f1 int, f2 int);
create view v1 as select ta.f1 as a, tb.f1 as b from t1 ta, t1 tb where ta.f1=tb
.f1 and ta.f2=tb.f2;
insert into t1 values(1,1),(2,2);
create view v2 as select * from v1 where a > 1 with local check option;
select * from v2;
update v2 set b=3 where a=2;
select * from v2;
drop view v2, v1;
drop table t1;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2);
CREATE VIEW v1 AS SELECT SQRT(a) my_sqrt FROM t1;
SELECT my_sqrt FROM v1 ORDER BY my_sqrt;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (id int PRIMARY KEY);
CREATE TABLE t2 (id int PRIMARY KEY);
INSERT INTO t1 VALUES (1), (3);
INSERT INTO t2 VALUES (1), (2), (3);
CREATE VIEW v2 AS SELECT * FROM t2;
SELECT COUNT(*) FROM t1 LEFT JOIN t2 ON t1.id=t2.id;
SELECT * FROM t1 LEFT JOIN t2 ON t1.id=t2.id;
SELECT COUNT(*) FROM t1 LEFT JOIN v2 ON t1.id=v2.id;
DROP VIEW v2;
DROP TABLE t1, t2;
CREATE TABLE t1 (id int NOT NULL PRIMARY KEY,
                 td date DEFAULT NULL, KEY idx(td));
INSERT INTO t1 VALUES
 (1, '2005-01-01'), (2, '2005-01-02'), (3, '2005-01-02'),
 (4, '2005-01-03'), (5, '2005-01-04'), (6, '2005-01-05'),
 (7, '2005-01-05'), (8, '2005-01-05'), (9, '2005-01-06');
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT * FROM t1 WHERE td BETWEEN CAST('2005.01.02' AS DATE) AND CAST('2005.01.04' AS DATE);
SELECT * FROM v1 WHERE td BETWEEN CAST('2005.01.02' AS DATE) AND CAST('2005.01.04' AS DATE);
DROP VIEW v1;
DROP TABLE t1;
create table t1 (a int);
create view v1 as select * from t1;
create view v2 as select * from v1;
drop table t1;
create table t1 (a int);
drop table t1;
create table t1 (dt datetime);
insert into t1 values (20040101000000), (20050101000000), (20060101000000);
drop view v1;
create view v1 as select * from t1 where convert_tz(dt, 'UTC', 'Europe/Moscow') >= 20050101000000;
select * from v1;
drop view v2;
create view v2 as select convert_tz(dt, 'UTC', 'Europe/Moscow') as ldt from v1;
select * from v2;
drop view v1, v2;
drop table t1;
CREATE TABLE t1 (id int NOT NULL PRIMARY KEY, d datetime);
CREATE VIEW v1 AS
SELECT id, date(d) + INTERVAL TIME_TO_SEC(d) SECOND AS t, COUNT(*)
  FROM t1 GROUP BY id, t;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (i INT, j BIGINT);
INSERT INTO t1 VALUES (1, 2), (2, 2), (3, 2);
CREATE VIEW v1 AS SELECT MIN(j) AS j FROM t1;
CREATE VIEW v2 AS SELECT MIN(i) FROM t1 WHERE j = ( SELECT * FROM v1 );
SELECT * FROM v2;
DROP VIEW v2, v1;
DROP TABLE t1;
CREATE TABLE t1(
  fName varchar(25) NOT NULL,
  lName varchar(25) NOT NULL,
  DOB date NOT NULL,
  test_date date NOT NULL,
  uID int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY);
INSERT INTO t1(fName, lName, DOB, test_date) VALUES
  ('Hank', 'Hill', '1964-09-29', '2007-01-01'),
  ('Tom', 'Adams', '1908-02-14', '2007-01-01'),
  ('Homer', 'Simpson', '1968-03-05', '2007-01-01');
CREATE VIEW v1 AS
  SELECT (year(test_date)-year(DOB)) AS Age
    FROM t1 HAVING Age < 75;
SELECT (year(test_date)-year(DOB)) AS Age FROM t1 HAVING Age < 75;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (id int NOT NULL PRIMARY KEY, a char(6) DEFAULT 'xxx');
INSERT INTO t1(id) VALUES (1), (2), (3), (4);
INSERT INTO t1 VALUES (5,'yyy'), (6,'yyy');
SELECT * FROM t1;
CREATE VIEW v1(a, m) AS SELECT a, MIN(id) FROM t1 GROUP BY a;
SELECT * FROM v1;
CREATE TABLE t2 SELECT * FROM v1;
INSERT INTO t2(m) VALUES (0);
SELECT * FROM t2;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (id int PRIMARY KEY, e ENUM('a','b') NOT NULL DEFAULT 'b');
INSERT INTO t1(id) VALUES (1), (2), (3);
INSERT INTO t1 VALUES (4,'a');
SELECT * FROM t1;
CREATE VIEW v1(m, e) AS SELECT MIN(id), e FROM t1 GROUP BY e;
CREATE TABLE t2 SELECT * FROM v1;
SELECT * FROM t2;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a INT NOT NULL, b INT NULL DEFAULT NULL);
CREATE VIEW v1 AS SELECT a, b FROM t1;
INSERT IGNORE INTO v1 (b) VALUES (2);
SELECT * FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (firstname text, surname text);
INSERT INTO t1 VALUES
  ("Bart","Simpson"),("Milhouse","van Houten"),("Montgomery","Burns");
CREATE VIEW v1 AS SELECT CONCAT(firstname," ",surname) AS name FROM t1;
SELECT CONCAT(LEFT(name,LENGTH(name)-INSTR(REVERSE(name)," ")),
              LEFT(name,LENGTH(name)-INSTR(REVERSE(name)," "))) AS f1
 FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (i int, j int);
CREATE VIEW v1 AS SELECT COALESCE(i,j) FROM t1;
CREATE TABLE t2 SELECT COALESCE(i,j) FROM t1;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (s varchar(10));
INSERT INTO t1 VALUES ('yadda'), ('yady');
SELECT TRIM(BOTH 'y' FROM s) FROM t1;
CREATE VIEW v1 AS SELECT TRIM(BOTH 'y' FROM s) FROM t1;
SELECT * FROM v1;
DROP VIEW v1;
SELECT TRIM(LEADING 'y' FROM s) FROM t1;
CREATE VIEW v1 AS SELECT TRIM(LEADING 'y' FROM s) FROM t1;
SELECT * FROM v1;
DROP VIEW v1;
SELECT TRIM(TRAILING 'y' FROM s) FROM t1;
CREATE VIEW v1 AS SELECT TRIM(TRAILING 'y' FROM s) FROM t1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (x INT, y INT);
CREATE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW v1 AS SELECT x FROM t1;
ALTER VIEW v1 AS SELECT x, y FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (s1 char) charset latin1;
INSERT INTO t1 VALUES ('Z');
CREATE VIEW v1 AS SELECT s1 collate latin1_german1_ci AS col FROM t1;
CREATE VIEW v2 (col) AS SELECT s1 collate latin1_german1_ci FROM t1;
INSERT INTO v1 (col) VALUES ('b');
INSERT INTO v2 (col) VALUES ('c');
SELECT s1 FROM t1;
DROP VIEW v1, v2;
DROP TABLE t1;
CREATE TABLE t1 (id INT);
CREATE VIEW v1 AS SELECT id FROM t1;
DROP TABLE t1;
DROP VIEW IF EXISTS v1;
CREATE DATABASE bug21261DB;
CREATE TABLE t1 (x INT);
CREATE SQL SECURITY INVOKER VIEW v1 AS SELECT x FROM t1;
CREATE TABLE t2 (y INT);
INSERT INTO v1 (x) VALUES (5);
UPDATE v1 SET x=1;
UPDATE v1,t2 SET x=1 WHERE x=y;
SELECT * FROM t1;
DROP VIEW v1;
DROP TABLE t1;
DROP DATABASE bug21261DB;
create table t1 (f1 datetime);
create view v1 as select * from t1 where f1 between now() and now() + interval 1 minute;
drop view v1;
drop table t1;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
DROP VIEW IF EXISTS v2;
CREATE TABLE t1(a INT, b INT);
DROP TABLE t1;
DROP FUNCTION IF EXISTS f1;
DROP FUNCTION IF EXISTS f2;
DROP VIEW IF EXISTS v1, v2;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (i INT);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE ALGORITHM=TEMPTABLE VIEW v2 AS SELECT * FROM t1;
DROP VIEW v1, v2;
DROP TABLE t1;
CREATE TABLE t1 (s1 int);
CREATE VIEW v1 AS SELECT * FROM t1;
INSERT INTO t1 VALUES (1), (3), (2);
DROP VIEW v1;
DROP TABLE t1;
create table t1 (s1 int);
create view v1 as select s1 as a, s1 as b from t1;
update v1 set a = 5;
drop view v1;
drop table t1;
CREATE TABLE t1(pk int PRIMARY KEY);
DROP TABLE t1, t2;
DROP FUNCTION IF EXISTS f1;
DROP VIEW IF EXISTS v1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);
CREATE VIEW v1 AS SELECT MAX(i) FROM t1;
INSERT INTO t1 VALUES (1);
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1(id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, val INT UNSIGNED NOT NULL);
CREATE VIEW v1 AS SELECT id, val FROM t1 WHERE val >= 1 AND val <= 5 WITH CHECK OPTION;
INSERT INTO v1 (val) VALUES (2);
INSERT INTO v1 (val) VALUES (4);
DROP VIEW v1;
DROP TABLE t1;
DROP VIEW IF EXISTS v1, v2;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (i INT AUTO_INCREMENT PRIMARY KEY, j INT);
CREATE VIEW v1 AS SELECT j FROM t1;
CREATE VIEW v2 AS SELECT * FROM t1;
INSERT INTO t1 (j) VALUES (1);
SELECT LAST_INSERT_ID();
INSERT INTO v1 (j) VALUES (2);
SELECT LAST_INSERT_ID();
INSERT INTO v2 (j) VALUES (3);
SELECT LAST_INSERT_ID();
INSERT INTO v1 (j) SELECT j FROM t1;
SELECT LAST_INSERT_ID();
SELECT * FROM t1;
DROP VIEW v1, v2;
DROP TABLE t1;
CREATE VIEW v AS SELECT !0 * 5 AS x FROM DUAL;
SELECT !0 * 5 AS x FROM DUAL;
SELECT * FROM v;
DROP VIEW v;
DROP VIEW IF EXISTS v1;
CREATE VIEW v1 AS SELECT 'The\ZEnd';
SELECT * FROM v1;
DROP VIEW v1;
CREATE TABLE t1 (mydate DATETIME);
INSERT INTO t1 VALUES
  ('2007-01-01'), ('2007-01-02'), ('2007-01-30'), ('2007-01-31');
CREATE VIEW v1 AS SELECT mydate from t1;
SELECT * FROM t1 WHERE mydate BETWEEN '2007-01-01' AND '2007-01-31';
SELECT * FROM v1 WHERE mydate BETWEEN '2007-01-01' AND '2007-01-31';
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a int);
CREATE TABLE t2 (b int);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1), (2);
CREATE VIEW v1 AS
  SELECT t2.b FROM t1,t2 WHERE t1.a = t2.b WITH CHECK OPTION;
SELECT * FROM v1;
SELECT * FROM v1;
SELECT * FROM t1;
SELECT * FROM t2;
DROP VIEW v1;
DROP TABLE t1,t2;
create table t1(f1 int, f2 int);
insert into t1 values(1,2),(1,3),(1,1),(2,3),(2,1),(2,2);
select * from t1;
create view v1 as select * from t1 order by f2;
select * from v1;
select * from v1 order by f1;
drop view v1;
drop table t1;
CREATE TABLE t1 (
  id int(11) NOT NULL PRIMARY KEY,
  country varchar(32),
  code int(11) default NULL
);
INSERT INTO t1 VALUES
  (1,'ITALY',100),(2,'ITALY',200),(3,'FRANCE',100), (4,'ITALY',100);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT code, COUNT(DISTINCT country) FROM t1 GROUP BY code ORDER BY MAX(id);
SELECT code, COUNT(DISTINCT country) FROM v1 GROUP BY code ORDER BY MAX(id);
DROP VIEW v1;
DROP TABLE t1;
DROP VIEW IF EXISTS v1;
drop view if exists view_24532_a;
drop view if exists view_24532_b;
drop table if exists table_24532;
create table table_24532 (
  a int,
  b bigint,
  c int(4),
  d bigint(48)
);
create view view_24532_a as
select
  a IS TRUE,
  a IS NOT TRUE,
  a IS FALSE,
  a IS NOT FALSE,
  a IS UNKNOWN,
  a IS NOT UNKNOWN,
  a is NULL,
  a IS NOT NULL,
  ISNULL(a),
  b IS TRUE,
  b IS NOT TRUE,
  b IS FALSE,
  b IS NOT FALSE,
  b IS UNKNOWN,
  b IS NOT UNKNOWN,
  b is NULL,
  b IS NOT NULL,
  ISNULL(b),
  c IS TRUE,
  c IS NOT TRUE,
  c IS FALSE,
  c IS NOT FALSE,
  c IS UNKNOWN,
  c IS NOT UNKNOWN,
  c is NULL,
  c IS NOT NULL,
  ISNULL(c),
  d IS TRUE,
  d IS NOT TRUE,
  d IS FALSE,
  d IS NOT FALSE,
  d IS UNKNOWN,
  d IS NOT UNKNOWN,
  d is NULL,
  d IS NOT NULL,
  ISNULL(d)
from table_24532;
create view view_24532_b as
select
  a IS TRUE,
  if(ifnull(a, 0), 1, 0) as old_istrue,
  a IS NOT TRUE,
  if(ifnull(a, 0), 0, 1) as old_isnottrue,
  a IS FALSE,
  if(ifnull(a, 1), 0, 1) as old_isfalse,
  a IS NOT FALSE,
  if(ifnull(a, 1), 1, 0) as old_isnotfalse
from table_24532;
insert into table_24532 values (0, 0, 0, 0);
select * from view_24532_b;
update table_24532 set a=1;
select * from view_24532_b;
update table_24532 set a=NULL;
select * from view_24532_b;
drop view view_24532_a;
drop view view_24532_b;
drop table table_24532;
CREATE TABLE t1 (
  lid int NOT NULL PRIMARY KEY,
  name char(10) NOT NULL
);
INSERT INTO t1 (lid, name) VALUES
  (1, 'YES'), (2, 'NO');
CREATE TABLE t2 (
  id int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  lid int NOT NULL,
  dt date
);
CREATE TABLE t3 (
  id int NOT NULL PRIMARY KEY,
  gid int NOT NULL,
  lid int NOT NULL,
  dt date
);
INSERT INTO t2 (id, gid, lid, dt) VALUES
 (1, 1, 1, '2007-01-01'),(2, 1, 2, '2007-01-02'),
 (3, 2, 2, '2007-02-01'),(4, 2, 1, '2007-02-02');
INSERT INTO t3 (id, gid, lid, dt) VALUES
 (1, 1, 1, '2007-01-01'),(2, 1, 2, '2007-01-02'),
 (3, 2, 2, '2007-02-01'),(4, 2, 1, '2007-02-02');
SELECT DISTINCT t2.gid AS lgid,
                (SELECT t1.name FROM t1, t3
                   WHERE t1.lid  = t3.lid AND t3.gid = t2.gid
                     ORDER BY t3.dt DESC LIMIT 1
                ) as clid
  FROM t2;
CREATE VIEW v1 AS
SELECT DISTINCT t2.gid AS lgid,
                (SELECT t1.name FROM t1, t3
                   WHERE t1.lid  = t3.lid AND t3.gid = t2.gid
                   ORDER BY t3.dt DESC LIMIT 1
                ) as clid
  FROM t2;
SELECT * FROM v1;
DROP VIEW v1;
DROP table t1,t2,t3;
CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT a FROM t1 ORDER BY a;
SELECT * FROM t1 UNION SELECT * FROM v1;
SELECT * FROM v1 UNION SELECT * FROM t1;
SELECT * FROM t1 UNION SELECT * FROM v1 ORDER BY a;
DROP VIEW v1;
DROP TABLE t1;
CREATE VIEW v1 AS SELECT CAST( 1.23456789 AS DECIMAL( 7,5 ) ) AS col;
SELECT * FROM v1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT CAST(1.23456789 AS DECIMAL(8,0)) AS col;
DROP VIEW v1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (b INT, c INT DEFAULT 0);
INSERT INTO t1 (a) VALUES (1), (2);
INSERT INTO t2 (b) VALUES (1), (2);
CREATE VIEW v1 AS SELECT t2.b,t2.c FROM t1, t2
  WHERE t1.a=t2.b AND t2.b < 3 WITH CHECK OPTION;
SELECT * FROM v1;
UPDATE v1 SET c=1 WHERE b=1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (id int);
CREATE TABLE t2 (id int, c int DEFAULT 0);
INSERT INTO t1 (id) VALUES (1);
INSERT INTO t2 (id) VALUES (1);
CREATE VIEW v1 AS
  SELECT t2.c FROM t1, t2
    WHERE t1.id=t2.id AND 1 IN (SELECT id FROM t1) WITH CHECK OPTION;
UPDATE v1 SET c=1;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a1 INT, c INT DEFAULT 0);
CREATE TABLE t2 (a2 INT);
CREATE TABLE t3 (a3 INT);
CREATE TABLE t4 (a4 INT);
INSERT INTO t1 (a1) VALUES (1),(2);
INSERT INTO t2 (a2) VALUES (1),(2);
INSERT INTO t3 (a3) VALUES (1),(2);
INSERT INTO t4 (a4) VALUES (1),(2);
CREATE VIEW v1 AS
  SELECT t1.a1, t1.c FROM t1 JOIN t2 ON t1.a1=t2.a2 AND t1.c < 3
    WITH CHECK OPTION;
SELECT * FROM v1;
PREPARE t FROM 'UPDATE v1 SET c=3';
UPDATE v1 SET c=1 WHERE a1=1;
SELECT * FROM v1;
SELECT * FROM t1;
CREATE VIEW v2 AS SELECT t1.a1, t1.c
  FROM (t1 JOIN t2 ON t1.a1=t2.a2 AND t1.c < 3)
  JOIN (t3 JOIN t4 ON t3.a3=t4.a4)
    ON t2.a2=t3.a3 WITH CHECK OPTION;
SELECT * FROM v2;
PREPARE t FROM 'UPDATE v2 SET c=3';
UPDATE v2 SET c=2 WHERE a1=1;
SELECT * FROM v2;
SELECT * FROM t1;
DROP VIEW v1,v2;
DROP TABLE t1,t2,t3,t4;
CREATE TABLE t1 (a int, b int);
INSERT INTO t1 VALUES (1,2), (2,2), (1,3), (1,2);
CREATE VIEW v1 AS SELECT a, b+1 as b FROM t1;
SELECT b, SUM(a) FROM v1 WHERE b=3 GROUP BY b;
SELECT a, SUM(b) FROM v1 WHERE b=3 GROUP BY a;
SELECT a, SUM(b) FROM v1 WHERE a=1 GROUP BY a;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (
  person_id int NOT NULL PRIMARY KEY,
  username varchar(40) default NULL,
  status_flg char(1) NOT NULL default 'A'
);
CREATE TABLE t2 (
  person_role_id int NOT NULL auto_increment PRIMARY KEY,
  role_id int NOT NULL,
  person_id int NOT NULL,
  INDEX idx_person_id (person_id),
  INDEX idx_role_id (role_id)
);
CREATE TABLE t3 (
  role_id int NOT NULL auto_increment PRIMARY KEY,
  role_name varchar(100) default NULL,
  app_name varchar(40) NOT NULL,
  INDEX idx_app_name(app_name)
);
CREATE VIEW v1 AS
SELECT profile.person_id AS person_id
  FROM t1 profile, t2 userrole, t3 `role`
    WHERE userrole.person_id = profile.person_id AND
          role.role_id = userrole.role_id AND
          profile.status_flg = 'A'
  ORDER BY profile.person_id,role.app_name,role.role_name;
INSERT INTO  t1 VALUES
 (6,'Sw','A'), (-1136332546,'ols','e'), (0,'    *\n','0'),
 (-717462680,'ENTS Ta','0'), (-904346964,'ndard SQL\n','0');
INSERT INTO t2 VALUES
  (1,3,6),(2,4,7),(3,5,8),(4,6,9),(5,1,6),(6,1,7),(7,1,8),(8,1,9),(9,1,10);
INSERT INTO t3 VALUES
  (1,'NUCANS_APP_USER','NUCANSAPP'),(2,'NUCANS_TRGAPP_USER','NUCANSAPP'),
  (3,'IA_INTAKE_COORDINATOR','IACANS'),(4,'IA_SCREENER','IACANS'),
  (5,'IA_SUPERVISOR','IACANS'),(6,'IA_READONLY','IACANS'),
  (7,'SOC_USER','SOCCANS'),(8,'CAYIT_USER','CAYITCANS'),
  (9,'RTOS_DCFSPOS_SUPERVISOR','RTOS');
SELECT t.person_id AS a, t.person_id AS b FROM v1 t WHERE t.person_id=6;
DROP VIEW v1;
DROP TABLE t1,t2,t3;
create table t1 (i int);
insert into t1 values (1), (2), (1), (3), (2), (4);
create view v1 as select distinct i from t1;
select * from v1;
select table_name, is_updatable from information_schema.views
   where table_name = 'v1';
drop view v1;
drop table t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2);
CREATE VIEW v1 AS SELECT * FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a INT NOT NULL AUTO_INCREMENT, b INT NOT NULL DEFAULT 0,
                 PRIMARY KEY(a), KEY (b));
INSERT INTO t1 VALUES (),(),(),(),(),(),(),(),(),(),(),(),(),(),();
CREATE VIEW v1 AS SELECT * FROM t1 FORCE KEY (PRIMARY,b) ORDER BY a;
CREATE VIEW v2 AS SELECT * FROM t1 USE KEY () ORDER BY a;
CREATE VIEW v3 AS SELECT * FROM t1 IGNORE KEY (b) ORDER BY a;
DROP VIEW v1;
DROP VIEW v2;
DROP VIEW v3;
DROP TABLE t1;
create table t1(f1 int, f2 int not null);
create view v1 as select f1 from t1;
drop view v1;
drop table t1;
create table t1 (a int, key(a));
create table t2 (c int);
create view v1 as select a b from t1;
create view v2 as select 1 a from t2, v1 where c in
                  (select 1 from t1 where b = a);
insert into t1 values (1), (1);
insert into t2 values (1), (1);
prepare stmt from "select * from v2 where a = 1";
drop view v1, v2;
drop table t1, t2;
CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT p.a AS a FROM t1 p, t1 q;
INSERT INTO t1 VALUES (1), (1);
SELECT MAX(a), COUNT(DISTINCT a) FROM v1 GROUP BY a;
DROP VIEW v1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(c1 INT);
SELECT * FROM t1;
DROP TABLE t1;
CREATE VIEW v1 AS SELECT 1 FROM DUAL WHERE 1;
SELECT * FROM v1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT 1;
DROP VIEW v1;
CREATE TABLE t1 (c1 INT PRIMARY KEY, c2 INT, INDEX (c2));
INSERT INTO t1 VALUES (1,1), (2,2), (3,3);
SELECT * FROM t1 USE INDEX (PRIMARY) WHERE c1=2;
SELECT * FROM t1 USE INDEX (c2) WHERE c2=2;
CREATE VIEW v1 AS SELECT c1, c2 FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1(a INT UNIQUE);
CREATE VIEW v1 AS SELECT t1.a FROM t1, t1 AS a;
INSERT INTO t1 VALUES (1), (2);
SELECT * FROM v1;
SELECT * FROM v1;
DELETE FROM t1 WHERE a=3;
INSERT INTO v1(a) SELECT 1 FROM t1,t1 AS c
ON DUPLICATE KEY UPDATE `v1`.`a`= 1;
SELECT * FROM v1;
CREATE VIEW v2 AS SELECT t1.a FROM t1, v1 AS a;
SELECT * FROM v2;
SELECT * FROM v2;
INSERT INTO v2(a) SELECT 1 FROM t1,t1 AS c
ON DUPLICATE KEY UPDATE `v2`.`a`= 1;
SELECT * FROM v2;
DROP VIEW v1;
DROP VIEW v2;
DROP TABLE t1;
CREATE TABLE t1 (c INT);
CREATE VIEW v1 (view_column) AS SELECT c AS alias FROM t1 HAVING alias;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
DROP DATABASE IF EXISTS `d-1`;
CREATE DATABASE `d-1`;
CREATE TABLE `t-1` (c1 INT);
CREATE VIEW  `v-1` AS SELECT c1 FROM `t-1`;
DROP DATABASE `d-1`;
DROP VIEW IF EXISTS v1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(c1 INT, c2 INT);
INSERT INTO t1 VALUES (1, 2), (3, 4);
SELECT * FROM t1;
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT * FROM v1;
ALTER TABLE t1 ADD COLUMN c3 INT AFTER c2;
SELECT * FROM t1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
DROP VIEW IF EXISTS v1;
CREATE VIEW v1 AS SELECT _latin1 'text1' AS c1, 'text2' AS c2;
SELECT COLLATION(c1), COLLATION(c2) FROM v1;
SELECT * FROM v1 WHERE c1 = 'text1';
SELECT * FROM v1 WHERE c2 = 'text2';
SELECT COLLATION(c1), COLLATION(c2) FROM v1;
SELECT * FROM v1 WHERE c1 = 'text1';
SELECT * FROM v1 WHERE c2 = 'text2';
DROP VIEW v1;
drop view if exists a;
drop procedure if exists p;
create view a as select 1;
drop view a;
CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT a FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1(f1 INT);
INSERT INTO t1 VALUES ();
CREATE VIEW v1 AS SELECT 1 FROM t1 WHERE
ROW(1,1) >= ROW(1, (SELECT 1 FROM t1 WHERE  f1 >= ANY ( SELECT '1' )));
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (a CHAR(1) CHARSET latin1, b CHAR(1) CHARSET utf8mb3);
CREATE VIEW v1 AS SELECT 1 from t1
WHERE t1.b <=> (SELECT a FROM t1 WHERE a < SOME(SELECT '1'));
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1(a int);
CREATE VIEW v1 AS SELECT 1 FROM t1 GROUP BY
SUBSTRING(1 FROM (SELECT 3 FROM t1 WHERE a >= ANY(SELECT 1)));
DROP VIEW v1;
DROP TABLE t1;
CREATE VIEW v1 AS SELECT 1 IN (1 LIKE 2,0) AS f;
DROP VIEW v1;
CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT s.* FROM t1 s, t1 b HAVING a;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
drop table if exists t_9801;
drop view if exists v_9801;
create table t_9801 (s1 int);
drop table t_9801;
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
CREATE TEMPORARY TABLE t1 (id INT);
DROP TABLE t1;
CREATE VIEW v1 AS SELECT 1 AS f1;
CREATE TEMPORARY TABLE v1 (id INT);
ALTER VIEW v1 AS SELECT 2 AS f1;
DROP TABLE v1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE IF EXISTS t1, t2;
DROP VIEW IF EXISTS t2;
CREATE TABLE t1 (f1 integer);
CREATE TEMPORARY TABLE IF NOT EXISTS t1 (f1 integer);
CREATE TEMPORARY TABLE t2 (f1 integer);
DROP TABLE t1;
CREATE VIEW t2 AS SELECT * FROM t1;
UNLOCK TABLES;
DROP TABLE t1, t2;
DROP VIEW IF EXISTS v1;
DROP PROCEDURE IF EXISTS p1;
CREATE VIEW v1 AS SELECT schema_name FROM information_schema.schemata;
CREATE PROCEDURE p1() SELECT COUNT(*), GET_LOCK('blocker', 100) FROM v1;
SELECT RELEASE_LOCK('blocker');
SELECT GET_LOCK('blocker', 100);
SELECT COUNT(*) = 1 from information_schema.processlist
  WHERE state = "User lock" AND
        info = "SELECT COUNT(*), GET_LOCK('blocker', 100) FROM v1";
SELECT COUNT(*) = 1 from information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND info = "DROP VIEW v1";
SELECT RELEASE_LOCK('blocker');
SELECT RELEASE_LOCK('blocker');
DROP PROCEDURE p1;
CREATE TABLE t1 (a INT);
DROP VIEW v1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TEMPORARY TABLE t1 (a INT) engine=InnoDB;
CREATE VIEW t1 AS SELECT 1;
DROP VIEW t1;
DROP TEMPORARY TABLE t1;
DROP DATABASE IF EXISTS nodb;
CREATE TABLE t1 (
  pk        INT AUTO_INCREMENT,
  c_int_key INT,
  PRIMARY KEY (pk),
  KEY (c_int_key)
) 
ENGINE=innodb;
CREATE VIEW v_t1 AS SELECT * FROM t1;
SELECT pk
FROM t1
WHERE
  pk > 8
  OR ((pk BETWEEN 9 AND 13) AND pk = 90);
SELECT pk
FROM v_t1
WHERE
  pk > 8
  OR ((pk BETWEEN 9 AND 13) AND pk = 90);
DROP VIEW v_t1;
DROP TABLE t1;
CREATE TABLE t1(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(1, 10), (2, 20);
CREATE VIEW vrow AS SELECT 1 AS a;
SELECT *
FROM t1 JOIN vrow AS dt ON t1.a=dt.a;
INSERT INTO t1 VALUES
 (1, 10),
 (2, 20), (2, 21),
 (3, NULL),
 (4, 40), (4, 41), (4, 42), (4, 43), (4, 44);
INSERT INTO t1 VALUES
 (1, 10),
 (2, 20), (2, 21),
 (3, NULL),
 (4, 40), (4, 41), (4, 42), (4, 43), (4, 44);
SELECT a, b, (SELECT COUNT(*) FROM t1 AS t2 WHERE a=t1.a) AS s
FROM t1;
SELECT a, b, EXISTS (SELECT COUNT(*) FROM t1 AS t2 WHERE a=t1.a) AS s
FROM t1;
CREATE VIEW v1 AS (SELECT '' FROM DUAL);
CREATE VIEW v2 AS (SELECT 'BUG#14117018' AS col1 FROM DUAL) UNION ALL
                  (SELECT '' FROM DUAL);
CREATE VIEW v3 AS (SELECT 'BUG#14117018' AS col1 FROM DUAL) UNION ALL
                  (SELECT '' FROM DUAL) UNION ALL
                  (SELECT '' FROM DUAL);
CREATE VIEW v4 AS (SELECT 'BUG#14117018' AS col1 FROM DUAL) UNION ALL
                  (SELECT '' AS col2 FROM DUAL) UNION ALL
                  (SELECT '' FROM DUAL);
DROP VIEW v1, v2, v3, v4;
CREATE TABLE t3 (
  pk int NOT NULL,
  col_int_key int NOT NULL,
  col_varchar_nokey varchar(1) NOT NULL,
  PRIMARY KEY (pk)
);
CREATE TABLE t0(x INTEGER);
INSERT INTO t0 VALUES(0);
CREATE VIEW v0 AS SELECT DISTINCT x FROM t0;
CREATE VIEW vmat1 AS SELECT DISTINCT * FROM t1;
DELETE FROM t1;
DELETE FROM t1;
INSERT INTO t1 VALUES
 (1,100), (2,100), (3,100), (4,100), (5,100),
 (6,100), (7,100), (8,100), (9,100), (10,100),
 (11,100), (12,100), (13,100), (14,100);
DELETE FROM t1;
INSERT INTO t1 VALUES (1,100);
create view v1n as select * from t1 where a like '%v1n%';
create view v2c as select * from t1 where a like '%v2c%'
 with check option;
create view v3l as select * from t1 where a like '%v3l%'
 with local check option;
update v1n set a='_';
update v2c set a='';
update v3l set a='';
create view v4n as select * from v2c where a like '%v4n%';
create view v5n as select * from v3l where a like '%v5n%';
update v4n set a='v2c';
update v4n set a='v4n';
delete from v4n;
create view v4l as select * from v2c where a like '%v4l%'
 with local check option;
create view v5l as select * from v3l where a like '%v5l%'
 with local check option;
update v4l set a='v2c';
update v4l set a='v4l';
update v5l set a='v3l';
update v5l set a='v5l';
create view v6c as select * from v5n where a like '%v6c%'
 with cascaded check option;
update v6c set a='v5n v3l';
update v6c set a='v6c v3l';
update v6c set a='v6c v5n';
create view v7n as select * from v6c where a like '%v7n%';
update v7n set a='v7n v5n v3l';
update v7n set a='v7n v6c v3l';
update v7n set a='v7n v6c v5nÃÂÃÂ ';
create view v8l as select * from v7n where a like '%v8l%'
 with local check option;
update v8l set a='v7n v6c v5n v3l';
update v8l set a='v8l v7n v5n v3l';
update v8l set a='v8l v7n v6c v3l';
update v8l set a='v8l v7n v6c v5n';
drop view v1n,v2c,v3l,v4n,v5n,v4l,v5l,v6c,v7n,v8l;
drop table t1;
CREATE TABLE t1(a INTEGER) engine=innodb;
CREATE VIEW v3 AS SELECT 1 FROM t1;
CREATE VIEW v2 AS SELECT 1 FROM v3 LEFT JOIN t1 ON 1;
DROP VIEW  v2,v3;
DROP TABLE t1;
CREATE TABLE t1 (r INTEGER) engine=innodb;
CREATE VIEW v1 AS
SELECT 1 AS z from t1;
DROP VIEW  v1;
DROP TABLE t1;
CREATE TABLE t (i INTEGER);
PREPARE s1 FROM
  "SELECT (SELECT MAX(i)) AS field1
   FROM (SELECT * FROM t) AS table1";
CREATE VIEW v AS SELECT * FROM t;
PREPARE s2 FROM
  "SELECT (SELECT MAX(i)) AS field1
   FROM v AS table1";
DEALLOCATE PREPARE s1;
DEALLOCATE PREPARE s2;
DROP VIEW v;
DROP TABLE t;
CREATE VIEW v1 (fld1, fld2) AS
  SELECT 1 AS a, 2 AS b
    UNION ALL
  SELECT 1 AS a, 1 AS a;
CREATE VIEW v2 (fld1, fld2) AS
  SELECT 1 AS a, 2 AS a
    UNION ALL
  SELECT 1 AS a, 1 AS a;
CREATE VIEW v3 AS
  SELECT 1 AS a, 2 AS b
    UNION ALL
  SELECT 1 AS a, 1 AS a;
DROP VIEW v1, v2, v3;
PREPARE X FROM 'CREATE VIEW bug22108567_v1 AS SELECT 1 FROM (SELECT 1) AS D1';
CREATE TABLE t(ts1 DATETIME(6), ts2 DATETIME(6));
INSERT INTO t VALUES('2016-01-11 09:15:25','2016-01-11 21:15:25');
CREATE VIEW v1 AS
SELECT TIMESTAMPDIFF(MICROSECOND, ts1, ts2) duration FROM t;
SELECT * FROM v1;
CREATE VIEW v2 AS
SELECT MIN(duration) AS dmin, MAX(duration) AS dmax FROM v1;
DROP VIEW v1, v2;
DROP TABLE t;
CREATE TABLE t1_base_N3 (pk INT, col_int INT);
CREATE VIEW t1_view_N3 AS SELECT * FROM t1_base_N3 WHERE `pk` BETWEEN 1 AND
2;
CREATE VIEW t1_view_N4 AS SELECT * FROM ( SELECT * FROM t1_view_N3 ) AS A;
DROP VIEW t1_view_N3, t1_view_N4;
DROP TABLE t1_base_N3;
CREATE TABLE t1(a INT);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT * FROM information_schema.views WHERE table_schema='test';
CREATE TABLE t4(b INT);
DROP VIEW v1;
CREATE DATABASE db;
CREATE TABLE db.t1(fld1 INT);
CREATE TABLE db.t2(fld2 INT);
CREATE VIEW v17 AS WITH cte AS (SELECT * FROM t1) SELECT * FROM cte;
DROP DATABASE db;
INSERT INTO t1 VALUES (1), (2);
CREATE VIEW v1 AS SELECT a FROM t1;
CREATE VIEW v2 AS SELECT 1;
CREATE VIEW v3 AS SELECT a FROM (SELECT a FROM v1) AS dt;
CREATE VIEW v4 AS SELECT a FROM (SELECT a FROM t1) AS dt;
CREATE VIEW v5 AS SELECT a FROM (SELECT a FROM v3) AS dt2;
UPDATE v3, v1 SET v1.a=3;
SELECT * FROM t1;
UPDATE v3, t1 SET t1.a=4;
SELECT * FROM t1;
SELECT * FROM t1;
UPDATE v4, v1 SET v1.a=6;
SELECT * FROM t1;
UPDATE v4, t1 SET t1.a=7;
SELECT * FROM t1;
UPDATE v5, v1 SET v1.a=9;
SELECT * FROM t1;
UPDATE v5, t1 SET t1.a=10;
SELECT * FROM t1;
DROP TABLE t1;
DROP VIEW v1, v2, v3, v4, v5;
CREATE TABLE t1(pk INTEGER, cik INTEGER, UNIQUE KEY(cik))
PARTITION BY KEY(cik) PARTITIONS 10;
INSERT INTO t1 VALUES(1, 1);
DROP TABLE t1;
CREATE TABLE t1 (
  col_date_key DATE,
  KEY col_date_key (col_date_key)
);
INSERT INTO t1 VALUES ('2007-02-08');
INSERT INTO t1 VALUES ('2007-02-08');
INSERT INTO t1 VALUES ('2008-11-04');
INSERT INTO t1 VALUES ('2008-11-04');
INSERT INTO t1 VALUES ('2009-01-14');
INSERT INTO t1 VALUES ('2009-01-14');
SELECT MAX(col_date_key) AS x
 FROM t1
 HAVING x >= CAST('2009-01-01' AS DATE);
CREATE VIEW v1 AS
 SELECT MAX(col_date_key) AS x
  FROM t1
  HAVING x >= CAST('2009-01-01' AS DATE);
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (pk INT);
CREATE VIEW v1 AS SELECT COUNT(*) FROM t1
ORDER BY (SELECT 1 FROM t1 WHERE 1 IN (SELECT * FROM (SELECT 1 as field) AS dt));
DROP TABLE t1;
DROP VIEW v1;
CREATE VIEW v AS SELECT null AS 'c' UNION SELECT 'a' AS 'c';
DROP VIEW v;
PREPARE stmt FROM "CREATE VIEW v1 AS SELECT * FROM
                   JSON_TABLE('[]', '$[*]' COLUMNS (c1 INT PATH '$.x')) AS jt";
DEALLOCATE PREPARE stmt;
PREPARE stmt FROM "CREATE VIEW v1 AS WITH RECURSIVE cte (n) AS
                    (
                      SELECT 1
                      UNION ALL
                      SELECT n + 1 FROM cte WHERE n < 5
                    )
                    SELECT * FROM cte";
DEALLOCATE PREPARE stmt;
CREATE VIEW v AS SELECT INSERT('a', 1, 1, YEAR(UNHEX('w'))) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v2 AS SELECT 1 AS c;
CREATE VIEW v1 AS SELECT 4711 AS a, COUNT(DISTINCT c) FROM v2 GROUP BY a WITH ROLLUP;
DROP VIEW v2;
CREATE VIEW v2 AS SELECT 1 AS c;
DROP VIEW v1, v2;
CREATE TABLE t1 (
  pk INT,
  col_int_key INT,
  col_int_nokey INT,
  col_varchar_key VARCHAR(10),
  col_varchar_nokey VARCHAR(10),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key)
);
INSERT INTO t1 VALUES (), ();
CREATE VIEW v1 AS
SELECT alias1.col_int_nokey AS field1,
  (SELECT alias2.col_int_key
   FROM t1 AS alias2
   WHERE alias1.col_varchar_key <= alias1.col_varchar_nokey
  ) AS field2
FROM t1 AS alias1;
DROP VIEW v1;
DROP TABLE t1;
SELECT * FROM v0;
DROP VIEW v0;
DROP TABLE t0;
CREATE TABLE `t1` (`c1` SMALLINT DEFAULT NULL);
CREATE VIEW v1 AS SELECT c1,'ÃÂÃÂ¡' AS c2 FROM t1;
INSERT INTO t1 (c1) VALUES ('0'), ('1');
ALTER TABLE t1 RENAME t1_aux;
ALTER TABLE t1_aux RENAME t1;
SELECT * FROM v1;
DROP VIEW v1;
DROP TABLE t1;
