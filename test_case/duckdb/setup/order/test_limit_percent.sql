SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE test (a INTEGER, b INTEGER);
INSERT INTO test VALUES (11, 22), (12, 21), (13, 22), (14, 32), (15, 52);
