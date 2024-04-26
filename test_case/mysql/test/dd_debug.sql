--

--source include/have_debug.inc
--source include/have_debug_sync.inc

--source include/count_sessions.inc

let $MYSQLD_DATADIR= `SELECT @@datadir`;

SET GLOBAL DEBUG='+d,weak_object_impl_store_fail_before_store_children';
CREATE TABLE t1 (pk INT, col1 INT) ENGINE=InnoDB PARTITION BY KEY(pk) PARTITIONS 2;
SET GLOBAL DEBUG='-d,weak_object_impl_store_fail_before_store_children';
CREATE TABLE t1 (pk INT, col1 INT) ENGINE=InnoDB PARTITION BY KEY(pk) PARTITIONS 2;
DROP TABLE t1;

-- These can be removed after WL#9536 is implemented
call mtr.add_suppression("\\[ERROR\\] .*MY-\\d+.* Operating system error number .* in a file operation");

SET DEBUG= '+d, fail_while_storing_dd_object';
CREATE SCHEMA s1;
SET DEBUG= '-d, fail_while_storing_dd_object';
CREATE SCHEMA s1;

SET DEBUG= '+d, fail_while_acquiring_dd_object';
ALTER SCHEMA s1 DEFAULT COLLATE 'utf8_bin';
SET DEBUG= '-d, fail_while_acquiring_dd_object';

SET DEBUG= '+d, fail_while_storing_dd_object';
ALTER SCHEMA s1 DEFAULT COLLATE 'utf8_bin';
SET DEBUG= '-d, fail_while_acquiring_dd_object';
SET DEBUG_SYNC= 'before_acquire_in_drop_schema SIGNAL before_acquire WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR before_acquire';
SET GLOBAL DEBUG= '+d, fail_while_acquiring_dd_object';
SET DEBUG_SYNC= 'now SIGNAL cont';
SET DEBUG_SYNC= 'RESET';
SET GLOBAL DEBUG= '-d, fail_while_acquiring_dd_object';

SET DEBUG= '+d, pretend_no_schema_in_drop_schema';
DROP SCHEMA s1;
SET DEBUG= '-d, pretend_no_schema_in_drop_schema';

SET DEBUG= '+d, fail_while_dropping_dd_object';
DROP SCHEMA s1;
SET DEBUG= '-d, fail_while_dropping_dd_object';
DROP SCHEMA s1;
SET SESSION debug= '+d,skip_dd_table_access_check';
SELECT COUNT(*) FROM mysql.schemata WHERE name LIKE 's1';
SET SESSION debug= '-d,skip_dd_table_access_check';

SET DEBUG= '+d, fail_while_storing_dd_object';
CREATE TABLE t1 (pk INT PRIMARY KEY);
SET DEBUG= '-d, fail_while_storing_dd_object';
CREATE TABLE t1 (pk INT PRIMARY KEY) TABLESPACE no_such_tablespace;
SET DEBUG_SYNC= 'before_acquire_in_read_tablespace_encryption SIGNAL before_acquire WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR before_acquire';
SET GLOBAL DEBUG= '+d, fail_while_acquiring_dd_object';
SET DEBUG_SYNC= 'now SIGNAL cont';
SET DEBUG_SYNC= 'RESET';
SET GLOBAL DEBUG= '-d, fail_while_acquiring_dd_object';
CREATE TABLE t1 (pk INT PRIMARY KEY);

SET DEBUG= '+d, fail_while_acquiring_dd_object';
ALTER TABLE t1 ADD COLUMN c1 INT;
SET DEBUG= '-d, fail_while_acquiring_dd_object';

SET DEBUG= '+d, fail_while_dropping_dd_object';
DROP TABLE t1;
SET DEBUG= '-d, fail_while_dropping_dd_object';
DROP TABLE IF EXISTS t1;

CREATE TABLE v1_base_table (pk INT PRIMARY KEY);
SET DEBUG= '+d, fail_while_storing_dd_object';
CREATE VIEW v1 AS SELECT * from v1_base_table;
SET DEBUG= '-d, fail_while_storing_dd_object';
CREATE VIEW v1 AS SELECT pk from v1_base_table;

