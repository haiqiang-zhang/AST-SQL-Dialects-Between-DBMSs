PRAGMA enable_verification;
CREATE TABLE vals1 AS SELECT i AS i, i AS j FROM range(0, 11, 1) t1(i);
INSERT INTO vals1 SELECT i, i+1 FROM vals1;
INSERT INTO vals1 SELECT DISTINCT(i), i-1 FROM vals1 ORDER by i;
CREATE TABLE vals2(k BIGINT, l BIGINT);
INSERT INTO vals2 SELECT * FROM vals1;
