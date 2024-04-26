--           storage engines.
--

-- Test SQL statements  'CREATE [TEMPORARY] TABLE', 'ALTER TABLE ... ENGINE'
-- and 'CREATE/ALTER TABLESPACE' shall fail with the error "Storage engine
-- 'storage engine name' is disabled (Table creation is disallowed.)" for the
-- storage engines specified by disabled-storage-engine option.

--source include/have_example_plugin.inc

CALL mtr.add_suppression("default_storage_engine is set to a disabled storage engine .*");
CREATE TABLE t1(c1 int) ENGINE=HEAP;
CREATE TEMPORARY TABLE t1(c1 INT) ENGINE=HEAP;

CREATE TABLE t1 (c1 int) ENGINE=MYISAM;
INSERT INTO t1 VALUES(1);

CREATE TABLESPACE tb1 ADD DATAFILE 't1.ibd' ENGINE=INNODB;
CREATE TABLE tp1 (c1 int) PARTITION BY KEY (c1) PARTITIONS 1;

-- Restart server along with myisam storage engine  disabled and check alter
-- table on existing myisam table t1 created above is allowed.
--exec echo "restart: --disabled_storage_engines=innodb,myisam,heap,example" >$MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc
--source include/xplugin_wait_for_interfaces.inc

SHOW VARIABLES LIKE 'disabled_storage_engines';
SELECT * FROM t1;
ALTER TABLE t1 ENGINE=MyISAM, ADD COLUMN c2 INT;
ALTER TABLE t1 ADD COLUMN c3 INT;
CREATE TABLE t2 LIKE t1;
CREATE TEMPORARY TABLE t2 LIKE t1;
CREATE TABLE t2 AS SELECT * FROM t1;
CREATE TEMPORARY TABLE t2 AS SELECT * FROM t1;
ALTER TABLE t1 ENGINE=InnoDB;
ALTER TABLE t1 ENGINE=HEAP;
CREATE TABLE t2(c1 int) ENGINE=INNODB SELECT c1 FROM t1;
CREATE TABLE t2(c1 int) ENGINE=HEAP SELECT c1 FROM t1;
DROP TABLE t1;
CREATE TABLESPACE t1 ADD DATAFILE 't1.ibd' ENGINE=INNODB;
CREATE TABLESPACE t1 ADD DATAFILE 't1.ibd' ENGINE=HEAP;
ALTER TABLESPACE tb1 ADD DATAFILE 'ts.ibd' ENGINE=INNODB;
ALTER TABLESPACE tb1 ADD DATAFILE 'ts.ibd' ENGINE=HEAP;
ALTER TABLESPACE tb1 ADD DATAFILE 'ts.ibd';

-- After wl#8972 checks for the existence of tablespace happens before
-- checking if the SE is disabled, because we need to look the
-- tablespace up in the DD to find out what engine it is stored in.
-- Consequently, the dropping of tb1 had to delayed until no more
-- statements in the test reference it.
DROP TABLESPACE tb1;
CREATE TEMPORARY TABLE t1 (c1 int) ENGINE=INNODB;
CREATE TEMPORARY TABLE t1 (c1 int) ENGINE=HEAP;
CREATE PROCEDURE p1()
BEGIN
  CREATE TABLE t1 (c1 int) ENGINE=MYISAM;
END |

delimiter ;
DROP PROCEDURE p1;
CREATE TABLE t1 (c1 int) PARTITION BY KEY (c1) PARTITIONS 1;

INSERT INTO tp1 VALUES(1);
DROP TABLE tp1;
CREATE TABLE t1(a int) ENGINE=EXAMPLE;

-- Reload the plugin and ensure table creation is disallowed.
--replace_regex /\.dll/.so/
eval INSTALL PLUGIN example SONAME '$EXAMPLE_PLUGIN';
CREATE TABLE t1(a int) ENGINE=EXAMPLE;

SET default_storage_engine=MyISAM;
SET default_tmp_storage_engine=MyISAM;
SET default_storage_engine=default;
SET default_tmp_storage_engine=default;
CREATE TABLE t1(a int) ENGINE=MYISAM;
DROP TABLE t1;
