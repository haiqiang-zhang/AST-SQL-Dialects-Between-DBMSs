drop table if exists t;
create table t engine Memory as select * from numbers(2);
select count(*) from t, numbers(2) r;
drop table t;
