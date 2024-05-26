SELECT * FROM m PREWHERE a = 'OK';
SELECT * FROM m WHERE f = 0 SETTINGS optimize_move_to_prewhere=0;
SELECT * FROM m WHERE f = 0 SETTINGS optimize_move_to_prewhere=1;
CREATE TABLE t2
(
    a String,
    date Date,
    f UInt8,
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS index_granularity = 8192;
INSERT INTO t2 (a) VALUES ('OK');
SELECT * FROM m WHERE f = 0 SETTINGS optimize_move_to_prewhere=1;
