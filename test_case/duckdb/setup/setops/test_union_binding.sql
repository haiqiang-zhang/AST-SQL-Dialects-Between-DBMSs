SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE test(a INTEGER);
CREATE TABLE test2(b INTEGER);
INSERT INTO test VALUES (1), (2), (3), (NULL);
INSERT INTO test2 VALUES (2), (3), (4), (NULL);
