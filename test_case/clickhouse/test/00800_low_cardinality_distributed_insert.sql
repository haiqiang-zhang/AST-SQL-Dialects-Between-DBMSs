SET distributed_foreground_insert = 1;
DROP TABLE IF EXISTS low_cardinality;
DROP TABLE IF EXISTS low_cardinality_all;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE low_cardinality (d Date, x UInt32, s LowCardinality(String)) ENGINE = MergeTree(d, x, 8192);
DROP TABLE IF EXISTS low_cardinality;
DROP TABLE IF EXISTS low_cardinality_all;
