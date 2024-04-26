
-- source include/not_threadpool.inc

-- Save the global value to be used to restore the original value.
SET @global_saved_tmp =  @@global.offline_mode;
let $user_count= `SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE USER != 'event_scheduler'`;

-- test case 2.1.1 1)
-- Create 3 non-super users

CREATE USER 'user1'@'localhost';
CREATE USER 'user2'@'localhost';
CREATE USER 'user3'@'localhost';
SET GLOBAL offline_mode = ON;

SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

SET GLOBAL offline_mode = ON;

-- Wait until all non super user have been disconnected (for slow machines)
let $count_sessions= $user_count;

SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- test case 2.1.1 6)
--echo error ER_SERVER_OFFLINE_MODE
--error ER_SERVER_OFFLINE_MODE
--connection conu1

--connection default
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET GLOBAL offline_mode = OFF;

-- test case 2.1.1 2)
-- Create another super user session to see if it also survies.
--connect(conu4,localhost,root)
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- test case 2.1.1 6)
--connection default
SET GLOBAL offline_mode = OFF;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- Disconnect cleanup session infos on client side to be able to reconnect.
--disconnect conu1
--disconnect conu2
--disconnect conu3
--connect(conu1,localhost,user1)
--connect(conu2,localhost,user2)
--connect(conu3,localhost,user3)

--connection default
SELECT @user_count;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

SET GLOBAL offline_mode = ON;

-- Wait until all non super user have been disconnected (for slow machines)
let $count_sessions= 1 + $user_count;

SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;

-- Clean up
--disconnect conu1
--disconnect conu2
--disconnect conu3
--disconnect conu4

-- Wait until all users have been disconnected (for slow machines)
let $count_sessions= $user_count;

DROP USER 'user1'@'localhost';
DROP USER 'user2'@'localhost';
DROP USER 'user3'@'localhost';
SET @@global.offline_mode = @global_saved_tmp;
