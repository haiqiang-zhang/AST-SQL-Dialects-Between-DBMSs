CREATE TABLE test (a VARCHAR);
INSERT INTO test VALUES ('hello'), ('world');
BEGIN TRANSACTION;
DELETE FROM test WHERE a='hello';
UPDATE test SET a='hello';
COMMIT;
