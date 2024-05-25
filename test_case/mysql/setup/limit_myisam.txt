CREATE TABLE t1 (a INT, KEY (a)) ENGINE=Myisam;
INSERT INTO t1 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
DROP TABLE t1;
