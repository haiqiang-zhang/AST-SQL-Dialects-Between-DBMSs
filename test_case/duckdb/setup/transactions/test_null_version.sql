SET immediate_transaction_mode=true;
PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER, j INTEGER);
INSERT INTO integers VALUES (NULL, 3);
BEGIN TRANSACTION;
UPDATE integers SET i=1,j=1;
ROLLBACK;
