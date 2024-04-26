
-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

--echo --
--echo -- 1. Test MAX_EXECUTION_TIME option syntax.
--echo --

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (10);

SET @var= (SELECT /*+ MAX_EXECUTION_TIME(0) */ 1);
SELECT 1 FROM t1 WHERE a IN (SELECT /*+ MAX_EXECUTION_TIME(0) */ 1);

SELECT (SELECT /*+ MAX_EXECUTION_TIME(0) */ a FROM t1);
SELECT a FROM t1 WHERE a IN (SELECT /*+ MAX_EXECUTION_TIME(0) */ a FROM t1);
SELECT * FROM t1 WHERE a IN (SELECT /*+ MAX_EXECUTION_TIME(0) */ a FROM t1);
SELECT /*+ MAX_EXECUTION_TIME(0) */ * FROM t1
  WHERE a IN (SELECT /*+ MAX_EXECUTION_TIME(0) */ a FROM t1);
SELECT * FROM t1
  WHERE a IN (SELECT a FROM t1 UNION SELECT /*+ MAX_EXECUTION_TIME(0) */ a FROM t1);
SELECT /*+ MAX_EXECUTION_TIME(0) */ * FROM t1
  WHERE a IN (SELECT a FROM t1 UNION SELECT /*+ MAX_EXECUTION_TIME(0) */ a FROM t1);

SELECT * FROM t1 UNION SELECT /*+ MAX_EXECUTION_TIME(0) */ * FROM t1;
SELECT /*+ MAX_EXECUTION_TIME(0) */ * FROM t1
  UNION SELECT /*+ MAX_EXECUTION_TIME(0) */ * FROM t1;
INSERT INTO t1 SELECT /*+ MAX_EXECUTION_TIME(0) */ * FROM t1;
CREATE TABLE t2 AS SELECT /*+ MAX_EXECUTION_TIME(0) */ * FROM t1;
CREATE TABLE t3 AS SELECT 1 A UNION SELECT 2 UNION SELECT /*+ MAX_EXECUTION_TIME(0) */ 3;
CREATE TABLE /*+ MAX_EXECUTION_TIME(100) */ t4 (a int);
CREATE /*+ MAX_EXECUTION_TIME(100) */ TABLE t5 (a int);
DELETE /*+ MAX_EXECUTION_TIME(100) */ FROM t1;
UPDATE /*+ MAX_EXECUTION_TIME(100) */ t1 SET a=20;
ALTER TABLE /*+ MAX_EXECUTION_TIME(100) */ t1 ADD b VARCHAR(200);
ALTER /*+ MAX_EXECUTION_TIME(100) */ TABLE t1 ADD c VARCHAR(200);

SELECT /*+ MAX_EXECUTION_TIME(0) */ * FROM t1;

DROP TABLE t1, t2, t3, t4, t5;
SELECT @@max_execution_time;
SET @@SESSION.max_execution_time= 1000;
SELECT @@max_execution_time;
SET @@SESSION.max_execution_time= 0;

-- timeout value set at statement level.
SELECT /*+ MAX_EXECUTION_TIME(1000) */ SLEEP(5);

-- timeout value set at session level.
SET @@SESSION.max_execution_time= 1000;
SELECT SLEEP(5);
SET @@SESSION.max_execution_time= 0;

-- Create table t1 for testing.
CREATE TABLE t1 (a INT, b VARCHAR(300));

-- Populate table.
INSERT INTO t1 VALUES (1, 'string');
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;

-- Set Session max_execution_time to 2 millisecond
SET @@SESSION.max_execution_time= 2;

-- Case 4.1: Following select should timeout
--error ER_QUERY_TIMEOUT
SELECT *, SLEEP(0.5) from t1;

-- Case 4.2: MDL lock request wait is interrupted on timeout.
connect(con1, localhost, root,,);
SELECT * FROM t1;

-- Following select should timeout
--error ER_QUERY_TIMEOUT
SELECT /*+ MAX_EXECUTION_TIME(1) */ * FROM t1;

-- Case 4.3: max_execution_time is not applicable to DDL statement.
CREATE TABLE t2 SELECT * FROM t1;
ALTER TABLE t2 ADD c VARCHAR(200) default 'new_col';

