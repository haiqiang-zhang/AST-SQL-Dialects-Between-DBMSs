
-- Last modification:
-- 2009-01-19 H.Hunger Fix Bug#39108 main.wait_timeout fails sporadically
--                       - Increase wait timeout to 2 seconds
--                       - Eliminated the corresponding opt file,
--                         set global wait timeout within the test.
--                       - Replaced sleeps by wait condition
--                       - Minor improvements
--##############################################################################
-- source include/one_thread_per_connection.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc
SET @@global.log_error_verbosity= 3;

--
-- Bug#8731 wait_timeout does not work on Mac OS X
--

let $start_value= `SELECT @@global.wait_timeout`;
SET @@global.wait_timeout= 2;

-- Connect with another connection and reset counters
--disable_query_log
connect (wait_con,localhost,root,,test,,);
SET SESSION wait_timeout=100;
let $retries=300;
SET @aborted_clients= 0;

-- Disable reconnect and do the query
connect (default,localhost,root,,test,,);
SELECT 1;

-- Switch to wait_con and wait until server has aborted the connection
--disable_query_log
--echo connection wait_con;
{
  sleep 0.1;
  let $aborted_clients = `SHOW STATUS LIKE 'aborted_clients'`;

  dec $retries;
  if (!$retries)
  {
    die Failed to detect that client has been aborted;
  }
}
--enable_query_log
-- The server has disconnected, add small sleep to make sure
-- the disconnect has reached client
let $wait_condition= SELECT COUNT(*)=2 FROM information_schema.processlist;
SELECT 2;
SELECT 3;

--
-- Do the same test as above on a TCP connection
-- (which we get by specifying an ip adress)

-- Connect with another connection and reset counters
--disable_query_log
--echo connection wait_con;
let $retries=300;
SET @aborted_clients= 0;
SELECT 1;

-- Switch to wait_con and wait until server has aborted the connection
--disable_query_log
--echo connection wait_con;
{
  sleep 0.1;
  let $aborted_clients = `SHOW STATUS LIKE 'aborted_clients'`;

  dec $retries;
  if (!$retries)
  {
    die Failed to detect that client has been aborted;
  }
}
--enable_query_log
-- The server has disconnected, add small sleep to make sure
-- the disconnect has reached client
let $wait_condition= SELECT COUNT(*)=2 FROM information_schema.processlist;
SELECT 2;
SELECT 3;


-- The last connect is to keep tools checking the current test happy.
connect (default,localhost,root,,test,,);
LET $ID= `SELECT connection_id()`;
SET @@SESSION.wait_timeout = 2;
let $wait_condition=
  SELECT COUNT(*) = 0 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE ID = $ID;
SELECT 1;

LET $ID= `SELECT connection_id()`;
SET @@SESSION.wait_timeout = 2;
let $wait_condition=
  SELECT COUNT(*) = 0 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE ID = $ID;
SELECT 1;
SELECT "Check that we don't reconnect with reconnection disabled.";
