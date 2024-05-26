SET checkpoint_threshold = '10.0 GB';
PRAGMA disable_checkpoint_on_shutdown;
CREATE TABLE test_table as SELECT 1 as test_table_column;
