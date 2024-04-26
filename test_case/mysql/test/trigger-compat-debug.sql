--   - Check that triggers created w/o DEFINER information work well:
--     - create the first trigger;
--     - manually remove definer information from corresponding TRG file;
--     - create the second trigger (the first trigger will be reloaded;
--       that we receive a warning);
--     - check that the triggers loaded correctly;

--
-- Prepare environment.
--

DELETE FROM mysql.user WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.db WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.tables_priv WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.columns_priv WHERE User LIKE 'mysqltest_%';
DROP DATABASE IF EXISTS mysqltest_db1;

CREATE DATABASE mysqltest_db1;

CREATE USER mysqltest_dfn@localhost;
CREATE USER mysqltest_inv@localhost;

--
-- Create a table and the first trigger.
--

--connect (wl2818_definer_con,localhost,mysqltest_dfn,,mysqltest_db1)
--connection wl2818_definer_con
--echo
--echo ---> connection: wl2818_definer_con

CREATE TABLE t1(num_value INT);
CREATE TABLE t2(user_str TEXT);

CREATE TRIGGER wl2818_trg1 BEFORE INSERT ON t1 FOR EACH ROW INSERT INTO t2 VALUES(CURRENT_USER());

--
-- Remove definers from TRG file.
--

--echo
--echo ---> patching t1.TRG...

-- Here we remove definers.  This is somewhat complex than the original test
-- Previously, the test only used grep -v 'definers=' t1.TRG, but grep is not
-- portable and we have to load the file into a table, exclude the definers line,
-- then load the data to an outfile to accomplish the same effect

--disable_query_log
--connection default
CREATE TABLE patch (a blob);
let $MYSQLD_DATADIR = `select @@datadir`;
DROP TABLE patch;

--
-- Create a new trigger.
--

--echo

CREATE TRIGGER wl2818_trg2 AFTER INSERT ON t1
  FOR EACH ROW
    INSERT INTO t2 VALUES(CURRENT_USER());

SELECT trigger_name, definer FROM INFORMATION_SCHEMA.TRIGGERS ORDER BY trigger_name;
SELECT * FROM INFORMATION_SCHEMA.TRIGGERS ORDER BY trigger_name;

-- Clean up
DROP TRIGGER wl2818_trg1;
DROP TRIGGER wl2818_trg2;
use mysqltest_db1;
DROP TABLE t1;
DROP TABLE t2;
DROP USER mysqltest_dfn@localhost;
DROP USER mysqltest_inv@localhost;
DROP DATABASE mysqltest_db1;
USE test;

--# Here we re-enable parsing the rest of the file
--enable_testcase

--echo --
--echo -- Bug#45235: 5.1 does not support 5.0-only syntax triggers in any way
--echo --
let $MYSQLD_DATADIR=`SELECT @@datadir`;
DROP TABLE IF EXISTS t1, t2, t3;

CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( a INT );
CREATE TABLE t3 ( a INT );
INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (1), (2), (3);
INSERT INTO t3 VALUES (1), (2), (3);

-- Since the new DD declares the columns mysql.triggers.client_collation_id,
-- mysql.triggers.connection_collation_id and mysql.triggers.schema_collation_id
-- as NOT NULL we do not need to test that 5.0 compatible triggers can be 
-- stored in the new DD. This task is out of scope for the WL#7896.
-- Therefore the following test is commented out.

--disable_testcase BUG--0000

--echo -- We simulate importing a trigger from 5.0 by writing a .TRN file for
--echo -- each trigger plus a .TRG file the way MySQL 5.0 would have done it, 
--echo -- with syntax allowed in 5.0 only.
--echo --
--echo -- Note that in 5.0 the following lines are missing from t1.TRG:
--echo --
--echo -- client_cs_names='latin1'
--echo -- connection_cl_names='latin1_swedish_ci'
--echo -- db_cl_names='latin1_swedish_ci'

--write_file $MYSQLD_DATADIR/test/tr11.TRN
TYPE=TRIGGERNAME
trigger_table=t1
EOF

