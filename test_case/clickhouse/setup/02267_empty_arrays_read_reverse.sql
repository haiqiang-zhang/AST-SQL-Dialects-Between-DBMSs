DROP TABLE IF EXISTS t_02267;
CREATE TABLE t_02267
(
    a Array(String),
    b UInt32,
    c Array(String)
)
ENGINE = MergeTree
ORDER BY b
SETTINGS index_granularity = 500, index_granularity_bytes = '10Mi';
INSERT INTO t_02267 (b, a, c) SELECT 0, ['x'],  ['1','2','3','4','5','6'] FROM numbers(1);
INSERT INTO t_02267 (b, a, c) SELECT 1, [],     ['1','2','3','4','5','6'] FROM numbers(300000);
