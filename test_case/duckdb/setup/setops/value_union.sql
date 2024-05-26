PRAGMA enable_verification;
CREATE VIEW vals AS SELECT * FROM (VALUES (1, 10), (2, 5), (3, 4)) tbl(i, j);
CREATE VIEW vunion AS
SELECT * FROM vals
UNION ALL
SELECT * FROM vals;
