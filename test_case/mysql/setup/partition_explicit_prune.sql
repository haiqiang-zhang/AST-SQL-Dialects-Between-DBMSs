create table thread_to_monitor(thread_id int);
CREATE TABLE t1 (a int)
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 2;
INSERT INTO t1 VALUES (0), (1), (2), (3);
CREATE VIEW v1 AS SELECT a FROM t1 PARTITION (p0);