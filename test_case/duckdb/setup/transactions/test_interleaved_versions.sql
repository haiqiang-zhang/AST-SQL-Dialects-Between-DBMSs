PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
BEGIN TRANSACTION;
INSERT INTO integers VALUES (1);
COMMIT;
BEGIN TRANSACTION;
COMMIT;