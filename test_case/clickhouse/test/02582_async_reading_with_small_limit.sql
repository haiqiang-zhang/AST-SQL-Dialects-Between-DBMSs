system stop merges t;
insert into t select * from numbers_mt(1e3);
insert into t select * from numbers_mt(1e3);
insert into t select * from numbers_mt(1e3);
set allow_asynchronous_read_from_io_pool_for_merge_tree = 1;
set max_streams_for_merge_tree_reading = 64;
set max_block_size = 65409;
set read_in_order_two_level_merge_threshold = 1000;
explain pipeline select * from t limit 100;