SET DEBUG= '+d, fail_while_acquiring_dd_object';
ALTER VIEW v1 AS SELECT pk FROM t1;
SET DEBUG= '-d, fail_while_acquiring_dd_object';

SET DEBUG= '+d, fail_while_dropping_dd_object';
DROP VIEW v1;
SET DEBUG= '-d, fail_while_dropping_dd_object';
DROP VIEW v1;
DROP TABLE v1_base_table;

SET DEBUG= '+d, fail_while_storing_dd_object';
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1.ibd';
SET DEBUG= '-d, fail_while_storing_dd_object';
SET SESSION debug= '+d,skip_dd_table_access_check';
SELECT COUNT(*) FROM mysql.tablespaces WHERE name LIKE 'ts1';
SET SESSION debug= '-d,skip_dd_table_access_check';
DROP TABLESPACE ts1;
CREATE TABLESPACE ts1 ADD DATAFILE 'ts1.ibd';

SET DEBUG= '+d, fail_while_dropping_dd_object';
DROP TABLESPACE ts1;
SET DEBUG= '-d, fail_while_dropping_dd_object';
SET SESSION debug= '+d,skip_dd_table_access_check';
SELECT COUNT(*) FROM mysql.tablespaces WHERE name LIKE 'ts1';
DROP TABLESPACE ts1;
SELECT COUNT(*) FROM mysql.tablespaces WHERE name LIKE 'ts1';
SET SESSION debug= '-d,skip_dd_table_access_check';

-- Errors found during RQG testing of WL#7743 have been reduced to the
-- following statement sequences:

CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE VIEW v1 AS SELECT * FROM t1;
ALTER TABLE t1 RENAME TO t2, MODIFY COLUMN pk INTEGER;
DROP TABLE IF EXISTS t1;
DROP VIEW v1;
DROP TABLE t2;

CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (i INT);
CREATE VIEW v1 AS SELECT * FROM t1, t2;
DROP TABLE t2;
ALTER TABLE t1 RENAME TO t2, MODIFY COLUMN pk INTEGER;
DROP TABLE IF EXISTS t1;
DROP VIEW v1;
DROP TABLE t2;

CREATE TABLE t1(a INT PRIMARY KEY);
CREATE VIEW v1 AS SELECT * FROM t1;
ALTER TABLE t1 RENAME TO t2, ALGORITHM= COPY;
DROP TABLE IF EXISTS t1;
DROP TABLE t2;
DROP VIEW v1;

CREATE TABLE t1 (pk INT PRIMARY KEY);
CREATE TABLE t2 (fk INT, FOREIGN KEY (FK) REFERENCES t1 (PK));
SET SESSION debug= '+d,skip_dd_table_access_check';
SELECT foreign_key_column_usage.referenced_column_name
FROM mysql.foreign_key_column_usage, mysql.foreign_keys, mysql.tables
WHERE tables.name= 't2'
AND tables.id = foreign_keys.table_id
AND foreign_keys.id = foreign_key_column_usage.foreign_key_id;
SET SESSION debug= '-d,skip_dd_table_access_check';

DROP TABLE t2, t1;
CREATE TABLE t1(a INT) Engine=InnoDB;
INSERT INTO t1 VALUES (1), (2);
let $con1_id= `select connection_id()`;
SET DEBUG_SYNC= "open_and_process_table SIGNAL kill_truncate WAIT_FOR killed";
SET DEBUG_SYNC= "now WAIT_FOR kill_truncate";
SET DEBUG_SYNC= "now SIGNAL killed";
DROP TABLE t1;
SET DEBUG_SYNC= "RESET";
CREATE TABLE t1(pk INT PRIMARY KEY, s VARCHAR(10), FULLTEXT idx(s));
SET debug = '+d,skip_dd_table_access_check';
SET debug = DEFAULT;
DROP TABLE t1;
