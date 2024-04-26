let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data57;
--  how to record this test JSON result content mismatch
--  If required fix regex patterns in mysql-test/include/ibd2sdi.pl
--  and mysql-test/suite/innodb/include/ibd2sdi_replace_pattern.inc,
--  then run the test with --record option.
--########################

--echo --
--echo -- BUG#25805260: MYSQL 8.0.X CRASHES WHEN OLD-STYLE TRIGGER MISSES THE
--echo -- "CREATED" LINE IN .TRG.
--echo --

--echo -- Create a trigger without 'created' line. Without patch,
--echo -- the server exits during upgrade of trigger.
--write_file $MYSQL_TMP_DIR/data57/test/vt2.TRG
TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER tr1_bi BEFORE INSERT ON vt2 FOR EACH ROW SET @a:=1'
sql_modes=1073741824 1073741824
definers='root@localhost' 'root@localhost'
client_cs_names='latin1' 'latin1'
connection_cl_names='latin1_swedish_ci' 'latin1_swedish_ci'
db_cl_names='latin1_swedish_ci' 'latin1_swedish_ci'
EOF

--write_file $MYSQL_TMP_DIR/data57/test/tr1_bi.TRN
TYPE=TRIGGERNAME
trigger_table=vt2
EOF

--echo -- Create a table as same as mysql.proc to repeat Bug#24805140
--echo -- We need to add an entry in mysql.proc table of the zipped
--echo -- data data directory before upgrade starts.
--echo -- Without fix, data population for dictionary tables fail and
--echo -- upgrade aborts.

SET sql_mode='';
CREATE TABLE test.proc (db char(64) COLLATE utf8mb3_bin DEFAULT '' NOT NULL,
                        name char(64) DEFAULT '' NOT NULL,
                        type enum('FUNCTION','PROCEDURE') NOT NULL,
                        specific_name char(64) DEFAULT '' NOT NULL,
                        language enum('SQL') DEFAULT 'SQL' NOT NULL,
                        sql_data_access enum('CONTAINS_SQL',
                                             'NO_SQL',
                                             'READS_SQL_DATA',
                                             'MODIFIES_SQL_DATA')
                                        DEFAULT 'CONTAINS_SQL' NOT NULL,
                        is_deterministic enum('YES','NO') DEFAULT 'NO' NOT NULL,
                        security_type enum('INVOKER','DEFINER')
                                      DEFAULT 'DEFINER' NOT NULL,
                        param_list blob NOT NULL,
                        returns longblob DEFAULT '' NOT NULL,
                        body longblob NOT NULL,
                        definer char(93) COLLATE utf8mb3_bin DEFAULT '' NOT NULL,
                        created timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
                                          ON UPDATE CURRENT_TIMESTAMP,
                        modified timestamp NOT NULL
                                 DEFAULT '0000-00-00 00:00:00',
                        sql_mode set('REAL_AS_FLOAT', 'PIPES_AS_CONCAT',
                                     'ANSI_QUOTES', 'IGNORE_SPACE', 'NOT_USED',
                                     'ONLY_FULL_GROUP_BY',
                                     'NO_UNSIGNED_SUBTRACTION',
                                     'NO_DIR_IN_CREATE', 'POSTGRESQL', 'ORACLE',
                                     'MSSQL', 'DB2', 'MAXDB', 'NO_KEY_OPTIONS',
                                     'NO_TABLE_OPTIONS', 'NO_FIELD_OPTIONS',
                                     'MYSQL323', 'MYSQL40', 'ANSI',
                                     'NO_AUTO_VALUE_ON_ZERO',
                                     'NO_BACKSLASH_ESCAPES',
                                     'STRICT_TRANS_TABLES', 'STRICT_ALL_TABLES',
                                     'NO_ZERO_IN_DATE', 'NO_ZERO_DATE',
                                     'INVALID_DATES',
                                     'ERROR_FOR_DIVISION_BY_ZERO', 'TRADITIONAL',
                                     'NO_AUTO_CREATE_USER', 'HIGH_NOT_PRECEDENCE',
                                     'NO_ENGINE_SUBSTITUTION',
                                     'PAD_CHAR_TO_FULL_LENGTH') DEFAULT '' NOT NULL,
                        comment text COLLATE utf8mb3_bin NOT NULL,
                        character_set_client char(32) COLLATE utf8mb3_bin,
                        collation_connection char(32) COLLATE utf8mb3_bin,
                        db_collation char(32) COLLATE utf8mb3_bin, body_utf8 longblob,
                        PRIMARY KEY (db,name,type)) engine=MyISAM character set utf8mb3
                        comment='Stored Procedures';
