SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE test (a INTEGER, b INTEGER);
INSERT INTO test VALUES (1, 2), (3, 4);
CREATE TABLE varchars(v VARCHAR);
INSERT INTO varchars VALUES (1), ('hello'), (DEFAULT);
