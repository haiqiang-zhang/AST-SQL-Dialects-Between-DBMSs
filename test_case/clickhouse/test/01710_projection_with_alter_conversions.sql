system stop merges t;
set alter_sync = 0;
alter table t rename column j to k;
select * from t;
drop table t;
