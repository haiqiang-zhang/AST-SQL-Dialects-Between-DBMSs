
--
-- BUG#10308: purge log with subselect
-- Bug#28553: mysqld crash in "purge master log before(select time from information_schema)"
--
--disable_query_log
CALL mtr.add_suppression("file *  was not purged because it is the active log file.");

--
-- Bug31048: Many nested subqueries may cause server crash.
--
create table t1(a int,b int,key(a),key(b));
insert into t1(a,b) values (1,2),(2,1),(2,3),(3,4),(5,4),(5,5),
  (6,7),(7,4),(5,3);

let $nesting= 26;
let $should_work_nesting= 5;
let $start= select sum(a),a from t1 where a> ( select sum(a) from t1 ;
let $end= )group by a ;
let $start_app= where a> ( select sum(a) from t1 ;
let $end_pre= )group by b limit 1 ;
  let $start= $start
  $start_app;
  let $end= $end_pre
  $end;
  dec $should_work_nesting;
  let $start= $start
  $start_app;
  let $end= $end_pre
  $end;
  dec $nesting;
drop table t1;

--
-- BUG#33245 "Crash on VIEW referencing FROM table in an IN clause"
-- (this is a second copy of testcase that uses disconnect/connect commands
--  which increase probability of crash)
--disconnect default
--connect (default,localhost,root,,test)
CREATE TABLE t1 (f1 INT NOT NULL);
CREATE VIEW v1 (a) AS SELECT f1 IN (SELECT f1 FROM t1) FROM t1;
SELECT * FROM v1;
drop view v1;
drop table t1;

-- Used to hit an assertion when run with --ps-protocol.
--error ER_GIS_INVALID_DATA
SELECT * FROM (SELECT ST_EXTERIORRING(1)) AS t1, (SELECT 1) AS t2;
