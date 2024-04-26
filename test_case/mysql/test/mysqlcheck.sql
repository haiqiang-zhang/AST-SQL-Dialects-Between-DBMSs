
--
-- Clean up after previous tests
--

--disable_warnings
DROP TABLE IF EXISTS t1, `t``1`, `t 1`;
drop view if exists v1;
drop database if exists client_test_db;
SET @have_ndb= (select count(engine) from information_schema.engines where engine='ndbcluster');
SET @create_cmd="CREATE TABLE mysql.ndb_binlog_index (i INTEGER PRIMARY KEY)
  ENGINE=INNODB STATS_PERSISTENT=0";
SET @drop_cmd="DROP TABLE mysql.ndb_binlog_index";

SET @create = IF(@have_ndb = 0, @create_cmd, 'SET @dummy = 0');
SET @drop = IF(@have_ndb = 0, @drop_cmd, 'SET @dummy = 0');
DROP PREPARE create_stmt;

--
-- Bug #13783  mysqlcheck tries to optimize and analyze information_schema
--
--replace_result 'Table is already up to date' OK
-- Filter out ndb_binlog_index to mask differences due to running with or
-- without ndb.
--replace_regex /mysql.ndb_binlog_index.*\n//
--exec $MYSQL_CHECK --all-databases --analyze
-- Filter out ndb_binlog_index to mask differences due to running with or
-- without ndb.
--replace_regex /mysql.ndb_binlog_index.*\n//
--exec $MYSQL_CHECK --all-databases --optimize
--replace_result 'Table is already up to date' OK
-- Filter out ndb_binlog_index to mask differences due to running with or
-- without ndb.
--replace_regex /mysql.ndb_binlog_index.*\n//
--exec $MYSQL_CHECK --analyze --databases test information_schema mysql
-- Filter out ndb_binlog_index to mask differences due to running with or
-- without ndb.
--replace_regex /mysql.ndb_binlog_index.*\n//
--exec $MYSQL_CHECK --optimize  --databases test information_schema mysql
--exec $MYSQL_CHECK --analyze information_schema schemata
--exec $MYSQL_CHECK --optimize information_schema schemata

-- Drop dummy ndb_binlog_index table
--disable_query_log
EXECUTE drop_stmt;
DROP PREPARE drop_stmt;

--
-- Bug#39541 CHECK TABLE on information_schema myisam tables produces error
--
create view v1 as select * from information_schema.routines;
drop view v1;


--
-- WL#3126 TCP address binding for mysql client library;
DROP DATABASE IF EXISTS b12688860_db;

CREATE DATABASE b12688860_db;
DROP DATABASE b12688860_db;

CREATE USER 'user_with_length_32_abcdefghijkl'@'localhost';

DROP USER 'user_with_length_32_abcdefghijkl'@'localhost';
