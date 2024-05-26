select toStartOfMinute(dt) dt_m, sum(cost) from projection_test group by dt_m;
drop table if exists projection_test_d;
drop table projection_test;
