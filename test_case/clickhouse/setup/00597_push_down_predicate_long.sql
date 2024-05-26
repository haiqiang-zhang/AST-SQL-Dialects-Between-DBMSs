SET send_logs_level = 'fatal';
SET any_join_distinct_right_table_keys = 1;
SET joined_subquery_requires_alias = 0;
DROP TABLE IF EXISTS test_00597;
DROP TABLE IF EXISTS test_view_00597;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE test_00597(date Date, id Int8, name String, value Int64) ENGINE = MergeTree(date, (id, date), 8192);
CREATE VIEW test_view_00597 AS SELECT * FROM test_00597;
