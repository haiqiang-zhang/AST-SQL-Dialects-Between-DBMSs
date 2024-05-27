CREATE TABLE t1 (
 a int STORAGE DISK,
 b int STORAGE MEMORY NOT NULL,
 c int COLUMN_FORMAT DYNAMIC,
 d int COLUMN_FORMAT FIXED,
 e int COLUMN_FORMAT DEFAULT,
 f int STORAGE DISK COLUMN_FORMAT DYNAMIC NOT NULL,
 g int STORAGE MEMORY COLUMN_FORMAT DYNAMIC,
 h int STORAGE DISK COLUMN_FORMAT FIXED,
 i int STORAGE MEMORY COLUMN_FORMAT FIXED
);
ALTER TABLE t1
  ADD COLUMN j int STORAGE DISK,
  ADD COLUMN k int STORAGE MEMORY NOT NULL,
  ADD COLUMN l int COLUMN_FORMAT DYNAMIC,
  ADD COLUMN m int COLUMN_FORMAT FIXED,
  ADD COLUMN n int COLUMN_FORMAT DEFAULT,
  ADD COLUMN o int STORAGE DISK COLUMN_FORMAT DYNAMIC NOT NULL,
  ADD COLUMN p int STORAGE MEMORY COLUMN_FORMAT DYNAMIC,
  ADD COLUMN q int STORAGE DISK COLUMN_FORMAT FIXED,
  ADD COLUMN r int STORAGE MEMORY COLUMN_FORMAT FIXED;
ALTER TABLE t1
  MODIFY COLUMN j int STORAGE MEMORY NOT NULL,
  MODIFY COLUMN k int COLUMN_FORMAT DYNAMIC,
  MODIFY COLUMN l int COLUMN_FORMAT FIXED,
  MODIFY COLUMN m int COLUMN_FORMAT DEFAULT,
  MODIFY COLUMN n int STORAGE DISK COLUMN_FORMAT DYNAMIC NOT NULL,
  MODIFY COLUMN o int STORAGE MEMORY COLUMN_FORMAT DYNAMIC,
  MODIFY COLUMN p int STORAGE DISK COLUMN_FORMAT FIXED,
  MODIFY COLUMN q int STORAGE MEMORY COLUMN_FORMAT FIXED,
  MODIFY COLUMN r int STORAGE DISK;
ALTER TABLE t1
  MODIFY COLUMN h int COLUMN_FORMAT DYNAMIC COLUMN_FORMAT FIXED,
  MODIFY COLUMN i int COLUMN_FORMAT DYNAMIC COLUMN_FORMAT DEFAULT,
  MODIFY COLUMN j int COLUMN_FORMAT FIXED COLUMN_FORMAT DYNAMIC,
  MODIFY COLUMN k int COLUMN_FORMAT FIXED COLUMN_FORMAT DEFAULT,
  MODIFY COLUMN l int STORAGE DISK STORAGE MEMORY,
  MODIFY COLUMN m int STORAGE DISK STORAGE DEFAULT,
  MODIFY COLUMN n int STORAGE MEMORY STORAGE DISK,
  MODIFY COLUMN o int STORAGE MEMORY STORAGE DEFAULT,
  MODIFY COLUMN p int STORAGE DISK STORAGE MEMORY
                      COLUMN_FORMAT FIXED COLUMN_FORMAT DYNAMIC,
  MODIFY COLUMN q int STORAGE DISK STORAGE MEMORY STORAGE DEFAULT
                      COLUMN_FORMAT FIXED COLUMN_FORMAT DYNAMIC COLUMN_FORMAT DEFAULT,
  MODIFY COLUMN r int STORAGE DEFAULT STORAGE DEFAULT STORAGE MEMORY
                      STORAGE DISK STORAGE MEMORY STORAGE DISK STORAGE DISK;
DROP TABLE t1;
CREATE TABLESPACE `ts6` ADD DATAFILE 'ts6.ibd' ENGINE=INNODB;
CREATE TABLESPACE ts ADD DATAFILE 'ts.ibd' ENGINE=InnoDB;
DROP TABLESPACE ts;
CREATE TABLE t1 (i INTEGER) TABLESPACE innodb_file_per_table ENGINE InnoDB;
CREATE TABLE t2 (i INTEGER) TABLESPACE innodb_system ENGINE InnoDB;
ALTER TABLE t1 ENGINE InnoDB;
ALTER TABLE t1 TABLESPACE innodb_system ENGINE InnoDB;
ALTER TABLE t2 TABLESPACE innodb_file_per_table ENGINE InnoDB;
ALTER TABLE t1 ADD COLUMN (j INTEGER);
CREATE TABLESPACE ts ADD DATAFILE 'f.ibd' ENGINE InnoDB;
ALTER TABLE t1 TABLESPACE ts;
ALTER TABLE t1 ENGINE InnoDB;
ALTER TABLE t1 ENGINE InnoDB;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLESPACE ts;
CREATE TABLE t_part (i INTEGER) TABLESPACE innodb_file_per_table PARTITION BY RANGE(i)
PARTITIONS 2 (
    PARTITION p0 VALUES LESS THAN(100),
    PARTITION p1 VALUES LESS THAN(200));
CREATE TABLE t_subpart (i INTEGER) PARTITION BY RANGE(i)
PARTITIONS 2 SUBPARTITION BY HASH(i) (
    PARTITION p0 VALUES LESS THAN(100) (
      SUBPARTITION sp00,
      SUBPARTITION sp01),
    PARTITION p1 VALUES LESS THAN(200) (
      SUBPARTITION sp10,
      SUBPARTITION sp11));
ALTER TABLE t_subpart TABLESPACE innodb_file_per_table;
DROP TABLE t_part;
DROP TABLE t_subpart;
CREATE TABLESPACE ts ADD DATAFILE 'f.ibd' ENGINE InnoDB;
CREATE TABLE t1(i INT) TABLESPACE ts;
CREATE TABLESPACE altering ADD DATAFILE 'altering.ibd' ENGINE InnoDB;
CREATE TABLE altering_table (id int) TABLESPACE altering;
DROP TABLE altering_table;
DROP TABLESPACE altering;