create table t1(a int) engine=innodb;
create table t2(a int) engine=innodb;
insert into t1 values(10),(11),(12),(13),(14),(15),(16);
insert into t2 values(100),(11),(120);
update t1 set t1.a=3 where a in (select a from t2);