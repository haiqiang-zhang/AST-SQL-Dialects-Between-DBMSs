SELECT @@disabled_storage_engines;
SELECT @@default_storage_engine;
CREATE TABLE t1(c1 INT) ENGINE= MyISAM;
INSERT INTO t1 VALUES(1);
CREATE TABLE t2(c1 INT) ENGINE= InnoDB;
CREATE TEMPORARY TABLE t2(c1 INT) ENGINE= InnoDB;
ALTER TABLE t1 ENGINE= InnoDB;
SELECT @@disabled_storage_engines;
SELECT @@default_storage_engine;
SELECT * FROM t1;
DROP TABLE t2;
CREATE TABLE t3 LIKE t1;
CREATE TEMPORARY TABLE t4(c1 INT) ENGINE= MyISAM;
CREATE TABLE t5 (c1 INT) ENGINE= ARCHIVE;
ALTER TABLE t5 ENGINE= MyISAM;
CREATE TABLE t8 (c1 INT) ENGINE= MyISAM;
CREATE TABLE parent_table (i INT PRIMARY KEY);
CREATE TABLE child_table (
i INT,

CONSTRAINT fk_parent_table
FOREIGN KEY (i)
REFERENCES parent_table (i) ON DELETE CASCADE
) ENGINE=MyISAM;
DROP TABLE child_table;
DROP TABLE parent_table;
CREATE TEMPORARY TABLE tt1(c1 INT);
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
CREATE TABLE t1 (c1 INT) ENGINE= ARCHIVE;
CREATE TEMPORARY TABLE t1 (c1 INT) ENGINE= ARCHIVE;
ALTER TABLE t1 ENGINE= ARCHIVE;
CREATE TABLE t2 (c1 INT) ENGINE=ARCHIVE;
CREATE TEMPORARY TABLE t3 (c1 INT) ENGINE= ARCHIVE;
ALTER TABLE t1 ENGINE= ARCHIVE;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;