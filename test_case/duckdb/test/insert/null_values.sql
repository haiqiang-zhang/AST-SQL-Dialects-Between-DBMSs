CREATE TABLE integers(i INTEGER);
INSERT INTO integers SELECT i FROM range(100) tbl(i);;
BEGIN TRANSACTION;
INSERT INTO integers SELECT i FROM range(100) tbl(i);;
INSERT INTO integers SELECT NULL FROM range(100) tbl(i);;
COMMIT;
SELECT COUNT(i), SUM(i), MIN(i), MAX(i), COUNT(*) FROM integers;
SELECT COUNT(i), SUM(i), MIN(i), MAX(i), COUNT(*) FROM integers;
SELECT SUM(CASE WHEN i IS NULL THEN 1 ELSE 0 END) FROM integers;
