DROP TABLE IF EXISTS test_table;
DROP TABLE IF EXISTS test_table_sharded;
set allow_deprecated_syntax_for_merge_tree=1;
create table
  test_table_sharded(
    date Date,
    text String,
    hash UInt64
  )
engine=MergeTree(date, (hash, date), 8192);
SET distributed_product_mode = 'local';
SET distributed_foreground_insert = 1;
DROP TABLE test_table_sharded;