INSERT INTO test.proc VALUES ('sp','bug24805140','PROCEDURE','bug24805140','SQL',
                              'CONTAINS_SQL','NO','DEFINER','out a int','',
                              'begin select requesting_trx_id from '
                              'information_schema.INNODB_LOCK_WAITS limit 1 into a;
                              'root@localhost','2016-10-05 21:44:21',
                              '2016-10-05 21:44:21',
                              'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,'
                              'NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,'
                              'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION',
                              '','utf8mb3','utf8_general_ci','latin1_swedish_ci',
                              'begin select requesting_trx_id from '
                              'information_schema.INNODB_LOCK_WAITS limit 1 into a;
                              ('sp','proc2','PROCEDURE','proc2','SQL',
                              'CONTAINS_SQL','NO','DEFINER','out b int','',
                              'begin select   @@show_compatibility_56 into b;
                              'root@localhost','2016-10-05 21:55:05',
                              '2016-10-05 21:55:05','ONLY_FULL_GROUP_BY,'
                              'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,'
                              'NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,'
                              'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION','',
                              'utf8mb3','utf8_general_ci','latin1_swedish_ci',
                              'begin select   @@show_compatibility_56 into b;
INSERT INTO `proc` VALUES ('test','downgrade_alter_proc','PROCEDURE',
                           'downgrade_alter_proc',
                           'SQL','CONTAINS_SQL','NO','INVOKER','','',
                           'BEGIN\n      SELECT c1, English, French FROM t1 '
                           'JOIN t2 ON t1.c3 = t2.col2;
                           'root@localhost','1988-04-25 20:45:00',
                           '1988-04-25 20:45:00','NO_ZERO_DATE','','latin1',
                           'latin1_swedish_ci','latin1_swedish_ci',
                           'BEGIN\n      SELECT c1, English, French FROM t1 '
                           'JOIN t2 ON t1.c3 = t2.col2;
                          ('test','my_test_func','FUNCTION','myfunc','SQL',
                           'CONTAINS_SQL','NO','DEFINER', '',
                           'varchar(20) CHARSET latin1',
                           'BEGIN\n  RETURN \'å\';
                           'root@localhost','2017-03-08 09:07:36',
                           '2017-03-08 09:07:36', 'ONLY_FULL_GROUP_BY,'
                           'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,'
                           'ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,'
                           'NO_ENGINE_SUBSTITUTION','','latin1','latin1_swedish_ci',
                           'latin1_swedish_ci','BEGIN\n  RETURN \'Ã¥\';
DROP TABLE test.proc;
let DB_OPT_FILE= $MYSQL_TMP_DIR/data57/db_charset_koi8r/db.opt;
EOF

--echo -- Files in 'test' dir
--list_files $MYSQL_TMP_DIR/data57/

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_upgrade_1.log;
let ENV_MYSQLD_LOG= $MYSQLD_LOG;

-- Add '--read-only' option in the scope of fix of Bug#26636238, to avoid creation of another bulky test.
--echo -- Start the DB server. Server will create and populate Dictionary tables.
--exec echo "restart: --loose-skip-log-bin --read-only --skip-log-replica-updates --datadir=$MYSQLD_DATADIR1 --log-error=$MYSQLD_LOG" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--let $wait_counter= 10000
--source include/wait_until_connected_again.inc

--echo -- Test for Bug#25518436 : MYSQL 8.0.1 - MYSQLD ERRORLOG HAS UPGRADE ERRORS
--echo --                         AT SERVER START AT LIVE UPGRADE
--echo -- Check for errors from sys schema.
--echo -- These errors should not be there.
--echo -- Look for error.
perl;
  use strict;
  my $log= $ENV{'ENV_MYSQLD_LOG'} or die;
  my $c_e= grep(/\[Warning\] Parsing \'sys\.diagnostics\' routine body failed\. Creating routine without parsing routine body/gi,<FILE>);
EOF
-- End of test case for Bug#25518436

--echo -- Sanity Testing after Server start
CREATE SCHEMA test123;
CREATE TABLE test123.t1(a int);
INSERT INTO test123.t1 values(1);
SELECT * FROM test123.t1;
DROP SCHEMA test123;

SELECT COLUMN_NAME,CHARACTER_MAXIMUM_LENGTH
  FROM INFORMATION_SCHEMA.COLUMNS col
    JOIN INFORMATION_SCHEMA.TABLES tab ON col.table_name=tab.table_name
  WHERE col.TABLE_NAME LIKE '%innodb_%_stats'
    AND col.COLUMN_NAME LIKE 'table_name';
SELECT * FROM test.vt2;


SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE, ENGINE, VERSION, ROW_FORMAT
 FROM INFORMATION_SCHEMA.tables WHERE table_schema='test';
SELECT * FROM aview.view_2;
SELECT * FROM aview.second_view;
SELECT * FROM aview.mixed_view2;
SET names utf8mb3;
SELECT * FROM information_schema.tables WHERE table_schema = 'test' and table_type='VIEW';
SET names default;
SELECT ROUTINE_NAME, CHARACTER_SET_NAME, CHARACTER_SET_CLIENT,  COLLATION_CONNECTION,
  DATABASE_COLLATION FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA='test'
  ORDER BY ROUTINE_NAME;
SELECT * FROM tablespace.t3;
INSERT INTO triggers.t1 VALUES(1);
UPDATE triggers.t1 SET a=2 WHERE a=1;
SELECT * FROM triggers.t2;

SELECT TRIGGER_SCHEMA, TRIGGER_NAME, EVENT_MANIPULATION, ACTION_TIMING,
 ACTION_ORDER FROM INFORMATION_SCHEMA.TRIGGERS WHERE TRIGGER_SCHEMA='triggers';
SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE
 CONSTRAINT_SCHEMA='foreign_keys' ORDER BY CONSTRAINT_SCHEMA,CONSTRAINT_NAME;
SELECT * FROM view_with_column_names.v1;
SELECT * FROM view_with_column_names.v2;
SELECT * FROM view_with_column_names.v3;
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE
TABLE_SCHEMA='view_with_column_names' ORDER BY TABLE_NAME,ORDINAL_POSITION;
let $restart_parameters = "restart: --loose-skip-log-bin --skip-log-replica-updates --datadir=$MYSQLD_DATADIR1";
let $restart_parameters =;
select count(*) from sakila.film_text;
select * from sakila.film_text where film_id = 984;
select * from sakila.film_text where match(title,description) against("SCISSORHANDS");
delete from sakila.film_text where film_id = 984;
SET GLOBAL innodb_optimize_fulltext_only=ON;

-- Create a directory to store json generated
--let $DEST_DIR=$MYSQL_TMP_DIR/sdi_dest/
--error 0,1
--force-rmdir $DEST_DIR
--mkdir $DEST_DIR

--echo -- Check SDI from vt2.ibd
--let JSON_FILE_PATH = $DEST_DIR/vt2.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/vt2.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/vt2.json $JSON_FILE_PATH
}

--echo -- Check SDI from t_json.ibd
--let JSON_FILE_PATH = $DEST_DIR/t_json.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/t_json.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/t_json.json $JSON_FILE_PATH
}

--echo -- Check SDI from t_gen_stored.ibd
--let JSON_FILE_PATH = $DEST_DIR/t_gen_stored.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/t_gen_stored.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/t_gen_stored.json $JSON_FILE_PATH
}

--echo -- Check SDI from t_dynamic.ibd
--let JSON_FILE_PATH = $DEST_DIR/t_dynamic.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/t_dynamic.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/t_dynamic.json $JSON_FILE_PATH
}

--echo -- Check SDI from t_compressed3.ibd
--let JSON_FILE_PATH = $DEST_DIR/t_compressed3.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/t_compressed3.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/t_compressed3.json $JSON_FILE_PATH
}

