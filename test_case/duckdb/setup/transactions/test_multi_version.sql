PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (2), (3);
BEGIN TRANSACTION;
UPDATE integers SET i=5 WHERE i=1;
UPDATE integers SET i=10 WHERE i=5;
DELETE FROM integers WHERE i>5;
INSERT INTO integers VALUES (1), (2);
COMMIT;
