SELECT @saved_long_query_time, @saved_log_output, @saved_general_log, @saved_slow_query_log;
create table join_test (verbose_comment varchar (80), command_type varchar(64));
insert into join_test values ("User performed a usual SQL query", "Query");
insert into join_test values ("New DB connection was registered", "Connect");
insert into join_test values ("Get the table info", "Field List");
drop table join_test;
select _koi8r'ÃÂÃÂÃÂÃÂ' as test;
select sleep(2);
unlock tables;
unlock tables;
drop procedure if exists proc25422_truncate_slow;
drop procedure if exists proc25422_truncate_general;
drop procedure if exists proc25422_alter_slow;
drop procedure if exists proc25422_alter_general;
DROP TABLE IF EXISTS `db_17876.slow_log_data`;
DROP TABLE IF EXISTS `db_17876.general_log_data`;
DROP PROCEDURE IF EXISTS `db_17876.archiveSlowLog`;
DROP PROCEDURE IF EXISTS `db_17876.archiveGeneralLog`;
DROP DATABASE IF EXISTS `db_17876`;
CREATE DATABASE db_17876;
CREATE TABLE `db_17876.slow_log_data` (
  `start_time` timestamp  default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `user_host` mediumtext ,
  `query_time` time ,
  `lock_time` time ,
  `rows_sent` int(11) ,
  `rows_examined` int(11) ,
  `db` varchar(512) default NULL,
  `last_insert_id` int(11) default NULL,
  `insert_id` int(11) default NULL,
  `server_id` int(11) default NULL,
  `sql_text` mediumblob,
  `thread_id` bigint(21) unsigned not NULL
);
CREATE TABLE `db_17876.general_log_data` (
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_host` mediumtext,
  `thread_id` bigint(21) unsigned not NULL,
  `server_id` int(11) DEFAULT NULL,
  `command_type` varchar(64) DEFAULT NULL,
  `argument` mediumblob
);
INSERT INTO
            `db_17876.general_log_data`
            VALUES(event_time, user_host, thread_id, server_id,
            command_type, argument);
select "put something into general_log";
select "... and something more ...";
DROP TABLE `db_17876.slow_log_data`;
DROP TABLE `db_17876.general_log_data`;
DROP PROCEDURE IF EXISTS `db_17876.archiveSlowLog`;
DROP PROCEDURE IF EXISTS `db_17876.archiveGeneralLog`;
DROP DATABASE IF EXISTS `db_17876`;
select CONNECTION_ID() into @thread_id;
prepare long_query from "select ? as long_query";
deallocate prepare long_query;
DROP TABLE IF EXISTS log_count;
DROP TABLE IF EXISTS slow_log_copy;
DROP TABLE IF EXISTS general_log_copy;
CREATE TABLE log_count (count BIGINT(21));
DROP TABLE log_count;
CREATE TABLE t1 (f1 SERIAL,f2 INT, f3 INT, PRIMARY KEY(f1), KEY(f2));
INSERT INTO t1 VALUES (1,1,1);
INSERT INTO t1 VALUES (2,2,2);
INSERT INTO t1 VALUES (3,3,3);
INSERT INTO t1 VALUES (4,4,4);
SELECT SQL_NO_CACHE 'Bug#31700 - SCAN',f1,f2,f3,SLEEP(1.1) FROM t1 WHERE f3=4;
SELECT SQL_NO_CACHE 'Bug#31700 - KEY', f1,f2,f3,SLEEP(1.1) FROM t1 WHERE f2=3;
SELECT SQL_NO_CACHE 'Bug#31700 - PK',  f1,f2,f3,SLEEP(1.1) FROM t1 WHERE f1=2;
DROP TABLE t1;
drop table if exists renamed_general_log;
drop table if exists renamed_slow_log;
unlock tables;
SELECT @@general_log;
