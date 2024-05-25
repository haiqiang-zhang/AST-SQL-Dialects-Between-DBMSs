create materialized view t_mv Engine = Null AS select now() as ts, max(a) from t group by ts;
insert into t select * from numbers_mt(10e6) settings max_threads = 16, max_insert_threads=16, max_block_size=100000;
system flush logs;
