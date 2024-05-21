-- produces different pipeline if enabled
set enable_memory_bound_merging_of_aggregation_results = 0;
set merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
set max_threads = 16;
set prefer_localhost_replica = 1;
set optimize_aggregation_in_order = 0;
set max_block_size = 65505;
set allow_prefetched_read_pool_for_local_filesystem = 0;
explain pipeline select * from (select * from numbers(1e8) group by number) group by number;
explain pipeline select * from (select * from numbers_mt(1e8) group by number) group by number;
explain pipeline select * from (select * from numbers_mt(1e8) group by number) order by number;
DROP TABLE IF EXISTS proj_agg_02343;
CREATE TABLE proj_agg_02343
(
    k1 UInt32,
    k2 UInt32,
    k3 UInt32,
    value UInt32,
    PROJECTION aaaa
    (
        SELECT
            k1,
            k2,
            k3,
            sum(value)
        GROUP BY k1, k2, k3
    )
)
ENGINE = MergeTree
ORDER BY tuple();
INSERT INTO proj_agg_02343 SELECT 1, number % 2, number % 4, number FROM numbers(100000);
OPTIMIZE TABLE proj_agg_02343 FINAL;
create table t(a UInt64) engine = MergeTree order by (a);
system stop merges t;
system stop merges dist_t;
