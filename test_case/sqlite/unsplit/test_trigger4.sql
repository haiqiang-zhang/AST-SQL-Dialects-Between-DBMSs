create table test1(id integer primary key,a);
create table test2(id integer,b);
create view test as
      select test1.id as id,a as a,b as b
      from test1 join test2 on test2.id =  test1.id;
select * from test1;
select * from test2;
select * from test1;
select * from test2;
select * from test1;
select * from test2;
select * from test1;
select * from test2;
drop table test2;
select * from test1;
create table test2(id,b);
select * from test1;
select * from test2;
select * from test2;
create table tbl(a integer primary key, b integer);
create view vw as select * from tbl;
insert into tbl values(101,1001);
insert into tbl values(102,1002);
insert into tbl select a+2, b+2 from tbl;
insert into tbl select a+4, b+4 from tbl;
insert into tbl select a+8, b+8 from tbl;
insert into tbl select a+16, b+16 from tbl;
insert into tbl select a+32, b+32 from tbl;
insert into tbl select a+64, b+64 from tbl;
select count(*) from vw;
select a, b from vw where a<103 or a>226 order by a;
select * from vw;
select a, b from vw where a<=102 or a>=227 order by a;
PRAGMA integrity_check;