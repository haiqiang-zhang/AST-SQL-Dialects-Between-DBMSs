DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a INT, INDEX (a));
INSERT INTO t1 VALUES (),(),(),(),(),(),(),(),(),();
