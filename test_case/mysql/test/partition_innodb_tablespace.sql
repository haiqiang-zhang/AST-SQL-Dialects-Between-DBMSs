SET default_storage_engine=InnoDB;

-- Set up some variables
LET $MYSQLD_DATADIR = `select @@datadir`;
LET $INNODB_PAGE_SIZE = `select @@innodb_page_size`;
LET $data_directory = DATA DIRECTORY='$MYSQL_TMP_DIR/alternate_dir/data';
LET $data_directory2 = DATA DIRECTORY='$MYSQL_TMP_DIR/alternate_dir/data2';
LET $index_directory = INDEX DIRECTORY='$MYSQL_TMP_DIR/alternate_dir/data';

-- These values can change during the test
LET $innodb_file_per_table_orig=`select @@global.innodb_file_per_table`;
LET $innodb_strict_mode_orig=`select @@session.innodb_strict_mode`;
SET SESSION innodb_strict_mode = ON;
SET GLOBAL innodb_file_per_table = OFF;
     (PARTITION p0 engine=InnoDB $data_directory $index_directory,
      PARTITION p1 engine=InnoDB $data_directory $index_directory);
SET GLOBAL innodb_file_per_table = ON;
     (PARTITION p0 engine=InnoDB $data_directory,
      PARTITION p1 engine=InnoDB $data_directory2);
INSERT INTO t1 VALUES (1, "red");
INSERT INTO t1 VALUES (2, "green");
INSERT INTO t1 VALUES (3, "blue");
SELECT * FROM t1;
SELECT * FROM t1;

DROP TABLE t11;
SET GLOBAL innodb_file_per_table = ON;
     ENGINE = InnoDB PARTITION BY HASH (a)
     (PARTITION p0 engine=InnoDB $data_directory,
      PARTITION p1 engine=InnoDB $data_directory2)";
DROP TABLE t1;
SET GLOBAL innodb_file_per_table = ON;
    PARTITION BY RANGE( YEAR(purchased) )
    SUBPARTITION BY HASH( TO_DAYS(purchased) ) (
        PARTITION p0 VALUES LESS THAN (1990) (
            SUBPARTITION s0 $data_directory,
            SUBPARTITION s1 $data_directory2
        ),
        PARTITION p1 VALUES LESS THAN (2000) (
            SUBPARTITION s2 $data_directory,
            SUBPARTITION s3 $data_directory2
        ),
        PARTITION p2 VALUES LESS THAN MAXVALUE (
            SUBPARTITION s4 $data_directory,
            SUBPARTITION s5 $data_directory2
        )
    );
INSERT INTO t1 VALUES(1,'1980-05-31');
INSERT INTO t1 VALUES(2,'2090-05-31');
INSERT INTO t1 VALUES(3,'2012-05-31');
INSERT INTO t1 VALUES(4,'1970-05-31');
INSERT INTO t1 VALUES(5,'1985-05-31');
INSERT INTO t1 VALUES(6,'2006-05-31');
SELECT * FROM t1;
DROP TABLE t1;
SET GLOBAL innodb_file_per_table = ON;
    engine = innodb row_format = dynamic
    PARTITION BY RANGE( YEAR(purchased) )
    SUBPARTITION BY HASH( TO_DAYS(purchased) ) (
        PARTITION p0 VALUES LESS THAN (1990) (
            SUBPARTITION s0 $data_directory,
            SUBPARTITION s1 $data_directory2
        ),
        PARTITION p1 VALUES LESS THAN (2000) (
            SUBPARTITION s2 $data_directory,
            SUBPARTITION s3 $data_directory2
        ),
        PARTITION p2 VALUES LESS THAN MAXVALUE (
            SUBPARTITION s4 $data_directory,
            SUBPARTITION s5 $data_directory2
        )
    );
INSERT INTO t1 VALUES(1,'1980-05-31');
INSERT INTO t1 VALUES(2,'2090-05-31');
INSERT INTO t1 VALUES(3,'2012-05-31');
INSERT INTO t1 VALUES(4,'1970-05-31');
INSERT INTO t1 VALUES(5,'1985-05-31');
INSERT INTO t1 VALUES(6,'2006-05-31');
SELECT * FROM t1;

DROP TABLE t1;
DROP TABLE t1;

