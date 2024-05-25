PRAGMA enable_verification;
CREATE TABLE integers AS SELECT * FROM range(5) tbl(i);
SELECT i, COUNT(*) AS k FROM integers GROUP BY i HAVING k=1 ORDER BY i;
SELECT 1 AS i, COUNT(*) FROM integers GROUP BY i HAVING i=2;
SELECT i AS j, COUNT(*) AS i FROM integers GROUP BY j HAVING integers.i=1 ORDER BY i;
SELECT i AS j, COUNT(*) AS i FROM integers GROUP BY j HAVING j=1 ORDER BY i;
SELECT COUNT(i) AS j FROM integers HAVING j=5;
SELECT COUNT(i) AS j FROM integers HAVING j=j;
