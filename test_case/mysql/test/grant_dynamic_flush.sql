
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc
enable_connect_log;
SELECT GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE FROM INFORMATION_SCHEMA.USER_PRIVILEGES
  WHERE PRIVILEGE_TYPE LIKE 'FLUSH_%' ORDER BY 1,2,3;
CREATE USER wl14303@localhost;
DROP USER wl14303@localhost;
CREATE USER wl14303@localhost;
DROP USER wl14303@localhost;
CREATE USER wl14303@localhost;
DROP USER wl14303@localhost;
CREATE USER wl14303@localhost;
CREATE TABLE t1(a int);
DROP USER wl14303@localhost;
DROP TABLE t1;
CREATE USER wl14303@localhost;
DROP USER wl14303@localhost;
CREATE USER wl14303@localhost;
DROP USER wl14303@localhost;
SET @saved_log_output = @@global.log_output;
SET @saved_general_log = @@global.general_log;

SET global log_output='table';
SET global general_log=on;
SET global general_log=@saved_general_log;
SET global log_output=@saved_log_output;


-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc
disable_connect_log;
