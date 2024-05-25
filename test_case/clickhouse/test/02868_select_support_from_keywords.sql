create VIEW test_view AS WITH cte AS (SELECT date, __sign, "from", "to" FROM test_table FINAL) SELECT date, __sign, "from", "to" FROM cte;
show create table test_view;
drop table test_view;
drop table test_table;