--echo -- Check SDI from t_compressed2.ibd
--let JSON_FILE_PATH = $DEST_DIR/t_compressed2.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/t_compressed2.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/t_compressed2.json $JSON_FILE_PATH
}

--echo -- Check SDI from t_compressed.ibd
--let JSON_FILE_PATH = $DEST_DIR/t_compressed.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/t_compressed.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/t_compressed.json $JSON_FILE_PATH
}

--echo -- Check SDI from t_blob_myisam.ibd
--let JSON_FILE_PATH = $DEST_DIR/t_blob_myisam.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/t_blob_myisam.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/t_blob_myisam.json $JSON_FILE_PATH
}

--echo -- Check SDI from t_blob.ibd
--let JSON_FILE_PATH = $DEST_DIR/t_blob.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/t_blob.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/t_blob.json $JSON_FILE_PATH
}

--echo -- Check SDI from opening_lines.ibd
--let JSON_FILE_PATH = $DEST_DIR/opening_lines.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/opening_lines.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/opening_lines.json $JSON_FILE_PATH
}

--echo -- Check SDI from jemp.ibd
--let JSON_FILE_PATH = $DEST_DIR/jemp.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/jemp.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/jemp.json $JSON_FILE_PATH
}

--echo -- Check SDI from geom.ibd
--let JSON_FILE_PATH = $DEST_DIR/geom.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test/geom.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/geom.json $JSON_FILE_PATH
}

