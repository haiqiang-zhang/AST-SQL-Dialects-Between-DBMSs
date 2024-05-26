CREATE TABLE t1 (i INTEGER, KEY cached_key(i)) ENGINE=INNODB STATS_PERSISTENT=0;
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19);
DROP TABLE t1;
CREATE TABLE t1 (i INTEGER, KEY latest_key(i));
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
DROP TABLE t1;
