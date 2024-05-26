PRAGMA enable_verification;
CREATE VIEW list_int AS
SELECT i, i%2 as i2, [i, i + 1, i + 2] as l3
FROM range(10) tbl(i);
