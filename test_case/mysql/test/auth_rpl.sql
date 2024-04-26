
--
-- Check that replication slave can connect to master using an account
-- which authenticates with an external authentication plugin (bug#12897501).

--
-- First stop the slave to guarantee that nothing is replicated.
--
--connection slave
--echo [connection slave]
--source include/stop_slave.inc
--
-- Create an replication account on the master.
--
--connection master
--echo [connection master]
CREATE USER 'plug_user' IDENTIFIED WITH 'test_plugin_server' AS 'plug_user';

--
-- Now go to slave and change the replication user.
--
--connection slave
--echo [connection slave]
--let $master_user= query_get_value(SHOW SLAVE STATUS, Master_User, 1)
--replace_column 2 --###
CHANGE REPLICATION SOURCE TO 
  SOURCE_USER=     'plug_user',
  SOURCE_PASSWORD= 'plug_user',
  SOURCE_RETRY_COUNT= 0;

--
-- Start slave with new replication account - this should trigger connection
-- to the master server.
--
--source include/start_slave.inc

-- Replicate all statements executed on master, in this case,
-- (creation of the plug_user account).
--
--connection master
--sync_slave_with_master
--echo -- Slave in-sync with master now.

SELECT user, plugin, authentication_string FROM mysql.user WHERE user LIKE 'plug_user';

--
-- Now we can stop the slave and clean up.
--
-- Note: it is important that slave is stopped at this
-- moment - otherwise master's cleanup statements
-- would be replicated on slave!
--
--echo -- Cleanup (on slave).
--source include/stop_slave.inc
--replace_column 2 --###
eval CHANGE REPLICATION SOURCE TO SOURCE_USER='$master_user';
DROP USER 'plug_user';
DROP USER 'plug_user';
