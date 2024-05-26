PRAGMA enable_verification;
SET preserve_insertion_order=false;
CREATE TABLE integers AS SELECT 1 AS i FROM range(1000000) t(i);
CREATE TABLE integers2 AS SELECT * FROM range(1000000) tbl(i);
