system stop merges t;
insert into t select 42, number from numbers_mt(100);
insert into t select number, number from numbers_mt(100);
detach table t;
attach table t;
set merge_tree_min_bytes_for_concurrent_read=1, merge_tree_min_rows_for_concurrent_read=1, merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability=1.0, max_threads=4;
-- because some granules were assinged to wrong layers and hence not returned from the reading step (because they were filtered out by `FilterSortedStreamByRange`)
select count() from t where not ignore(*);
