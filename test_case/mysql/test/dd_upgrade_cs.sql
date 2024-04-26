  --
  -- The datadir is created by building server version 80013 and executing the
  -- following SQL statements:
  --
  -- USE test;
  -- SET sql_mode = 'allow_invalid_dates';
  -- CREATE PROCEDURE p(OUT t DATETIME) SELECT now() INTO t;
  -- CREATE TABLE t(i INT);
  -- CREATE TRIGGER trg BEFORE INSERT ON t FOR EACH ROW SET @i = 1;
  -- CREATE EVENT eve ON SCHEDULE EVERY 1 HOUR DO SELECT 1;
  --
  -- Then, move data/ to data_80013_sql_modes/, and finally zip the entire
  -- directory (zip -r data_80013_sql_modes.zip data_80013_sql_modes).
  --
--copy_file $MYSQLTEST_VARDIR/std_data/upgrade/data_80013_sql_modes.zip $MYSQL_TMP_DIR/data_80013_sql_modes.zip
--file_exists $MYSQL_TMP_DIR/data_80013_sql_modes.zip
--exec unzip -qo $MYSQL_TMP_DIR/data_80013_sql_modes.zip -d $MYSQL_TMP_DIR
--let $MYSQLD_DATADIR_UPGRADE = $MYSQL_TMP_DIR/data_80013_sql_modes

--echo --#######################################################################
--echo -- Restart the server to trigger upgrade.
--echo --#######################################################################
--let $shutdown_server_timeout= 300
--let $wait_counter= 10000
--let $restart_parameters= restart: --datadir=$MYSQLD_DATADIR_UPGRADE --log-error=$MYSQLD_LOG --log-error-verbosity=3
--replace_result $MYSQLD_DATADIR_UPGRADE MYSQLD_DATADIR_UPGRADE $MYSQLD_LOG MYSQLD_LOG
--source include/restart_mysqld.inc

--echo --#######################################################################
--echo -- Verify that the entities have retained the SQL mode.
--echo --#######################################################################
USE test;

USE test;
CREATE TABLE t1 (f1 INT CHECK (f1 < 10));
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME='t1';
INSERT INTO t1 VALUES (100);
DROP TABLE t1;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_upgrade_2.log;
let $MYSQLD_DATADIR2 = $MYSQL_TMP_DIR/data_80012/data_80012;
SELECT TABLE_NAME, TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES
         WHERE TABLE_NAME = 'schema_auto_increment_columns' OR
               TABLE_NAME = 'schema_object_overview' OR
               TABLE_NAME = 'schema_redundant_indexes' OR
               TABLE_NAME = 'schema_unused_indexes' OR
               TABLE_NAME = 'x$schema_flattened_keys'
         ORDER BY TABLE_NAME;
SELECT COUNT(*) FROM mysql.global_grants
  WHERE user = 'mysql.session'
        AND host = 'localhost'
        AND priv = 'TABLE_ENCRYPTION_ADMIN';
SELECT COUNT(*) FROM mysql.global_grants
  WHERE user = 'mysql.session'
        AND host = 'localhost'
        AND priv = 'TABLE_ENCRYPTION_ADMIN';
SELECT COUNT(*) FROM mysql.global_grants
  WHERE user = 'mysql.session'
        AND host = 'localhost'
        AND priv = 'TABLE_ENCRYPTION_ADMIN';
ALTER TABLE test.t ENGINE = InnoDB;
ALTER TABLE test.t ENGINE = InnoDB;
ALTER TABLE t1 ADD COLUMN col2 VARCHAR(15);

let DATADIR= $MYSQL_TMP_DIR/data80028_invalid_opt_hints;
let MYSQLD_LOG= $MYSQL_TMP_DIR/data80028_invalid_opt_hints/error.log;
