CREATE TABLE t1(c1 int) ENGINE=HEAP;
CREATE TEMPORARY TABLE t1(c1 INT) ENGINE=HEAP;
INSERT INTO t1 VALUES(1);
CREATE TABLESPACE tb1 ADD DATAFILE 't1.ibd' ENGINE=INNODB;
CREATE TABLE tp1 (c1 int) PARTITION BY KEY (c1) PARTITIONS 1;