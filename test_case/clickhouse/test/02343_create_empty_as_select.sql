select count() from t;
create materialized view mv engine=Memory empty as select 1;
show create mv;
select count() from mv;
drop table t;
drop table mv;
