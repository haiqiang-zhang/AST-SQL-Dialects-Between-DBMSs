DROP TABLE IF EXISTS merge_tree_pk SYNC;
CREATE TABLE merge_tree_pk
(
    key UInt64,
    value String
)
ENGINE = ReplacingMergeTree()
PRIMARY KEY key;
