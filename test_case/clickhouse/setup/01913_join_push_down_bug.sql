DROP TABLE IF EXISTS test;
CREATE TABLE test
(
    `t` UInt8,
    `flag` UInt8,
    `id` UInt8
)
ENGINE = MergeTree
PARTITION BY t
ORDER BY (t, id)
SETTINGS index_granularity = 8192;
INSERT INTO test VALUES (1,0,1),(1,0,2),(1,0,3),(1,0,4),(1,0,5),(1,0,6),(1,1,7),(0,0,7);
set query_plan_filter_push_down = true;
