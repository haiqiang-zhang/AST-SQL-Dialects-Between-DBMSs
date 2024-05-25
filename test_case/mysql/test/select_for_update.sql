create table t1(a int, key(a)) engine=innodb;
insert into t1 values (0);
update t1 set a = 1 where a >= 0;
drop table t1;
