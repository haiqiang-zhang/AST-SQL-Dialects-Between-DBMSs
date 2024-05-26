SET immediate_transaction_mode=true;
CREATE TABLE test (a INTEGER);
INSERT INTO test VALUES (1), (2), (3);
BEGIN TRANSACTION;
INSERT INTO test VALUES (4), (5), (6);
DELETE FROM test WHERE a < 4;
UPDATE test SET a=a-3;
COMMIT;
