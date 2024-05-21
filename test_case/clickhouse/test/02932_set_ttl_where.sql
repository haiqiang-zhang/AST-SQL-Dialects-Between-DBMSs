create or replace table t_temp (
    a UInt32,
    timestamp DateTime
)
engine = MergeTree
order by a
TTL timestamp + INTERVAL 2 SECOND WHERE a in (select number from system.numbers limit 100_000);
optimize table t_temp final;
DROP TABLE t_temp;