--echo -- Check SDI from store.ibd
--let JSON_FILE_PATH = $DEST_DIR/store.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/store.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/store.json $JSON_FILE_PATH
}

--echo -- Check SDI from staff.ibd
--let JSON_FILE_PATH = $DEST_DIR/staff.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/staff.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/staff.json $JSON_FILE_PATH
}

--echo -- Check SDI from rental.ibd
--let JSON_FILE_PATH = $DEST_DIR/rental.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/rental.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/rental.json $JSON_FILE_PATH
}

--echo -- Check SDI from payment.ibd
--let JSON_FILE_PATH = $DEST_DIR/payment.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/payment.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/payment.json $JSON_FILE_PATH
}

--echo -- Check SDI from language.ibd
--let JSON_FILE_PATH = $DEST_DIR/language.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/language.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/language.json $JSON_FILE_PATH
}

--echo -- Check SDI from inventory.ibd
--let JSON_FILE_PATH = $DEST_DIR/inventory.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/inventory.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/inventory.json $JSON_FILE_PATH
}

--echo -- Check SDI from film_text.ibd
--let JSON_FILE_PATH = $DEST_DIR/film_text.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/film_text.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/film_text.json $JSON_FILE_PATH
}

--echo -- Check SDI from film_category.ibd
--let JSON_FILE_PATH = $DEST_DIR/film_category.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/film_category.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/film_category.json $JSON_FILE_PATH
}

--echo -- Check SDI from film_actor.ibd
--let JSON_FILE_PATH = $DEST_DIR/film_actor.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/film_actor.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/film_actor.json $JSON_FILE_PATH
}

--echo -- Check SDI from film.ibd
--let JSON_FILE_PATH = $DEST_DIR/film.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/film.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/film.json $JSON_FILE_PATH
}

--echo -- Check SDI from customer.ibd
--let JSON_FILE_PATH = $DEST_DIR/customer.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/customer.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/customer.json $JSON_FILE_PATH
}

--echo -- Check SDI from country.ibd
--let JSON_FILE_PATH = $DEST_DIR/country.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/country.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/country.json $JSON_FILE_PATH
}

--echo -- Check SDI from city.ibd
--let JSON_FILE_PATH = $DEST_DIR/city.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/city.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/city.json $JSON_FILE_PATH
}

--echo -- Check SDI from category.ibd
--let JSON_FILE_PATH = $DEST_DIR/category.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/category.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/category.json $JSON_FILE_PATH
}

