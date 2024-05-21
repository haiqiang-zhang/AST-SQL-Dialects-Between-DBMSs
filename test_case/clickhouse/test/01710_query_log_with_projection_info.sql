set log_queries=1;
set log_queries_min_type='QUERY_FINISH';
set optimize_use_implicit_projections=1;
DROP TABLE IF EXISTS t;
CREATE TABLE t
(
    `id` UInt64,
    `id2` UInt64,
    `id3` UInt64,
    PROJECTION t_normal
    (
        SELECT
            id,
            id2,
            id3
        ORDER BY
            id2,
            id,
            id3
    ),
    PROJECTION t_agg
    (
        SELECT
            sum(id3)
        GROUP BY id2
    )
)
ENGINE = MergeTree
ORDER BY id
SETTINGS index_granularity = 8;
insert into t SELECT number, -number, number FROM numbers(10000);
SYSTEM FLUSH LOGS;
';
';
';
DROP TABLE t;