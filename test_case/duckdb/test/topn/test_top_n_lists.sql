PRAGMA enable_verification;
CREATE TABLE tbl AS SELECT [i] l FROM range(1000) tbl(i) UNION ALL SELECT NULL l FROM range(3);
DROP TABLE tbl;
CREATE TABLE tbl AS SELECT NULL l FROM range(3) UNION ALL SELECT [i] l FROM range(1000) tbl(i);
DROP TABLE tbl;
CREATE TABLE tbl AS SELECT [i] l FROM range(1000) tbl(i) UNION ALL SELECT [NULL] l FROM range(3);
DROP TABLE tbl;
CREATE TABLE tbl AS SELECT [NULL] l FROM range(3) UNION ALL SELECT [i] l FROM range(1000) tbl(i);
SELECT l FROM tbl ORDER BY l NULLS FIRST LIMIT 5;
SELECT l FROM tbl ORDER BY l NULLS LAST LIMIT 5;
SELECT l FROM tbl ORDER BY l DESC NULLS FIRST LIMIT 5;
SELECT l FROM tbl ORDER BY l DESC NULLS LAST LIMIT 5;
SELECT l FROM tbl ORDER BY l NULLS FIRST LIMIT 5;
SELECT l FROM tbl ORDER BY l NULLS LAST LIMIT 5;
SELECT l FROM tbl ORDER BY l DESC NULLS FIRST LIMIT 5;
SELECT l FROM tbl ORDER BY l DESC NULLS LAST LIMIT 5;
SELECT range(i) l FROM range(10) tbl(i) ORDER BY l DESC LIMIT 3;
SELECT range(i) l FROM range(10) tbl(i) ORDER BY l ASC LIMIT 3;
