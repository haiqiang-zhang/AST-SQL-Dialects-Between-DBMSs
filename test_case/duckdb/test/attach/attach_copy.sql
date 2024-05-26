ATTACH DATABASE ':memory:' AS db1;
CREATE TABLE db1.test(a INTEGER, b INTEGER, c VARCHAR(10));
COPY db1.main.test TO '__TEST_DIR__/test.csv';
USE db1;
