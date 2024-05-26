drop table if exists t1,t2;
create table t1(str varchar(10) default 'def',strnull varchar(10),intg int default '10',rel double default '3.14');
insert into t1 values ('','',0,0.0);
