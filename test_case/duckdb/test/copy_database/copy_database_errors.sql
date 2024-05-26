ATTACH DATABASE ':memory:' AS db1;
ATTACH DATABASE ':memory:' AS db2;
COPY FROM DATABASE db1 TO db2;
CREATE TABLE db1.test(a INTEGER, b INTEGER, c VARCHAR);
INSERT INTO db1.test VALUES (42, 84, 'hello');
ATTACH DATABASE '__TEST_DIR__/read_only.db' AS read_only;
DETACH read_only;
ATTACH DATABASE '__TEST_DIR__/read_only.db' AS read_only (READ_ONLY);
COPY FROM DATABASE read_only TO db1;
