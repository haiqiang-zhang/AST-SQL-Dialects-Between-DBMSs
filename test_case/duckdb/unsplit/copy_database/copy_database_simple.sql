PRAGMA enable_verification;
ATTACH DATABASE ':memory:' AS db1;
CREATE TABLE db1.test(a INTEGER, b INTEGER, c VARCHAR(10));
INSERT INTO db1.test VALUES (42, 88, 'hello');
