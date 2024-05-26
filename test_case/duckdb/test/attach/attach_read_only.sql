ATTACH '__TEST_DIR__/attach_read_only.db' AS db1 (READONLY 1);
DETACH db1;
ATTACH '__TEST_DIR__/attach_read_only.db' AS db1 (READONLY 1);
ATTACH ':memory:' AS db2;
CREATE TABLE db2.integers AS SELECT * FROM db1.integers;
CREATE TABLE test AS SELECT * FROM range(10) t(i);
SELECT SUM(i) FROM db1.integers;
SELECT SUM(i) FROM db2.integers;
