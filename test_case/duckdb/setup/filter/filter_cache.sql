PRAGMA enable_verification;
CREATE TABLE integers AS SELECT a FROM generate_series(0, 9999, 1) tbl(a), generate_series(0, 9, 1) tbl2(b);
