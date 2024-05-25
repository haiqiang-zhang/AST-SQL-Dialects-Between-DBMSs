select * from t_row_exists;
drop table t_row_exists;
create table t_row_exists(a int, b int) engine=Memory;
alter table t_row_exists add column _row_exists int;
alter table t_row_exists drop column _row_exists;
alter table t_row_exists rename column b to _row_exists;
drop table t_row_exists;
