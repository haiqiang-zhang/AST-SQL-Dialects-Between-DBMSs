drop table if exists t;
create table t (c1 Int64, c2 String, c3 DateTime, c4 Int8, c5 String, c6 String, c7 String, c8 String, c9 String, c10 String, c11 String, c12 String, c13 Int8, c14 Int64, c15 String, c16 String, c17 String, c18 Int64, c19 Int64, c20 Int64) engine MergeTree order by c18 SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
insert into t (c1, c18) select number, -number from numbers(2000000);
alter table t add projection p_norm (select * order by c1);
