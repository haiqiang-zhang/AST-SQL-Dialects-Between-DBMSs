PRAGMA enable_verification;
CREATE TABLE test (a INTEGER PRIMARY KEY, b INTEGER, c VARCHAR);
INSERT INTO test VALUES (11, 22, 'hello'), (13, 22, 'world'), (12, 21, 'test'), (10, NULL, NULL);
BEGIN TRANSACTION;
COMMIT;
INSERT INTO test VALUES (15, NULL, NULL);
INSERT INTO test VALUES (16, 24, 'blabla');
PRAGMA enable_verification;