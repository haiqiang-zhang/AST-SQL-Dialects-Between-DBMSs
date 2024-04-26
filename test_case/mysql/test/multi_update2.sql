--

--
-- If we are running with
-- - debug tracing      -> @@session.debug LIKE '%trace%'
-- the resource consumption (storage space needed, runtime) will be extreme.
-- Therefore we require that the option "--big-test" is also set.
--
--source include/big_test.inc
--source include/not_valgrind.inc
-- timeout in debug mode on sparc
--source include/not_sparc_debug.inc
-- timeout with UBSAN
--source include/not_ubsan.inc

let $need_big= 0;
SET @aux = @@session.debug;
{
  -- We have returncode 0 = the server system variable @@session.debug exists.
  -- But we only need "--big-test" in case of tracing.
  if (`SELECT @@session.debug LIKE '%trace%'`)
  {
    let $need_big= 1;
  }
}
--enable_query_log
--
-- Bug#1820 Rows not deleted from second table on multi-table delete
--

--disable_warnings
DROP TABLE IF EXISTS t1,t2;

CREATE TABLE t1 ( a INT NOT NULL, b INT NOT NULL) ;
INSERT INTO t1 VALUES (1,1),(2,2),(3,3),(4,4);
let $1=19;
set @d=4;
{
  eval INSERT INTO t1 SELECT a+@d,b+@d FROM t1;
  dec $1;
ALTER TABLE t1 ADD INDEX i1(a);
DELETE FROM t1 WHERE a > 2000000;
CREATE TABLE t2 LIKE t1;
INSERT INTO t2 SELECT * FROM t1;

SELECT 't2 rows before small delete', COUNT(*) FROM t1;
DELETE t1,t2 FROM t1,t2 WHERE t1.b=t2.a AND t1.a < 2;
SELECT 't2 rows after small delete', COUNT(*) FROM t2;
SELECT 't1 rows after small delete', COUNT(*) FROM t1;

--# Try deleting many rows 

DELETE t1,t2 FROM t1,t2 WHERE t1.b=t2.a AND t1.a < 100*1000;
SELECT 't2 rows after big delete', COUNT(*) FROM t2;
SELECT 't1 rows after big delete', COUNT(*) FROM t1;

DROP TABLE t1,t2;
