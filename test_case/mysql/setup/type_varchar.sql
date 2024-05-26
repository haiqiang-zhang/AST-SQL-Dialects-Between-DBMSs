drop table if exists t1, t2;
create table t1 (v varchar(30), c char(3), e enum('abc','def','ghi'), t text);
insert into t1 values ('abc', 'de', 'ghi', 'jkl');
insert into t1 values ('abc ', 'de ', 'ghi', 'jkl ');
insert into t1 values ('abc    ', 'd  ', 'ghi', 'jkl    ');
