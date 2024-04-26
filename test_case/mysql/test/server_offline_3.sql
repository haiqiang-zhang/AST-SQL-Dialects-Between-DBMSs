
-- Save the global value to be used to restore the original value.
SET @global_saved_tmp =  @@global.offline_mode;
SET @global_autocommit =  @@global.autocommit;
SET @@global.autocommit= OFF;
let $user_count= `SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE USER != 'event_scheduler'`;

-- test case 2.1.1 3)
-- Create a non-super user

CREATE USER 'user1'@'localhost';
CREATE TABLE t2 (c1 int,c2 char(10));
INSERT INTO t2 VALUES (1,'aaaaaaaaaa');
INSERT INTO t2 VALUES (2,'bbbbbbbbbb');
SET GLOBAL offline_mode = ON;
let $count_sessions= $user_count;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET GLOBAL offline_mode = OFF;

-- Disconnect cleanup session infos on client side to be able to reconnect.
--disconnect conu1

--connect(conu1,localhost,user1)
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
SET @@global.autocommit= @global_autocommit;
