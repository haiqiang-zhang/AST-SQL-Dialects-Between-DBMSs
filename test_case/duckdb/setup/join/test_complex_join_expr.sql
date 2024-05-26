SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE test (a INTEGER, b INTEGER);
INSERT INTO test VALUES (4, 1), (2, 2);
CREATE TABLE test2 (b INTEGER, c INTEGER);
INSERT INTO test2 VALUES (1, 2), (3, 0);
