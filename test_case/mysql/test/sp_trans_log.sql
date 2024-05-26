select count(*) from t1 into @a;
drop table t1,t2;
drop function if exists bug23333;
