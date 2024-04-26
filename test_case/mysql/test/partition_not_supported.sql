
if ($ENGINE == "")
{
  --let $ENGINE=Archive
  --source partition_not_supported.test
  --let $ENGINE=Blackhole
  --source partition_not_supported.test
  --let $ENGINE=CSV
  --source partition_not_supported.test
  --let $ENGINE=Heap
  --source partition_not_supported.test
  --let $ENGINE=Memory
  --source partition_not_supported.test
  exit;
    SUBPARTITION s1,
    SUBPARTITION s2),
  PARTITION p1 VALUES IN (1)
   (SUBPARTITION s3,
    SUBPARTITION s4,
    SUBPARTITION s5));
ALTER TABLE t1
  PARTITION BY HASH (i) PARTITIONS 2;

DROP TABLE t1;
ALTER TABLE t1
  PARTITION BY RANGE (i) SUBPARTITION BY HASH (i)
  (PARTITION p0 VALUES LESS THAN (50)
   (SUBPARTITION s0,
    SUBPARTITION s1),
  PARTITION p1 VALUES LESS THAN (100)
   (SUBPARTITION s2,
    SUBPARTITION s3));

DROP TABLE t1;

CREATE TABLE t1 (i INTEGER NOT NULL)
  ENGINE InnoDB;

ALTER TABLE t1
  PARTITION BY HASH (i) PARTITIONS 2;

DROP TABLE t1;