-- Case 4.4: max_execution_time is not applicable to UPDATE statement.
UPDATE t1 SET b= 'new_string';

-- Case 4.5: max_execution_time is not applicable to INSERT statement.
INSERT INTO t1 SELECT * FROM t1;

-- Case 4.6: max_execution_time is not applicable to DELETE statement.
DELETE FROM t2;

-- Timeout is not applicable to subqueries.
SELECT /*+ MAX_EXECUTION_TIME(3600000) */ (SELECT SLEEP(0.5)) AS true_if_subquery_is_timedout;

-- Following EXECUTE stmt1 should timeout.
--error ER_QUERY_TIMEOUT
EXECUTE stmt1;

-- Following EXECUTE stmt2 should timeout.
--error ER_QUERY_TIMEOUT
EXECUTE stmt2;

-- Following EXECUTE stmt2 should not timeout.
EXECUTE stmt3;
--           Execution time limit applies to only top-level select statement.
--
DELIMITER |;

-- Specifying MAX_EXECUTION_TIME for SELECTs of stored function is ignored.
CREATE FUNCTION f1() RETURNS INT
BEGIN
  SELECT /*+ MAX_EXECUTION_TIME(1) */ SLEEP(1.5) INTO @a;
DROP FUNCTION f1|

CREATE FUNCTION f1() RETURNS INT
BEGIN
  SELECT SLEEP(3) INTO @a;

CREATE FUNCTION f2() RETURNS INT
BEGIN
  INSERT INTO t2 SELECT * FROM t2;

INSERT INTO t2 VALUES (1, 'string1', 'string2');

-- Set Session max_execution_time to 2 millisecond
SET @@SESSION.max_execution_time= 2;
SELECT f1();

-- Following SELECT should not time out as it is not a read only query.  Note,
-- for desabling timer is generated for this query.
SELECT /*+ MAX_EXECUTION_TIME(60000) */ f2();

DROP FUNCTION f1;
DROP FUNCTION f2;

-- Case 7.2: Stored Procedure.
--           Execution time limit is not applicable to Stored procedure.
DELIMITER |;

-- Specifying MAX_EXECUTION_TIME for SELECTs of stored procedure is ignored.
CREATE PROCEDURE p1()
BEGIN
  SELECT /*+ MAX_EXECUTION_TIME(1) */ SLEEP(1.5);
  INSERT INTO t2 SELECT DISTINCT * FROM t2;
DROP PROCEDURE p1|

CREATE PROCEDURE p1()
BEGIN
  INSERT INTO t2 SELECT DISTINCT * FROM t2;
  SELECT SLEEP(3);

-- max_execution_time is not applicable to Stored procedure.
CALL p1();

DROP PROCEDURE p1;
DROP TABLE t2;

-- Case 7.3: Events.
--           Execution time limit is not applicable to SELECTs of events.
SET @global_event_scheduler_status= @@global.event_scheduler;
SET @@global.event_scheduler= ON;
SET @@global.max_execution_time= 1000;
CREATE TABLE t2 (f1 int, f2 int);

-- Both of the following selects are interrupted because of timeout.
SELECT SLEEP(5) into @a;
SELECT @a;

-- Specifying MAX_EXECUTION_TIME for SELECTs of events is ignored.
CREATE EVENT event1 ON SCHEDULE AT CURRENT_TIMESTAMP
DO BEGIN
  SELECT SLEEP(2) into @a;
  SELECT /*+ MAX_EXECUTION_TIME(1) */ SLEEP(2) into @b;
  INSERT INTO t2 VALUES(@a, @b);
let $wait_condition= SELECT /*+ MAX_EXECUTION_TIME(3600000) */ COUNT(*) FROM t2;
SELECT /*+ MAX_EXECUTION_TIME(3600000) */ * FROM t2;

DELETE FROM t2;
SET @@global.event_scheduler= @global_event_scheduler_status;
SET @@global.max_execution_time= 0;

-- Case 7.4: Triggers
--           Execution time limit is not applicable to SELECTs of triggers.
delimiter |;

CREATE TABLE t3 (f1 int)|

-- Specifying MAX_EXECUTION_TIME for SELECTs of events is ignored.
CREATE TRIGGER t1_before_trigger BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  SELECT SLEEP(2) into @a;
  SELECT /*+ MAX_EXECUTION_TIME(1) */ SLEEP(2) into @b;
  INSERT INTO t3 VALUES(@a);
  INSERT INTO t3 VALUES(@b);
