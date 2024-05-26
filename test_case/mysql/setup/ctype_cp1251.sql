drop table if exists t1;
create table t1 (a varchar(10) not null) character set cp1251;
insert into t1 values ("a"),("ab"),("abc");
