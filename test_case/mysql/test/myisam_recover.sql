select * from t1_mrg;
drop table t1, t1_mrg;
unlock tables;
create table t1 (a int, key(a)) engine=myisam;
create table t2 (a int);
insert into t2 values (1);
insert into  t1 (a) values (1);
insert into  t1 (a) values (4);
select * from t2;
select * from t1;
SELECT count(*) = 1 FROM information_schema.processlist WHERE state
  LIKE "Waiting%" AND info = "ALTER TABLE t2 ADD val INT";
drop table t1, t2;
