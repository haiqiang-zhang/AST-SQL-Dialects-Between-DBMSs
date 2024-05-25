PRAGMA enable_verification;
CREATE TABLE null_byte AS SELECT concat('goo', chr(0), i) AS v FROM range(10000) tbl(i);
CREATE INDEX i_index ON null_byte(v);
DROP TABLE null_byte;