--echo -- Check SDI from address.ibd
--let JSON_FILE_PATH = $DEST_DIR/address.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/address.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/address.json $JSON_FILE_PATH
}

--echo -- Check SDI from actor.ibd
--let JSON_FILE_PATH = $DEST_DIR/actor.json
--exec $IBD2SDI $MYSQLD_DATADIR1/sakila/actor.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/actor.json $JSON_FILE_PATH
}

--echo -- Check SDI from mysql.ibd
--let JSON_FILE_PATH = $DEST_DIR/mysql.json
--exec $IBD2SDI $MYSQLD_DATADIR1/mysql.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace_mysql.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/mysql.json $JSON_FILE_PATH
}

--echo -- Check SDI from ibdata1
--let JSON_FILE_PATH = $DEST_DIR/ibdata1.json
--exec $IBD2SDI $MYSQLD_DATADIR1/ibdata1 -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace_system.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/ibdata1.json $JSON_FILE_PATH
}

--echo -- Check SDI from test_tablespace_3.ibd
--let JSON_FILE_PATH = $DEST_DIR/test_tablespace_3.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test_tablespace_3.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/test_tablespace_3.json $JSON_FILE_PATH
}

--echo -- Check SDI from test_tablespace_2.ibd
--let JSON_FILE_PATH = $DEST_DIR/test_tablespace_2.json
--exec $IBD2SDI $MYSQLD_DATADIR1/test_tablespace_2.ibd -d $JSON_FILE_PATH 2>&1
--source suite/innodb/include/ibd2sdi_replace.inc
if ($MTR_RECORD == 0) {
--diff_files $SRC_DIR/test_tablespace_2.json $JSON_FILE_PATH
}

-- If --record is used, save the json files created in the $DEST_DIR
-- back to the $SRC_DIR.
if ($MTR_RECORD == 1) {
--copy_files_wildcard $DEST_DIR $SRC_DIR *.json
}

--echo -- Remove json files
--force-rmdir $DEST_DIR

--echo -- Remove copied files
--force-rmdir $MYSQL_TMP_DIR/data57

--echo --
--echo -- Bug#26944731 : UPGRADE TO 8.0 FAILS: DUPLICATE SET VALUES IN TABLE FROM A PERMISSIVE SQL_MODE..
--echo -- Bug#26948678 : MYSQLD: INVALID DEFAULT VALUE FOR 'CACHED_TIME'
--echo --
--echo -- Unzip the zip file.
--exec unzip -qo $MYSQL_TMP_DIR/data57.zip -d $MYSQL_TMP_DIR

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_upgrade_2.log;

-- These files are used by other test cases, and is not required here.
--remove_file $MYSQL_TMP_DIR/data57/test/55_temporal.frm
--remove_file $MYSQL_TMP_DIR/data57/test/55_temporal.MYD
--remove_file $MYSQL_TMP_DIR/data57/test/55_temporal.MYI
--force-rmdir $MYSQL_TMP_DIR/data57/partitions
--force-rmdir $MYSQL_TMP_DIR/data57/mismatch_frms

-- Copy .frm file with blackhole engine and duplicate values in SET
--copy_file $MYSQLTEST_VARDIR/std_data/t_set.frm $MYSQL_TMP_DIR/data57/test/t_set.frm
-- Test with --explicit-defaults-for-timestamp=0
--exec echo "restart: --loose-skip-log-bin --explicit-defaults-for-timestamp=0 --skip-log-replica-updates --skip-replica-preserve-commit-order --datadir=$MYSQLD_DATADIR1 --log-error=$MYSQLD_LOG" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--let $wait_counter= 6000
--source include/wait_until_connected_again.inc

SHOW CREATE TABLE test.t_set;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_upgrade_3.log;
let $MYSQLD_DATADIR2 = $MYSQL_TMP_DIR/data57_upgrade_default_timezone_bug/data;
let $restart_parameters =;

let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_upgrade_4.log;
let $MYSQLD_DATADIR3 = $MYSQL_TMP_DIR/data_57022;
