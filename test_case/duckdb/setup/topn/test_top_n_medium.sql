PRAGMA enable_verification;
CREATE TABLE tbl AS SELECT i, i % 1000 j FROM range(1000000) tbl(i);
