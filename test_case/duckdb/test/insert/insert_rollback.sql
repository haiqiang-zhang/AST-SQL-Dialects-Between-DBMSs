CREATE TABLE integers(i INTEGER);
BEGIN TRANSACTION;
INSERT INTO integers VALUES (0), (1), (2);
ROLLBACK;
SELECT COUNT(*) FROM integers;
SELECT COUNT(*) FROM integers;