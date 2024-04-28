PRAGMA enable_verification;
PRAGMA force_compression='${compr}';
CREATE TABLE null_byte AS SELECT concat('goo', chr(0), i) AS v FROM range(10000) tbl(i);
CREATE INDEX i_index ON null_byte(v);
DROP TABLE null_byte;
SELECT MIN(v), MAX(v) FROM null_byte;
SELECT * FROM null_byte WHERE v=concat('goo', chr(0), 42);
SELECT * FROM null_byte WHERE v=concat('goo', chr(0), 42);
