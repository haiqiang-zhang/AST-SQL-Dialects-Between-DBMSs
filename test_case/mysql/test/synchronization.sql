
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--
-- Test for Bug#2385 CREATE TABLE LIKE lacks locking on source and destination
--                   table
--

--disable_warnings
DROP TABLE IF EXISTS t1,t2;

-- locking of source:

CREATE TABLE t1 (x1 INT);
let $1= 10;
{
  connection con1;
    send ALTER TABLE t1 CHANGE x1 x2 INT;
    CREATE TABLE t2 LIKE t1;
    replace_result x1 xx x2 xx $DEFAULT_ENGINE ENGINE;

    SHOW CREATE TABLE t2;
    DROP TABLE t2;
    reap;
    send ALTER TABLE t1 CHANGE x2 x1 INT;
    CREATE TABLE t2 LIKE t1;
    replace_result x1 xx x2 xx $DEFAULT_ENGINE ENGINE;

    SHOW CREATE TABLE t2;
    DROP TABLE t2;
    reap;
  dec $1;
DROP TABLE t1;
