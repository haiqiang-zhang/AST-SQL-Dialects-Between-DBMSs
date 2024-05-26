DROP TABLE IF EXISTS no_prop_table;
CREATE TABLE no_prop_table
(
    some_column UInt64
)
ENGINE MergeTree()
ORDER BY tuple();
