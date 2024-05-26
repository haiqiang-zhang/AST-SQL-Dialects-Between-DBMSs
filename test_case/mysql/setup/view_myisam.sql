create table t1 (a int, b char(10)) charset latin1 engine=Myisam;
create view v1 as select * from t1 where a != 0 with check option;
