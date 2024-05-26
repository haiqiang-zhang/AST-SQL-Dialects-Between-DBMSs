SELECT count() FROM test_move_partition_src;
ALTER TABLE test_move_partition_src MOVE PARTITION 1 TO TABLE test_move_partition_dest;
DROP TABLE test_move_partition_src;
DROP TABLE test_move_partition_dest;
