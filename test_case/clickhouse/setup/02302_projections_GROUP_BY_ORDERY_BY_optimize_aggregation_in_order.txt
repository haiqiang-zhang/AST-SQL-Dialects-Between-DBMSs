drop table if exists test_agg_proj_02302;
create table test_agg_proj_02302 (x Int32, y Int32, PROJECTION x_plus_y (select sum(x - y), argMax(x, y) group by x + y)) ENGINE = MergeTree order by tuple() settings index_granularity = 1;
insert into test_agg_proj_02302 select intDiv(number, 2), -intDiv(number,3) - 1 from numbers(100);
