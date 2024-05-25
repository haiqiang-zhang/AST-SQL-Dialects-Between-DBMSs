create temporary table t2 engine=InnoDB select * from t1;
drop temporary table t2;
drop table t1;
