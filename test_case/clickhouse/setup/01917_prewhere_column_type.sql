SET optimize_move_to_prewhere = 1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 ( s String, f Float32, e UInt16 ) ENGINE = MergeTree ORDER BY tuple() SETTINGS min_bytes_for_wide_part = '100G';
INSERT INTO t1 VALUES ('111', 1, 1);
