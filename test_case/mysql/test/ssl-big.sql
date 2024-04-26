
-- source include/big_test.inc
-- source include/not_sparc_debug.inc
-- Skiping this test from Valgrind execution as per Bug-14627884
--source include/not_valgrind.inc
--source include/not_asan.inc
--source include/not_ubsan.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--disable_warnings
DROP TABLE IF EXISTS t1, t2;

SET @start_max_connections = @@global.max_connections;
SET @@global.max_connections = 2500;

--
-- Bug#29579 Clients using SSL can hang the server
--

connect (ssl_con,localhost,root,,,,,SSL);

create table t1 (a int);

let $count= 2000;
{
  connect (ssl_con,localhost,root,,,,,SSL);
  dec $count;

  -- This select causes the net buffer to fill as the server sends the results
  -- but the client doesn't reap the results. The results are larger each time
  -- through the loop, so that eventually the buffer is completely full
  -- at the exact moment the server attempts to the close the connection with
  -- the lock held.
  send select * from t1;

  -- now send the quit the command so the server will initiate the shutdown.
  send_quit ssl_con;

  -- if the server is hung, this will hang too:
  connect (ssl_con2,localhost,root,,,,,SSL);

  -- no hang if we get here, close and retry
  disconnect ssl_con2;

drop table t1;

SET @@global.max_connections = @start_max_connections;
