
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

-- Save master position
--let $saved_master_pos= query_get_value('SHOW BINARY LOG STATUS', Position, 1)

--echo -- Create user on the master
CREATE USER mohit@localhost IDENTIFIED BY 'mohit' PASSWORD HISTORY 1;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='mohit' AND Host='localhost';
DROP USER mohit@localhost;