-- TODO : Enable following once shared tablespaces are allowed in Partitioned
--	 Tables (wl#12034).
-- --echo # Test TABLESPACE (and restart)
-- CREATE TABLESPACE `ts_part1` ADD DATAFILE 'ts_part1.ibd';
--  b varchar(128))
-- ENGINE = InnoDB
-- TABLESPACE ts_part1
-- PARTITION BY RANGE (a)
-- SUBPARTITION BY HASH (a) SUBPARTITIONS 3
-- (PARTITION p0 VALUES LESS THAN (0) TABLESPACE `ts part2`
--  (SUBPARTITION sp0 TABLESPACE ts_part3,
--   SUBPARTITION sp1,
--   SUBPARTITION sp2 TABLESPACE ts_part4),
--  PARTITION p1 VALUES LESS THAN (100)
--  (SUBPARTITION sp3,
--   SUBPARTITION sp4 TABLESPACE innodb_file_per_table,
--   SUBPARTITION sp5),
--  PARTITION p2 VALUES LESS THAN (200)
--  (SUBPARTITION sp6 TABLESPACE innodb_system,
--   SUBPARTITION sp7,
--   SUBPARTITION sp8),
--  PARTITION p3 VALUES LESS THAN (300) TABLESPACE innodb_file_per_table
--  (SUBPARTITION sp9 TABLESPACE ts_part4,
--   SUBPARTITION sp10,
--   SUBPARTITION sp11));
--  TABLESPACE `$long_tablespace_name`);
--  b varchar(128))
-- ENGINE = InnoDB
-- PARTITION BY RANGE (a)
-- SUBPARTITION BY HASH (a) SUBPARTITIONS 3
-- (PARTITION p0 VALUES LESS THAN (0) TABLESPACE `ts part2`
--  (SUBPARTITION sp0 TABLESPACE ts_part3,
--   SUBPARTITION sp1,
--   SUBPARTITION sp2 TABLESPACE ts_part4),
--  PARTITION p1 VALUES LESS THAN (100)
--  (SUBPARTITION sp3,
--   SUBPARTITION sp4 TABLESPACE innodb_file_per_table,
--   SUBPARTITION sp5),
--  PARTITION p2 VALUES LESS THAN (200)
--  (SUBPARTITION sp6 TABLESPACE innodb_system,
--   SUBPARTITION sp7,
--   SUBPARTITION sp8),
--  PARTITION p3 VALUES LESS THAN (300) TABLESPACE innodb_file_per_table
--  (SUBPARTITION sp9 TABLESPACE ts_part4,
--   SUBPARTITION sp10,
--   SUBPARTITION sp11));

SET @@global.innodb_file_per_table = ON;
CREATE TABLE t_file_per_table_on
(a int not null auto_increment primary key,
 b varchar(128))
ENGINE = InnoDB;
SET @@global.innodb_file_per_table = OFF;
CREATE TABLE t_file_per_table_off
(a int not null auto_increment primary key,
 b varchar(128))
ENGINE = InnoDB;
SET @@global.innodb_file_per_table = ON;

ALTER TABLE t1 COALESCE PARTITION 1;
--	 Tables (wl#12034).
-- SHOW CREATE TABLE t2;
SET @old_sql_quote_show_create=@@sql_quote_show_create;
SET @@sql_quote_show_create=0;
--	 Tables (wl#12034).
-- SHOW CREATE TABLE t2;
SET @@sql_quote_show_create=@old_sql_quote_show_create;
let $MYSQLD_DATADIR=`SELECT @@datadir`;
let $INNODB_PAGE_SIZE=`SELECT @@innodb_page_size`;
DROP TABLE t1;

-- TODO : Enable following once shared tablespaces are allowed in Partitioned
--	 Tables (wl#12034).
-- DROP TABLE t1,t2,t3;

SET @@global.innodb_file_per_table = ON;
SET @@global.innodb_file_per_table = OFF;
DROP TABLE t_file_per_table_on;
DROP TABLE t_file_per_table_off;

-- TODO : Enable following once shared tablespaces are allowed in Partitioned
--	 Tables (wl#12034).
-- #
-- # Bug#25512556: GETTING TABLESPACE NAMES FROM FREED MEMORY
-- #
-- CREATE TABLE t0 (col1 INT, col2 INT, col3 INT) ENGINE = InnoDB
--   TABLESPACE innodb_system PARTITION BY RANGE(col1 * 2)
--   ( PARTITION p2 VALUES LESS THAN MAXVALUE );
--   ( PARTITION p3 VALUES LESS THAN MAXVALUE );

-- DROP TABLE t1;
