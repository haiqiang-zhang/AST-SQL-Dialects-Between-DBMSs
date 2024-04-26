
-- Save the global value to be used to restore the original value.
SET @global_saved_tmp =  @@global.offline_mode;
let $MYSQLD_DATADIR= `SELECT @@global.datadir`;
let $user_count= `SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE USER != 'event_scheduler'`;

-- test case 2.1.1 3)
CREATE USER 'user1'@'localhost';
use test;
CREATE TABLE t2 (c1 int,c2 char(10));
INSERT INTO t2 VALUES (1,'aaaaaaaaaa');
INSERT INTO t2 VALUES (2,'bbbbbbbbbb');

-- Check for temp files of ALTER taken from kill.test and modified.
--connection default
LOCK TABLE t2 read;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t2 add column j int";

-- Alter will completely be rolled back (No temp files available)
SET GLOBAL offline_mode = ON;
let $count_sessions= $user_count;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

SET GLOBAL offline_mode = OFF;
SELECT * FROM t2 ORDER BY c1;
DROP TABLE t2;
SET GLOBAL offline_mode = ON;
let $count_sessions= $user_count;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- Clean up
--disconnect conu1
-- Wait until all users have been disconnected (for slow machines)
let $count_sessions= $user_count;

DROP USER 'user1'@'localhost';
SET @@global.offline_mode = @global_saved_tmp;
