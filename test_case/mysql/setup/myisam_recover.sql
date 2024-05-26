drop procedure if exists p_create;
drop table if exists t1, t1_mrg, t1_copy;
create table t1 (a int, key(a)) engine=myisam;
create table t1_mrg (a int) union (t1) engine=merge;
insert into  t1 (a) values (1), (2), (3);
insert into  t1 (a) values (4), (5), (6);
