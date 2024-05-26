SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (NULL);
CREATE TABLE test(i INTEGER, j INTEGER);
INSERT INTO test VALUES (1, 1), (NULL, 1), (1, NULL);
PRAGMA default_null_order='NULLS LAST';
PRAGMA default_null_order='NULLS FIRST';
