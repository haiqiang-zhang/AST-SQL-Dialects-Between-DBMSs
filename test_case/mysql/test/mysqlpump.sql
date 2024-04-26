
-- Creating DB's and populating different types of data init for MYSQLPUMP testing.
-- source include/mysqlpump_stmt.inc

--echo -- basic testing
--exec $MYSQL_PUMP --default-parallelism=1 --parallel-schemas=3:db1,db2 --parallel-schemas=5:db3,bd1_1gb --databases db1 db2 db3 db1_1gb > $MYSQLTEST_VARDIR/tmp/full_bkp.sql

DROP DATABASE db1;
DROP DATABASE db2;
DROP DATABASE db3;
DROP DATABASE db1_1gb;

USE db1;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA='db1' AND TABLE_TYPE= 'BASE TABLE'
       ORDER BY TABLE_NAME;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA='db1' AND TABLE_TYPE= 'VIEW'
       ORDER BY TABLE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='db1' AND ROUTINE_TYPE= 'PROCEDURE'
       ORDER BY ROUTINE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='db1' AND ROUTINE_TYPE= 'FUNCTION'
       ORDER BY ROUTINE_NAME;
SELECT EVENT_NAME FROM INFORMATION_SCHEMA.EVENTS
       WHERE EVENT_SCHEMA='db1' ORDER BY EVENT_NAME;
SELECT TRIGGER_NAME FROM INFORMATION_SCHEMA.TRIGGERS
       WHERE TRIGGER_SCHEMA='db1' ORDER BY TRIGGER_NAME;
USE db2;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA='db2' AND TABLE_TYPE= 'BASE TABLE'
       ORDER BY TABLE_NAME;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA='db2' AND TABLE_TYPE= 'VIEW'
       ORDER BY TABLE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='db2' AND ROUTINE_TYPE= 'PROCEDURE'
       ORDER BY ROUTINE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='db2' AND ROUTINE_TYPE= 'FUNCTION'
       ORDER BY ROUTINE_NAME;
USE db3;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA='db3' AND TABLE_TYPE= 'BASE TABLE'
       ORDER BY TABLE_NAME;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA='db3' AND TABLE_TYPE= 'VIEW'
       ORDER BY TABLE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='db3' AND ROUTINE_TYPE= 'PROCEDURE'
       ORDER BY ROUTINE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='db3' AND ROUTINE_TYPE= 'FUNCTION'
       ORDER BY ROUTINE_NAME;
SELECT EVENT_NAME FROM INFORMATION_SCHEMA.EVENTS
       WHERE EVENT_SCHEMA='db3' ORDER BY EVENT_NAME;
SELECT TRIGGER_NAME FROM INFORMATION_SCHEMA.TRIGGERS
       WHERE TRIGGER_SCHEMA='db3' ORDER BY TRIGGER_NAME;

USE db1_1gb;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA='db1_1gb' AND TABLE_TYPE= 'BASE TABLE'
       ORDER BY TABLE_NAME;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
       WHERE TABLE_SCHEMA='db1_1gb' AND TABLE_TYPE= 'VIEW'
       ORDER BY TABLE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='db1_1gb' AND ROUTINE_TYPE= 'PROCEDURE'
       ORDER BY ROUTINE_NAME;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES
       WHERE ROUTINE_SCHEMA='db1_1gb' AND ROUTINE_TYPE= 'FUNCTION'
       ORDER BY ROUTINE_NAME;
SELECT EVENT_NAME FROM INFORMATION_SCHEMA.EVENTS
       WHERE EVENT_SCHEMA='db1_1gb' ORDER BY EVENT_NAME;
SELECT TRIGGER_NAME FROM INFORMATION_SCHEMA.TRIGGERS
       WHERE TRIGGER_SCHEMA='db1_1gb' ORDER BY TRIGGER_NAME;

-- parallel-schemas option testing

