PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER UNIQUE);
BEGIN TRANSACTION;
COMMIT;
INSERT INTO integers SELECT i FROM range(2, 4097, 1) t1(i);
SELECT MAX(i) FROM integers;
