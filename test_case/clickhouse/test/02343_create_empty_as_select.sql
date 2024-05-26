show create table t;
select count() from t;
create materialized view mv engine=Memory empty as select 1;
show create mv;
drop table t;
drop table mv;
