SET allow_experimental_analyzer=1;
SET distributed_foreground_insert=1;
CREATE TABLE second_table_lr
(
    id String,
    id2 String
) ENGINE = MergeTree()
ORDER BY id;
CREATE TABLE two_tables
(
    id String,
    id2 String
)
ENGINE = Merge(currentDatabase(), '^(first_table)$');
