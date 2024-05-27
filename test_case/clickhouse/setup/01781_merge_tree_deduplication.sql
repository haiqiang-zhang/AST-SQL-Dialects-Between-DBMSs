DROP TABLE IF EXISTS merge_tree_deduplication;
CREATE TABLE merge_tree_deduplication
(
    key UInt64,
    value String,
    part UInt8 DEFAULT 77
)
ENGINE=MergeTree()
ORDER BY key
PARTITION BY part
SETTINGS non_replicated_deduplication_window=3;