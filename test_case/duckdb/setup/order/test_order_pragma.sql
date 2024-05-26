PRAGMA enable_verification;
CREATE TABLE test (a INTEGER, b INTEGER);
INSERT INTO test VALUES (11, 22), (12, 21), (13, 22);
PRAGMA default_order='DESCENDING';
PRAGMA default_order='ASC';
