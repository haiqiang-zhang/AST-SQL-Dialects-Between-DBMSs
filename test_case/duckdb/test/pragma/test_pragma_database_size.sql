PRAGMA database_size;;
ATTACH '__TEST_DIR__/db_size.db' AS db1;
CREATE TABLE db1.integers AS FROM range(1000000);;
DROP TABLE db1.integers;
CHECKPOINT db1;
DETACH db1;
ATTACH '__TEST_DIR__/db_size.db' AS db1 (READ_ONLY);
SELECT free_blocks>0 FROM pragma_database_size() WHERE database_name='db1';;
SELECT free_blocks>0 FROM pragma_database_size() WHERE database_name='db1';;