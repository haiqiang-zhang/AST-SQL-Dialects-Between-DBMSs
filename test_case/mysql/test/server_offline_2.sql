
-- source include/not_threadpool.inc

-- test case 2.1.6 1)
--disable_warnings
SELECT * FROM performance_schema.global_variables WHERE variable_name LIKE '%offline_mode%';
let $global_saved_tmp =  `SELECT @@global.offline_mode`;
let $user_count= `SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE USER != 'event_scheduler'`;

-- Create 3 non-super users

CREATE USER 'user1'@'localhost';
CREATE USER 'user2'@'localhost';
CREATE USER 'user3'@'localhost';

SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

SET GLOBAL offline_mode = ON;

-- Wait until all non super user have been disconnected (for slow machines)
let $count_sessions= $user_count;

SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- test case 2.1.1 5)
--disconnect default

-- To remove connect info on client side (mysqltest client).
--disconnect conu1
--disable_connect_log
--disable_query_log
--error ER_SERVER_OFFLINE_MODE
--connect(conu1,localhost,user1)
--enable_query_log
--echo connect(conu1,localhost,user1)
--connect(root,localhost,root)
--echo connect(root,localhost,root)
-- Wait until all non super user have been disconnected (for slow machines)
let $count_sessions= $user_count;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- Clean up

DROP USER 'user1'@'localhost';
DROP USER 'user2'@'localhost';
DROP USER 'user3'@'localhost';
