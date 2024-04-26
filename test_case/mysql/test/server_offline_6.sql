
-- source include/not_threadpool.inc

-- X plugin might increase counter 'threads_connected' below
source include/xplugin_wait_for_interfaces.inc;
SELECT * FROM performance_schema.global_variables WHERE variable_name LIKE '%offline_mode%';
SET @global_saved_tmp =  @@global.offline_mode;
let $user_count= `SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE USER != 'event_scheduler'`;

-- test case 2.1.1 1)
-- Create 3 non-super users

CREATE USER 'user1'@'localhost';

SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- Create another super user session to see if it also survies.
--connect(conu4,localhost,root)
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET GLOBAL offline_mode = OFF;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SELECT * FROM performance_schema.global_variables WHERE variable_name LIKE '%offline_mode%';
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- Clean up
--disconnect conu1
--disconnect conu4

-- Wait until all users have been disconnected (for slow machines)
let $count_sessions= $user_count;

DROP USER 'user1'@'localhost';
SET @@global.offline_mode = @global_saved_tmp;
