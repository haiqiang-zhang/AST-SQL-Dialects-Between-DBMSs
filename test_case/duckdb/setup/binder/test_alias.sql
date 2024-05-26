SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (2), (3), (NULL);
CREATE TABLE test (a INTEGER, b INTEGER);
INSERT INTO test VALUES (42, 10), (43, 100);
