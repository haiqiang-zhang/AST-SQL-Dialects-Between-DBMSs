drop table if exists t1, t2;

CREATE TABLE t1(a INT, b TEXT, KEY (a)) SECONDARY_ENGINE=MOCK;

SELECT * FROM t1;
DROP TABLE t1;
