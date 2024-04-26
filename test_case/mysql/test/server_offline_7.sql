	  
--echo --
--echo -- WL#3836:  Method to bring servers off line
--echo --

--disable_query_log
CALL mtr.add_suppression("Unsafe statement written to the binary log using statement format since BINLOG_FORMAT = STATEMENT");

-- Save the global value to be used to restore the original value.
SET @global_saved_tmp =  @@global.offline_mode;

-- Create a database to be used by all the connections.
-- This is to ensure that all sessions connected to this DB is counted in this test case.

CREATE DATABASE wl3836;
USE wl3836;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE DB LIKE 'wl3836';

-- Create 2 non-super users

CREATE USER 'user1'@'localhost';
CREATE USER 'user2'@'localhost';

-- Non-super user cannot set this value
--error 1227
SET GLOBAL offline_mode=ON;

CREATE TABLE t1 (id INT PRIMARY KEY AUTO_INCREMENT) ENGINE=MYISAM;
CREATE TABLE t2 (id INT UNSIGNED NOT NULL);

INSERT INTO t1 VALUES
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0);
INSERT t1 SELECT 0 FROM t1 AS a1, t1 AS a2 LIMIT 4032;

INSERT INTO t2 SELECT id FROM t1;

-- Intentionally create a long running query
send SELECT id FROM t1 WHERE id IN
     (SELECT DISTINCT a.id FROM t2 a, t2 b, t2 c, t2 d
     GROUP BY ACOS(1/a.id), b.id, c.id, d.id
     HAVING a.id BETWEEN 10 AND 20);
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE DB LIKE 'wl3836';

SET GLOBAL offline_mode = ON;

-- Wait until all non super user have been disconnected (for slow machines)
let $wait_condition=SELECT COUNT(USER) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST WHERE DB LIKE 'wl3836';
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE DB LIKE 'wl3836';

-- No other non-super user should be allowed to connect
--error ER_SERVER_OFFLINE_MODE
--connection conu1

--echo -- Root user should be allowed to connect
--connect(conu3,localhost,root,'',wl3836)

--connection default

--echo -- Should report 2
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE DB LIKE 'wl3836';

SET GLOBAL offline_mode=OFF;

DROP DATABASE wl3836;

DROP USER 'user1'@'localhost';
DROP USER 'user2'@'localhost';
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET GLOBAL offline_mode=ON;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET @slave_saved_tmp = @@global.offline_mode;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET GLOBAL offline_mode=ON;
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
SET GLOBAL offline_mode = @slave_saved_tmp;
SET @@global.offline_mode = @global_saved_tmp;
