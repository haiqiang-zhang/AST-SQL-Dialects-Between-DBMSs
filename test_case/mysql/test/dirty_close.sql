

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (con1,localhost,root,,);
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (n INT);
INSERT INTO t1 VALUES (1),(2),(3);
SELECT * FROM t1;
DROP TABLE t1;

-- End of 4.1 tests

--
-- Bug#10374 GET_LOCK does not let connection to close on the server side if it's aborted
--

connection default;
SELECT GET_LOCK("dangling", 0);
let $wait_condition=
  SELECT COUNT(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST WHERE STATE = "User lock"
  AND INFO = "SELECT GET_LOCK('dangling', 3600)";
let $wait_condition=
  SELECT COUNT(*) = 0 FROM INFORMATION_SCHEMA.PROCESSLIST WHERE STATE = "User lock"
  AND INFO = "SELECT GET_LOCK('dangling', 3600)";
let $wait_condition=
  SELECT COUNT(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST WHERE STATE = "User lock"
  AND INFO = "SELECT GET_LOCK('dangling', 3600)";
SELECT RELEASE_LOCK('dangling');
