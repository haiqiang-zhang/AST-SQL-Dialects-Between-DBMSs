CREATE TABLE integers(i INTEGER);
INSERT INTO integers SELECT i FROM range(100) tbl(i);
BEGIN TRANSACTION;
INSERT INTO integers SELECT i FROM range(100) tbl(i);
INSERT INTO integers SELECT NULL FROM range(100) tbl(i);
COMMIT;
