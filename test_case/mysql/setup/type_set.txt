create table t1 (a set (' ','a','b') not null);
drop table t1;
create table t1 (a set (' ','a','b ') not null default 'b ');
drop table t1;
create table t1 (s set ('a','A') character set latin1 collate latin1_bin);
insert into t1 values ('a'),('a,A'),('A,a'),('A');
