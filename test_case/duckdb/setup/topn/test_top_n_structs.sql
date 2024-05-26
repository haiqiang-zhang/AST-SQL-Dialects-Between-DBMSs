PRAGMA enable_verification;
CREATE TABLE tbl AS SELECT {'i': i} l FROM range(1000) tbl(i) UNION ALL SELECT NULL l FROM range(3);
DROP TABLE tbl;
CREATE TABLE tbl AS SELECT NULL l FROM range(3) UNION ALL SELECT {'i': i} l FROM range(1000) tbl(i);
