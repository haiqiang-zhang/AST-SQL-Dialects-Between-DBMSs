SELECT * FROM system.data_skipping_indices WHERE table = 'alter_index_test' AND database = currentDatabase();
ALTER TABLE alter_index_test ADD INDEX index_b b type minmax granularity 1 FIRST;
ALTER TABLE alter_index_test ADD INDEX index_c c type set(0) granularity 2 AFTER index_b;
ALTER TABLE alter_index_test ADD INDEX index_d d type set(0) granularity 1;
SELECT * FROM system.data_skipping_indices WHERE table = 'alter_index_test' AND database = currentDatabase();
DETACH TABLE alter_index_test;
ATTACH TABLE alter_index_test;
SELECT * FROM system.data_skipping_indices WHERE table = 'alter_index_test' AND database = currentDatabase();
DROP TABLE IF EXISTS alter_index_test;
