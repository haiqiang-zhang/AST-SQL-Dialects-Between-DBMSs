PRAGMA enable_verification;
CREATE TABLE integers AS SELECT i, i j FROM range(1000) tbl(i) UNION ALL SELECT NULL i, range j FROM range(1000);
DROP TABLE integers;
CREATE TABLE integers AS SELECT NULL i, i j FROM range(1000) tbl(i) UNION ALL SELECT range i, range j FROM range(1000);