--write_file $MYSQLD_DATADIR/test/tr12.TRN
TYPE=TRIGGERNAME
trigger_table=t1
EOF

--write_file $MYSQLD_DATADIR/test/tr13.TRN
TYPE=TRIGGERNAME
trigger_table=t1
EOF

--write_file $MYSQLD_DATADIR/test/tr14.TRN
TYPE=TRIGGERNAME
trigger_table=t1
EOF

--write_file $MYSQLD_DATADIR/test/tr15.TRN
TYPE=TRIGGERNAME
trigger_table=t1
EOF

--write_file $MYSQLD_DATADIR/test/t1.TRG
TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER tr11 BEFORE INSERT ON t1 FOR EACH ROW DELETE FROM t3' 'CREATE DEFINER=`root`@`localhost` TRIGGER tr12 AFTER INSERT ON t1 FOR EACH ROW DELETE FROM t3' 'CREATE DEFINER=`root`@`localhost` TRIGGER tr13 BEFORE DELETE ON t1 FOR EACH ROW DELETE FROM t1 a USING t1 a' 'CREATE DEFINER=`root`@`localhost` TRIGGER tr14 AFTER DELETE ON t1 FOR EACH ROW DELETE FROM non_existing_table' 'CREATE DEFINER=`root`@`localhost` TRIGGER tr15 BEFORE UPDATE ON t1 FOR EACH ROW DELETE FROM non_existing_table a USING non_existing_table a'
sql_modes=0 0 0 0 0
definers='root@localhost' 'root@localhost' 'root@localhost' 'root@localhost' 'root@localhost'
EOF

--write_file $MYSQLD_DATADIR/test/t2.TRG
TYPE=TRIGGERS
triggers='Not allowed syntax here, and trigger name cant be extracted either.'
sql_modes=0
definers='root@localhost'
EOF

FLUSH TABLE t1;

-- What we have to test is a fact that triggers with body that has syntax allowed
-- in 5.0 only can be handled in the same way as it was in 5.7, that is it produces
-- the corresponding error message.

CREATE DEFINER=`root`@`localhost` TRIGGER tr11 BEFORE INSERT ON t1 FOR EACH ROW SET @a=1;
CREATE DEFINER=`root`@`localhost` TRIGGER tr12 AFTER INSERT ON t1 FOR EACH ROW SET @a=1;
CREATE DEFINER=`root`@`localhost` TRIGGER tr13 BEFORE DELETE ON t1 FOR EACH ROW SET @a=1;
CREATE DEFINER=`root`@`localhost` TRIGGER tr14 AFTER DELETE ON t1 FOR EACH ROW SET @a=1;
CREATE DEFINER=`root`@`localhost` TRIGGER tr15 BEFORE UPDATE ON t1 FOR EACH ROW SET @a=1;

SET SESSION debug= '+d,skip_dd_table_access_check';
UPDATE mysql.triggers SET action_statement = 'DELETE FROM t1 a USING t1 a',
  action_statement_utf8 = 'DELETE FROM t1 a USING t1 a'
  WHERE name = 'tr13';
UPDATE mysql.triggers SET action_statement = 'DELETE FROM non_existing_table',
  action_statement_utf8 = 'DELETE FROM non_existing_table'
  WHERE name = 'tr14';
UPDATE mysql.triggers SET action_statement = 'DELETE FROM non_existing_table a USING non_existing_table a',
  action_statement_utf8= 'DELETE FROM non_existing_table a USING non_existing_table a'
  WHERE name = 'tr15';
SET SESSION debug= '-d,skip_dd_table_access_check';
CREATE TRIGGER tr16 AFTER UPDATE ON t1 FOR EACH ROW INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (1);
DELETE FROM t1;
UPDATE t1 SET a = 1 WHERE a = 1;
SELECT * FROM t1;
DROP TRIGGER tr13;
INSERT INTO t1 VALUES (1);
DELETE FROM t1;
UPDATE t1 SET a = 1 WHERE a = 1;

DROP TRIGGER tr11;
DROP TRIGGER tr12;
DROP TRIGGER tr14;
DROP TRIGGER tr15;

DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
