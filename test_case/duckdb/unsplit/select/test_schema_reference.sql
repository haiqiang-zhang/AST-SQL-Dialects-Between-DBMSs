PRAGMA enable_verification;
CREATE SCHEMA s1;
CREATE TABLE s1.tbl(i INTEGER);
SELECT s1.tbl.i FROM s1.tbl;
