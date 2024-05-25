alter table t_00712_1 add column c Int32;
select b from t_00712_1 prewhere a < 1000;
select c from t_00712_1 where a < 1000;
select c from t_00712_1 prewhere a < 1000;
drop table t_00712_1;
