PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER UNIQUE);
BEGIN TRANSACTION;
COMMIT;
BEGIN TRANSACTION;
INSERT INTO integers SELECT i FROM range(2, 2049, 1) t1(i);
COMMIT;
DROP TABLE integers;