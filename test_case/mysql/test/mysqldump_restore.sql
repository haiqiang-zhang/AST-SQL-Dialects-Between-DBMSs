--           tables and data.  
--           We CREATE a table, mysqldump it to a file, ALTER the original
--           table's name, recreate the table from the mysqldump file, then
--           utilize include/diff_tables to compare the original and recreated
--           tables.
--
--           We use several examples from mysqldump.test here and include
--           the relevant bug numbers and headers from that test.
--
-- NOTE:     This test is not currently complete and offers only basic
--           cases of mysqldump output being restored. 
--           Also, does NOT work with -X (xml) output!
--           
-- Author:   pcrews
-- Created:  2009-05-21
-- Last Change:
-- Change date:
--##############################################################################

--source include/have_log_bin.inc

--echo -- Set concurrent_insert = 0 to prevent random errors
--echo -- will reset to original value at the end of the test
SET @old_concurrent_insert = @@global.concurrent_insert;
SET @@global.concurrent_insert = 0;

-- Define mysqldumpfile here.  It is used to capture mysqldump output
-- in order to test the output's ability to restore an exact copy of the table
let $mysqldumpfile = $MYSQLTEST_VARDIR/tmp/mysqldumpfile.sql;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (a DECIMAL(64, 20));
INSERT INTO t1 VALUES ("1234567890123456789012345678901234567890"),
("0987654321098765432109876543210987654321");
let $table_name = test.t1;
CREATE TABLE t1 (a DECIMAL(10,5), b FLOAT);
INSERT INTO t1 VALUES (1.2345, 2.3456);
INSERT INTO t1 VALUES ('1.2345', 2.3456);
INSERT INTO t1 VALUES ("1.2345", 2.3456);
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ANSI_QUOTES';
INSERT INTO t1 VALUES (1.2345, 2.3456);
INSERT INTO t1 VALUES ('1.2345', 2.3456);
INSERT INTO t1 VALUES ("1.2345", 2.3456);
SET SQL_MODE=@OLD_SQL_MODE;

-- check how mysqldump make quoting
--exec $MYSQL_DUMP --compact test t1 > $mysqldumpfile
let $table_name = test.t1;
CREATE TABLE t1 (a  VARCHAR(255)) DEFAULT CHARSET koi8r;
INSERT INTO t1  VALUES (_koi8r x'C1C2C3C4C5'), (NULL);
let $table_name = test.t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (4),(5),(6);
let $table_name = test.t2;
DROP TABLE t1;
CREATE TABLE t1 (`b` blob);
INSERT INTO `t1` VALUES (0x602010000280100005E71A);
let $table_name = test.t1;
SET @@global.concurrent_insert = @old_concurrent_insert;
