
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc


--
-- test of into outfile|dumpfile
--

--disable_warnings
drop table if exists t1;

create table t1 (`a` blob);
insert into t1 values("hello world"),("Hello mars"),(NULL);
select load_file(concat(@tmpdir,"/outfile-test.1"));
select load_file(concat(@tmpdir,"/outfile-test.2"));
select length(load_file(concat(@tmpdir,"/outfile-test.3")));

-- the following should give errors

disable_query_log;
select load_file(concat(@tmpdir,"/outfile-test.not-exist"));
drop table t1;

-- Bug#8191 SELECT INTO OUTFILE insists on FROM clause
disable_query_log;
select load_file(concat(@tmpdir,"/outfile-test.4"));

--
-- Bug#5382 'explain select into outfile' crashes the server
--

CREATE TABLE t1 (a INT);
  SELECT /*+ SET_VAR(optimizer_switch='hypergraph_optimizer=off') */ *
  INTO OUTFILE '/tmp/t1.txt'
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\r\n'
  FROM t1;
DROP TABLE t1;

-- End of 4.1 tests

--
-- Bug#13202 SELECT * INTO OUTFILE ... FROM information_schema.schemata now fails
--
disable_query_log;

use information_schema;
use test;

--
-- Bug#18628 mysql-test-run: security problem
--
-- It should not be possible to write to a file outside of vardir
create table t1(a int);
drop table t1;

--
-- Bug#28181 Access denied to 'information_schema when
-- select into out file (regression)
--
create database mysqltest;
create user user_1@localhost;
use test;
drop user user_1@localhost;
drop database mysqltest;
