
CREATE TABLE t(a INT, b INT, c INT, KEY (a), KEY (b));
INSERT INTO t VALUES (1,2,3), (2,3,4), (3,4,5), (4,5,6), (5,6,7);
INSERT INTO t SELECT * FROM t;

SET debug = '+d,info';
SELECT * FROM t WHERE a = 1 AND b = 2;
SELECT * FROM t WHERE a = 1 OR b = 2;
SET debug = '-d,info';

DROP TABLE t;