--exec $MYSQL_PUMP --parallel-schemas=2:db1 --include-databases=db1 --add-drop-database --add-drop-table --skip-dump-rows > $MYSQLTEST_VARDIR/tmp/output_file_1.sql
--exec $MYSQL_PUMP --parallel-schemas=3:db1_1gb --databases db1_1gb -d --max-allowed-packet=25MB > $MYSQLTEST_VARDIR/tmp/output_file_2.sql
--exec $MYSQL_PUMP --parallel-schemas=db3 -B db3 db1 --routines --events --triggers --protocol=tcp > $MYSQLTEST_VARDIR/tmp/output_file_4.sql
DROP DATABASE db1;
DROP DATABASE db3;

-- --compress-output testing
--exec $MYSQL_PUMP --default-parallelism=1 --parallel-schemas=3:db1 --include-databases=db1,db2 --compress-output=LZ4 > $MYSQLTEST_VARDIR/tmp/output_file_6.sql
--exec $MYSQL_PUMP --parallel-schemas=3:db2 --include-databases=db2 --compress-output=ZLIB > $MYSQLTEST_VARDIR/tmp/output_file_7.sql
--exec $MYSQL_PUMP --host=localhost --include-databases=db1_1gb --parallel-schemas=2:db1_1gb --complete-insert --compress --default-character-set=utf8mb3 > $MYSQLTEST_VARDIR/tmp/output_file_8.sql

--exec $MYSQL_PUMP --parallel-schemas=1:db1_1gb --include-databases=db1_1gb --extended-insert=10 > $MYSQLTEST_VARDIR/tmp/output_file_9.sql
--exec $MYSQL_PUMP --parallel-schemas=3:db1_1gb --include-databases=db1_1gb --insert-ignore  > $MYSQLTEST_VARDIR/tmp/output_file_10.sql
--exec $MYSQL_PUMP --parallel-schemas=2:db1 --include-databases=db1 --no-create-db --no-create-info --triggers --routines --events --max-allowed-packet=30M > $MYSQLTEST_VARDIR/tmp/output_file_11.sql
--exec $MYSQL_PUMP --parallel-schemas=2:db1_1gb --include-databases=db1_1gb --replace  > $MYSQLTEST_VARDIR/tmp/output_file_12.sql


--remove_files_wildcard $MYSQLTEST_VARDIR/tmp/  output_file*

-- Cleanup
DROP DATABASE db1;
DROP DATABASE db2;
DROP DATABASE db3;
DROP DATABASE db1_1gb;

--
-- Bug #21534277: MYSQLPUMP HAS NO --VERSION OPTION
--

--exec $MYSQL_PUMP --version 2>&1 > $MYSQLTEST_VARDIR/tmp/output_file.txt
--remove_file $MYSQLTEST_VARDIR/tmp/output_file.txt

--echo --
--echo -- Dump a table that has column statistics
--echo --
CREATE SCHEMA column_statistics_dump;
USE column_statistics_dump;
CREATE TABLE t1 (col1 INT);
INSERT INTO t1 VALUES (1), (2);
SELECT schema_name, table_name, column_name,
       JSON_EXTRACT(HISTOGRAM, '$."number-of-buckets-specified"')
FROM information_schema.COLUMN_STATISTICS;

DROP SCHEMA column_statistics_dump;

CREATE DATABASE db1;
USE db1;
CREATE TABLE t1(id INT);
INSERT INTO t1 SELECT 1;
CREATE VIEW v1 AS SELECT * FROM t1;

CREATE DATABASE db2;
USE db2;
CREATE TABLE t2(id INT);
INSERT INTO t2 SELECT 1;

CREATE USER 'u1'@'%' IDENTIFIED BY 'abc';

USE db2;
CREATE VIEW v2 AS SELECT * FROM t2;

DROP USER 'u1'@'%';

CREATE USER 'u1'@'%' IDENTIFIED BY 'abc';

-- Cleanup
DROP USER 'u1'@'%';
DROP DATABASE db1;
DROP DATABASE db2;
