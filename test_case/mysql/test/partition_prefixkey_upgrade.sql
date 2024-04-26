--                PART OF UNIQUE KEY
--     WL#13588 : Deprecate support for prefix keys in partition functions
--
--##############################################################################
--   To create the file std_data/data57_partition_prefix_key.zip
--
--   - In 5.7, execute:
--
--       CREATE SCHEMA test;
--       USE test;
--       CREATE TABLE t1(
--           a VARCHAR(10000),
--           b VARCHAR(10),
--           PRIMARY KEY(a(100), b)
--       ) ENGINE=InnoDB DEFAULT CHARSET=latin1 PARTITION BY KEY() PARTITIONS 3;
--       INSERT INTO t1 VALUES
--           ('a','a'),
--           ('a','b'),
--           ('b','a'),
--           ('a','aa'),
--           ('aa','a'),
--           ('a','zz'),
--           ('zz','a');
--       CREATE TABLE t3(a VARCHAR(10000),
--           b VARCHAR(10),
--           PRIMARY KEY(a(25), b),
--           UNIQUE KEY i (b)
--       ) ENGINE=InnoDB DEFAULT CHARSET=latin1 PARTITION BY KEY() PARTITIONS 2;
--   - then zip the data folder
--
--       zip -r data57_partition_prefix_key.zip db/
--
--##############################################################################

--echo -- Copy the 5.7 data zip file to working directory.
--copy_file $MYSQLTEST_VARDIR/std_data/data57_partition_prefix_key.zip $MYSQL_TMP_DIR/data57_partition_prefix_key.zip

--echo -- Check that the zip file exists in the working directory.
--file_exists $MYSQL_TMP_DIR/data57_partition_prefix_key.zip

--echo -- Unzip 5.7 data directory.
--exec unzip -qo $MYSQL_TMP_DIR/data57_partition_prefix_key.zip -d $MYSQL_TMP_DIR/data57_partition_prefix_key

--echo -- Set data directory to the 5.7 data directory.
--let $MYSQLD_DATADIR1= $MYSQL_TMP_DIR/data57_partition_prefix_key/db

--echo -- Set log directory.
--let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/data57_partition_prefix_key.log

--replace_result $MYSQLD MYSQLD $MYSQLD_DATADIR1 MYSQLD_DATADIR1 $MYSQLD_LOG MYSQLD_LOG

--echo -- Stop DB server which was created by MTR default
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

--echo -- Restart server to trigger upgrade.
--exec echo "restart: --datadir=$MYSQLD_DATADIR1 --log-error=$MYSQLD_LOG" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--let $wait_counter= 10000
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- Check for errors in the error log.
--let SEARCH_FILE= $MYSQLD_LOG
--let SEARCH_PATTERN= \[ERROR\]
--source include/search_pattern.inc

--echo
--echo -- Should show deprecation warnings in the error log when upgrading
--echo -- from 5.7.
--let SEARCH_FILE= $MYSQLD_LOG
--let SEARCH_PATTERN= Usage of column 'test\.t1\.a' having prefix key part 'a\(100\)' in the PARTITION BY KEY\(\) clause is deprecated and will be removed in a future release\.
--source include/search_pattern.inc

--let SEARCH_FILE= $MYSQLD_LOG
--let SEARCH_PATTERN= Usage of column 'test\.t3\.a' having prefix key part 'a\(25\)' in the PARTITION BY KEY\(\) clause is deprecated and will be removed in a future release\.
--source include/search_pattern.inc

--echo -- Check output of SHOW CREATE TABLE.
SHOW CREATE TABLE t1;
CREATE TABLE t2 (
  a VARCHAR(10000) NOT NULL,
  b VARCHAR(10) NOT NULL,
  PRIMARY KEY (a(100),b)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PARTITION BY KEY() PARTITIONS 3;

INSERT INTO t2 VALUES
    ('a','a'),
    ('a','b'),
    ('b','a'),
    ('a','aa'),
    ('aa','a'),
    ('a','zz'),
    ('zz','a');

SELECT  (SELECT GROUP_CONCAT('(',a,',',b,')') FROM t1 PARTITION(p0))
        = (SELECT GROUP_CONCAT('(',a,',',b,')') FROM t2 PARTITION(p0))
        as `p0_equal`,
        (SELECT GROUP_CONCAT('(',a,',',b,')') FROM t1 PARTITION(p1))
        = (SELECT GROUP_CONCAT('(',a,',',b,')') FROM t2 PARTITION(p1))
        as `p1_equal`,
        (SELECT GROUP_CONCAT('(',a,',',b,')') FROM t1 PARTITION(p2))
        = (SELECT GROUP_CONCAT('(',a,',',b,')') FROM t2 PARTITION(p2))
        as `p2_equal`;
--   Test for deprecation warning to be shown in the error log on upgrade
--   from an earlier 8.0.x version.
--
--   To create the file std_data/data80019_partition_prefix_key.zip
--
--   - In 8.0.19, execute:
--
--       CREATE SCHEMA test;
--       USE test;
--       CREATE TABLE `t1` (
--        `a` VARCHAR(10000) NOT NULL,
--        `b` VARCHAR(10) NOT NULL,
--        PRIMARY KEY (`a`(100),`b`)
--       ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
--       PARTITION BY KEY () PARTITIONS 3;
