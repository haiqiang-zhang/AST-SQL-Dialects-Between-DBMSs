PRAGMA enable_verification;
BEGIN TRANSACTION;
CREATE TABLE integers(i INTEGER NOT NULL, j INTEGER);
INSERT INTO integers SELECT i, i+1 FROM range(0, 1000) tbl(i);
