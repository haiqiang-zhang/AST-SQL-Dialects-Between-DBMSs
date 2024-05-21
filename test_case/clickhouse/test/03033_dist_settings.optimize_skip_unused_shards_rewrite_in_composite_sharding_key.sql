DROP TABLE IF EXISTS t;
DROP TABLE IF EXISTS dt;
CREATE TABLE t (tag_id UInt64, tag_name String) ENGINE = MergeTree ORDER BY tuple();
SET optimize_skip_unused_shards=1, optimize_skip_unused_shards_rewrite_in=1;
