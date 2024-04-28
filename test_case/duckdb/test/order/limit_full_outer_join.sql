PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER, j INTEGER);
INSERT INTO integers VALUES (1, 1), (3, 3);
CREATE TABLE integers2(k INTEGER, l INTEGER);
INSERT INTO integers2 VALUES (1, 10), (2, 20);
SELECT i, j, k, l FROM integers FULL OUTER JOIN integers2 ON integers.i=integers2.k ORDER BY ALL LIMIT 2;
SELECT COUNT(*) FROM (SELECT i, j, k, l FROM integers FULL OUTER JOIN integers2 ON integers.i=integers2.k LIMIT 2) tbl;