DROP TRIGGER t1_before_trigger|

CREATE TRIGGER t1_before_trigger BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  SELECT SLEEP(2) into @a;
  INSERT INTO t3 VALUES(@a);
END
|

delimiter ;

-- Both of the following selects are interrupted because of timeout.
SELECT SLEEP(5) into @a;
SELECT /*+ MAX_EXECUTION_TIME(1000) */ SLEEP(2) into @b;
SELECT @a, @b;

INSERT INTO t1 VALUES (1, 'string');
SELECT /*+ MAX_EXECUTION_TIME(3600000) */ * FROM t3;

DROP TABLE t1,t2,t3;

-- Session MAX_EXECUTION_TIME is used when statament level MAX_EXECUTION_TIME 
-- value is not set.
SET @@SESSION.max_execution_time= 1000;
SELECT sleep(5);

-- Statement level MAX_EXECUTION_TIME takes precedence over session level
-- MAX_EXECUTION_TIME.
SELECT /*+ MAX_EXECUTION_TIME(20000) */ sleep(5);

SET @@SESSION.max_execution_time= 0;

-- Case 9.1 Check MAX_EXECUTION_TIME_SET and MAX_EXECUTION_TIME_EXCEEDED status.
--disable_warnings
SELECT CONVERT(VARIABLE_VALUE, UNSIGNED) INTO @time_set
  FROM performance_schema.global_status
  WHERE VARIABLE_NAME= 'MAX_EXECUTION_TIME_SET';

SELECT CONVERT(VARIABLE_VALUE, UNSIGNED) INTO @time_exceeded
  FROM performance_schema.global_status
  WHERE VARIABLE_NAME= 'MAX_EXECUTION_TIME_EXCEEDED';

SELECT /*+ MAX_EXECUTION_TIME(10) */ SLEEP(1);
SELECT 1 AS STATUS FROM performance_schema.global_status
  WHERE VARIABLE_NAME= 'MAX_EXECUTION_TIME_SET'
        AND CONVERT(VARIABLE_VALUE, UNSIGNED) > @time_set;

SELECT 1 AS STATUS FROM performance_schema.global_status
  WHERE VARIABLE_NAME= 'MAX_EXECUTION_TIME_EXCEEDED'
        AND CONVERT(VARIABLE_VALUE, UNSIGNED) > @time_exceeded;

-- Case 9.2 Check MAX_EXECUTION_TIME_FAILED status on timer creation failure.
connect(con1, localhost, root,,);
SELECT CONVERT(VARIABLE_VALUE, UNSIGNED) INTO @time_set_failed
  FROM performance_schema.global_status
  WHERE VARIABLE_NAME= 'MAX_EXECUTION_TIME_SET_FAILED';

SET DEBUG= '+d,thd_timer_create_failure';
SELECT /*+ MAX_EXECUTION_TIME(10) */ SLEEP(1);
SET DEBUG= '-d,thd_timer_create_failure';
SELECT 1 AS STATUS FROM performance_schema.global_status
  WHERE VARIABLE_NAME= 'MAX_EXECUTION_TIME_SET_FAILED'
        AND CONVERT(VARIABLE_VALUE, UNSIGNED) > @time_set_failed;

-- Case 9.3 Check MAX_EXECUTION_TIME_FAILED status on timer set failure.
SELECT CONVERT(VARIABLE_VALUE, UNSIGNED) INTO @time_set_failed
  FROM performance_schema.global_status
  WHERE VARIABLE_NAME= 'MAX_EXECUTION_TIME_SET_FAILED';

SET DEBUG= '+d,thd_timer_set_failure';
SELECT /*+ MAX_EXECUTION_TIME(10) */ SLEEP(1);
SET DEBUG= '-d,thd_timer_set_failure';

SELECT 1 AS STATUS FROM performance_schema.global_status
  WHERE VARIABLE_NAME= 'MAX_EXECUTION_TIME_SET_FAILED'
        AND CONVERT(VARIABLE_VALUE, UNSIGNED) > @time_set_failed;

SET @@SESSION.max_execution_time= 0;
