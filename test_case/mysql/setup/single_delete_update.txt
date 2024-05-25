CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (10),(11),(12),(13),(14),(15),(16),(17),(18),(19),
                      (20),(21),(22),(23),(24),(25),(26),(27),(28),(29),
                      (30),(31),(32),(33),(34),(35);
CREATE TABLE t2(a INT, i INT PRIMARY KEY);
INSERT INTO t2 (i) SELECT i FROM t1;
