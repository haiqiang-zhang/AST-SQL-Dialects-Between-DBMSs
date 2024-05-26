SYSTEM STOP MERGES t_merge_tree_index;
INSERT INTO t_merge_tree_index SELECT number % 5, number, 0, ['foo', 'bar'], ['aaa', 'bbb', 'ccc'], [11, 22, 33], (number, number), number FROM numbers(10);
ALTER TABLE t_merge_tree_index ADD COLUMN c UInt64 AFTER b;
INSERT INTO t_merge_tree_index SELECT number % 5, number, number, 10, ['foo', 'bar'], ['aaa', 'bbb', 'ccc'], [11, 22, 33], (number, number), number FROM numbers(5);
INSERT INTO t_merge_tree_index SELECT number % 5, number, number, 10, ['foo', 'bar'], ['aaa', 'bbb', 'ccc'], [11, 22, 33], (number, number), number FROM numbers(10);
SET describe_compact_output = 1;
DESCRIBE mergeTreeIndex(currentDatabase(), t_merge_tree_index, with_marks = true);
DROP TABLE t_merge_tree_index;
