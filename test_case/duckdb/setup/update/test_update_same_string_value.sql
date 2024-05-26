CREATE TABLE test (a VARCHAR);
INSERT INTO test VALUES ('hello'), ('world');
BEGIN TRANSACTION;
UPDATE test SET a='test' WHERE a='hello';
UPDATE test SET a='test2' WHERE a='world';
COMMIT;
