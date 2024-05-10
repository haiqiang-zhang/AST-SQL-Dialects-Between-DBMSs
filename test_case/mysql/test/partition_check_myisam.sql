CREATE TABLE t1 (c1 INT, PRIMARY KEY (c1)) ENGINE=INNODB;
CREATE TABLE t2 (c1 INT, PRIMARY KEY (c1),
                 FOREIGN KEY (c1) REFERENCES t1 (c1)
                 ON DELETE CASCADE)
ENGINE=INNODB;
DROP TABLE t2;
DROP TABLE t1;
create table t1 (int_column int, char_column char(5))
  PARTITION BY RANGE (int_column) subpartition by key (char_column) subpartitions 2
  (PARTITION p1 VALUES LESS THAN (5) ENGINE = InnoDB);
drop table t1;
