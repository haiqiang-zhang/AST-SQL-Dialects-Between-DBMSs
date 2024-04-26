--    this sensitivity by the parameter below.  Small values will result
--    in fast but more unstable execution, large values will improve
--    stability at the cost of speed.  Basically, N is a number of seconds
--    to wait for operation to complete.  Should be positive.  Test runs
--    about 25*N seconds (it sleeps most of the time, so CPU speed is not
--    relevant).
let $N = 5;
--    - create a new time zone
--    - run some statements
--    - delete the new time zone.
--    But the time zone name used gets somewhere cached and it cannot be
--    "reused" later in the same or another session for a new time zone.
--    Experiments (2008-11 MySQL 5.1) showed that none of the available
--    RESET/FLUSH commands removes these entries.
--    2008-11 MySQL 5.1 Bug#39979 main.events_time_zone does not clean up
--                      second bad effect
--    Therefore we compute unique and unusual timezone names to minimize
--    the likelihood that a later test uses the same name.
--
-- 3. The subtests mentioned in 2. cause that the AUTO_INCREMENT value
--    within "SHOW CREATE TABLE mysql.timezone" differ from the initial one.
--    (Bug#39979 main.events_time_zone does not clean up)
--    Therefore we reset this value after each of these subtests.
--
-- Note(mleich):
--    There is a significant likelihood that future improvements of the server
--    cause that the solutions for the issues mentioned in 2. and 3. will no
--    more work.
--    A mysql-test-run.pl feature which allows to enforce
--    1. Server shutdown (-> Problem mentioned in 2. disappears)
--    2. Reset all data to initial state (-> Problem mentioned in 3. disappears)
--    3. Server start
--    after a tests would be a perfect replacement.
--

--source include/big_test.inc
--source include/not_valgrind.inc

--disable_warnings
DROP DATABASE IF EXISTS mysqltest_db1;

CREATE DATABASE mysqltest_db1;

let $old_db= `SELECT DATABASE()`;
USE mysqltest_db1;

SET GLOBAL EVENT_SCHEDULER= OFF;
SET @save_time_zone= @@TIME_ZONE;


--
-- BUG#16420: Events: timestamps become UTC
-- BUG#26429: SHOW CREATE EVENT is incorrect for an event that
--            STARTS NOW()
-- BUG#26431: Impossible to re-create an event from backup if its
--            STARTS clause is in the past
-- WL#3698: Events: execution in local time zone
--

------------------------------------------------------------------------

-- Create rounding function.

-- Disable query log to hide actual value of $N.
--disable_query_log
eval SET @step= $N;

-- Since we are working in a separate database, we may use any names we
-- like.
CREATE TABLE t_step (step INT);
INSERT INTO t_step VALUES (@step);

-- We can't use @variables in function, because it will be called from
-- the event thread, and 'eval' doesn't work for multi-statements, so
-- we can't interpolate $variables either, hence we fetch the step
-- value from the table.
delimiter //;
CREATE FUNCTION round_to_step(i INT, n INT) RETURNS INT
BEGIN
  DECLARE step INT;

  SELECT * INTO step FROM t_step;

  -- We add 0.1 as a protection from inexact division.
  RETURN FLOOR((i % (step * n) + 0.1) / step);


-- Test time computations wrt Daylight Saving Time shifts.  We also
-- test here that the event operates in its time zone (see what NOW()
-- returns).
--

-- Create a fake time zone with time transitions every 3*$N second.

SET @step3= @step * 3;
SET @step6= @step * 6;

SET @unix_time= UNIX_TIMESTAMP() - 1;
SET @unix_time= @unix_time - @unix_time % @step6;

INSERT INTO mysql.time_zone VALUES (NULL, 'N');
SET @tzid= LAST_INSERT_ID();
INSERT INTO mysql.time_zone_transition_type
  VALUES (@tzid, 0, 0, 0, 'b16420_0');
INSERT INTO mysql.time_zone_transition_type
  VALUES (@tzid, 1, @step3 - @step, 1, 'b16420_1');

let $transition_unix_time= `SELECT @unix_time`;
let $count= 30;
{
  eval INSERT INTO mysql.time_zone_transition
         VALUES (@tzid, $transition_unix_time,
                 $transition_unix_time % @step6 = 0);
  let $transition_unix_time= `SELECT $transition_unix_time + @step3`;
  dec $count;
let $tz_name = `SELECT CONCAT('b16420_a',UNIX_TIMESTAMP())`;

CREATE TABLE t1 (count INT, unix_time INT, local_time INT, comment CHAR(80));
CREATE TABLE t2 (count INT);
INSERT INTO t2 VALUES (1);
CREATE FUNCTION f1(comment CHAR(80)) RETURNS INT
BEGIN
  DECLARE orig_tz CHAR(64);

  SET unix_time= UNIX_TIMESTAMP();
  SET local_now= FROM_UNIXTIME(unix_time);
  SET orig_tz= @@TIME_ZONE;
  SET TIME_ZONE = '+00:00';
  SET utc_now= FROM_UNIXTIME(unix_time);
  SET TIME_ZONE= orig_tz;
  SET local_time = unix_time + TIMESTAMPDIFF(SECOND, utc_now, local_now);

  SET unix_time= round_to_step(unix_time, 6);
  SET local_time= round_to_step(local_time, 6);

  INSERT INTO t1 VALUES ((SELECT count FROM t2),
                         unix_time, local_time, comment);

SET TIME_ZONE= '+00:00';
CREATE EVENT e1 ON SCHEDULE EVERY @step SECOND
  STARTS FROM_UNIXTIME(@unix_time) DO SELECT f1("<e1>");
CREATE EVENT e2 ON SCHEDULE EVERY @step SECOND
  STARTS FROM_UNIXTIME(@unix_time) DO SELECT f1("<e2>");

-- We want to start at the beginning of the DST cycle, so we wait
-- untill current time divides by @step6.
let $wait_timeout= `SELECT @step6 + 1`;
let $wait_condition= SELECT UNIX_TIMESTAMP() % @step6 = @step6 - 1;
let $wait_timeout= `SELECT @step + 1`;
let $wait_condition= SELECT UNIX_TIMESTAMP() % @step6 = 0;

-- Note that after the scheduler is enabled, the event will be
-- scheduled only for the next second.
SET GLOBAL EVENT_SCHEDULER= ON;

-- We want to run after the events are executed.
SELECT SLEEP(@step / 2);

let $count= 7;
{
  SELECT SLEEP(@step);
       WHEN 5 THEN f1(CONCAT("Second pass after backward -2 step shift,",
                             " e2 should not be executed"))
       WHEN 4 THEN f1(CONCAT("Second pass after backward -2 step shift,",
                             " e2 should not be executed"))
       WHEN 2 THEN f1(CONCAT("Forward +2 step shift, local 0, 1 are skipped,",
                             " e2 should be executed"))
       ELSE f1("e2 should be executed")
       END;
  UPDATE t2 SET count= count + 1;

  dec $count;

SET GLOBAL EVENT_SCHEDULER= OFF;

SELECT * FROM t1 ORDER BY count, comment;

SET TIME_ZONE= @save_time_zone;

DROP EVENT e2;
DROP EVENT e1;
DROP FUNCTION f1;
DROP TABLE t1, t2;

DELETE FROM mysql.time_zone_name            WHERE time_zone_id = @tzid;
DELETE FROM mysql.time_zone_transition_type WHERE time_zone_id = @tzid;
DELETE FROM mysql.time_zone_transition      WHERE time_zone_id = @tzid;
DELETE FROM mysql.time_zone                 WHERE time_zone_id = @tzid;
let $time_zone_auto_inc = `SELECT MAX(Time_zone_id) + 1 FROM mysql.time_zone`;

-- Test MONTH interval.
--

SET TIME_ZONE= '+00:00';

CREATE TABLE t1 (event CHAR(2), dt DATE, offset INT);

INSERT INTO mysql.time_zone VALUES (NULL, 'N');
SET @tzid= LAST_INSERT_ID();

SET @now= UNIX_TIMESTAMP();
SET @offset_month_01= UNIX_TIMESTAMP('2030-01-31 12:00:00') - @now;
SET @offset_month_02= UNIX_TIMESTAMP('2030-02-28 12:00:00') - @now - 5*@step;
SET @offset_month_03= UNIX_TIMESTAMP('2030-03-31 12:00:00') - @now - 5*@step;
SET @offset_month_04= UNIX_TIMESTAMP('2030-04-30 12:00:00') - @now - 13*@step;

INSERT INTO mysql.time_zone_transition_type
  VALUES (@tzid, 0, @offset_month_01, 0, 'b16420_0');
INSERT INTO mysql.time_zone_transition_type
  VALUES (@tzid, 1, @offset_month_02, 1, 'b16420_1');
INSERT INTO mysql.time_zone_transition_type
  VALUES (@tzid, 2, @offset_month_03, 1, 'b16420_2');
INSERT INTO mysql.time_zone_transition_type
  VALUES (@tzid, 3, @offset_month_04, 1, 'b16420_3');
INSERT INTO mysql.time_zone_transition
  VALUES (@tzid, @now, 0);
INSERT INTO mysql.time_zone_transition
  VALUES (@tzid, @now + 3 * @step, 1);
INSERT INTO mysql.time_zone_transition
  VALUES (@tzid, @now + 7 * @step, 2);
INSERT INTO mysql.time_zone_transition
  VALUES (@tzid, @now + 12 * @step, 3);
let $tz_name = `SELECT CONCAT('b16420_b',UNIX_TIMESTAMP())`;

SET GLOBAL EVENT_SCHEDULER= ON;

let $now= `SELECT @now`;
       STARTS FROM_UNIXTIME($now - @step) DO
         INSERT INTO t1 VALUES
           ("e1", NOW(), round_to_step(UNIX_TIMESTAMP() - $now, 4) - 1);
       STARTS FROM_UNIXTIME($now + @step) DO
         INSERT INTO t1 VALUES
           ("e2", NOW(), round_to_step(UNIX_TIMESTAMP() - $now, 4) - 1);

let $wait_timeout= `SELECT 16 * @step`;
let $wait_condition= SELECT COUNT(*) = 7 FROM t1;

SET GLOBAL EVENT_SCHEDULER= OFF;
SELECT * FROM t1 ORDER BY dt, event;

DROP EVENT e2;
DROP EVENT e1;
DROP TABLE t1;

SET TIME_ZONE= @save_time_zone;

DELETE FROM mysql.time_zone_name            WHERE time_zone_id = @tzid;
DELETE FROM mysql.time_zone_transition_type WHERE time_zone_id = @tzid;
DELETE FROM mysql.time_zone_transition      WHERE time_zone_id = @tzid;
DELETE FROM mysql.time_zone                 WHERE time_zone_id = @tzid;
let $time_zone_auto_inc = `SELECT MAX(Time_zone_id) + 1 FROM mysql.time_zone`;

DROP FUNCTION round_to_step;
DROP TABLE t_step;


DROP DATABASE mysqltest_db1;
let $wait_condition=
  SELECT COUNT(*) = 0 FROM information_schema.processlist
  WHERE db='mysqltest_db1' AND command = 'Connect' AND user=current_user();

-- Set default behavior of event_scheduler
SET GLOBAL EVENT_SCHEDULER= ON;
