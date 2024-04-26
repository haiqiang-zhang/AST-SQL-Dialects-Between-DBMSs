
SELECT @@max_heap_table_size INTO @old_max_heap_table_size;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP TABLE no_such_table;
GET DIAGNOSTICS @n = NUMBER;
GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @err_txt = MESSAGE_TEXT;
SELECT @n, @err_no, @err_txt;

-- This will fail on --ps-protocol because that does a {prepare, execute}
-- sequence for each command (rather than preparing earlier). This means
-- that there is a prepare "SELECT @@warning_count" in between the execute
-- of the throwing statement and that of the SELECT @@warning_count. Thus,
-- the prepare will clear the diagnostics before the execute can see them.
-- To prevent hard to find errors due to counter-intuitive semantics, we
-- fail @@warning_count and @@error_count with ER_UNSUPPORTED_PS during
-- prepare!
--disable_ps_protocol

--error ER_BAD_TABLE_ERROR
DROP TABLE no_such_table;
SELECT @@error_count;
SELECT @@error_count;
DROP TABLE no_such_table;
SELECT @@warning_count;
SELECT @@warning_count;

CREATE TABLE IF NOT EXISTS t2 (f1 INT);
CREATE TABLE IF NOT EXISTS t2 (f1 INT);
SELECT @@warning_count;

DROP TABLE t2;
DROP TABLE no_such_table;
GET DIAGNOSTICS;

GET DIAGNOSTICS @n = NUMBER;
GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @err_txt = MESSAGE_TEXT;
SELECT @n, @err_no, @err_txt;
SET GLOBAL wombat = 'pangolin';

-- neutral:
-- - DECLARE CONDITION
-- - DECLARE HANDLER
-- - BEGIN..END

DELIMITER |;

CREATE PROCEDURE p0_proc_with_warning ()
BEGIN
  SELECT CAST('2001-01-01' AS SIGNED INT);

CREATE PROCEDURE p1_declare_handler_preserves ()
BEGIN
  DECLARE CONTINUE HANDLER FOR NOT FOUND
  BEGIN

    /* Nes gadol hayah poh -- first handler should have been called.
       DECLARE another handler. This should NOT clear the DA! */

    DECLARE red CONDITION FOR 1051;
    DECLARE CONTINUE HANDLER FOR red
    BEGIN
      GET DIAGNOSTICS @n0 = NUMBER;
      GET DIAGNOSTICS CONDITION 1 @e0 = MYSQL_ERRNO, @t0 = MESSAGE_TEXT;
    END;

    /* The important bit here is that there are two diagnostics statements
       in a row, so we can show that the first one does not clear the
       diagnostics area. */

    GET DIAGNOSTICS @n1 = NUMBER;
    GET DIAGNOSTICS CONDITION 1 @e1 = MYSQL_ERRNO, @t1 = MESSAGE_TEXT;

  SET @n1 = 0, @e1 = 0, @t1 = 'handler was not run or GET DIAGNOSTICS failed';

  /* Show handler was called, and DA was read intact despite of other
     DECLAREs on the way: */

  SELECT @n1, @e1, @t1;



CREATE PROCEDURE p2_declare_variable_clears ()
BEGIN
  DECLARE CONTINUE HANDLER FOR NOT FOUND
  BEGIN

    /* DECLARE a variable. This will clear the diagnostics area, so
       the subsequent GET DIAGNOSTICS will fail. It in turn will flag
       a warning (not an exception), which will remain unseen, as it
       in turn gets cleared by the next statement (SELECT). */

    DECLARE v1 INT;

    GET DIAGNOSTICS @n2 = NUMBER;
    GET DIAGNOSTICS CONDITION 1 @e2 = MYSQL_ERRNO, @t2 = MESSAGE_TEXT;

  SET @n2 = 0, @e2 = 0, @t2 = 'handler was not run or GET DIAGNOSTICS failed';

  /* Show handler was called, and DA was NOT read intact because of DECLARE VARIABLE. */

  SELECT @n2, @e2, @t2;



CREATE PROCEDURE p6_bubble_warning ()
BEGIN
  DECLARE CONTINUE HANDLER FOR NOT FOUND
  BEGIN

    /* Absurdly high CONDITION number will cause GET DIAG to fail.
       As it is the last statement, warning should bubble up to caller. */

    GET DIAGNOSTICS CONDITION 99 @e6 = MYSQL_ERRNO, @t6 = MESSAGE_TEXT;

  SET @n2 = 0, @e2 = 0, @t2 = 'handler was not run or GET DIAGNOSTICS failed';



CREATE PROCEDURE p5_declare_variable_clears ()
BEGIN
  DECLARE CONTINUE HANDLER FOR NOT FOUND
  BEGIN

    /* DECLARE a VARIABLE with a broken DEFAULT. This will throw a
       warning at runtime, which GET DIAGNOSTICS will see instead of
       the previous condition (the SIGNAL). */

    DECLARE v1 INT DEFAULT 'meow';

    GET DIAGNOSTICS @n5 = NUMBER;
    GET DIAGNOSTICS CONDITION 1 @e5= MYSQL_ERRNO, @t5 = MESSAGE_TEXT;

  SET @n5 = 0, @e5 = 0, @t5 = 'handler was not run or GET DIAGNOSTICS failed';

  /* Show handler was called, and DA was NOT read intact because of DECLARE VARIABLE. */

  SELECT @n5, @e5, @t5;
  SELECT "still here, we got a warning, not an exception!";



CREATE PROCEDURE p3_non_diagnostics_stmt_clears ()
BEGIN
  DECLARE CONTINUE HANDLER FOR NOT FOUND
  BEGIN

    /* Do some stuff before using GET (CURRENT, not STACKED) DIAGNOSTICS.
       This will clear the DA.
       show that handler was run, even if GET DIAG below fails! */

    SET @t3 = 'handler was run, but GET DIAGNOSTICS failed';
    SELECT 1 FROM DUAL;

    GET CURRENT DIAGNOSTICS @n3 = NUMBER;
    GET CURRENT DIAGNOSTICS CONDITION 1 @e3 = MYSQL_ERRNO, @t3 = MESSAGE_TEXT;

  SET @n3 = 0, @e3 = 0, @t3 = 'handler was not run or GET DIAGNOSTICS failed';

  /* Show handler was called. */

  SELECT @n3, @e3, @t3;



CREATE PROCEDURE p4_unhandled_exception_returned ()
BEGIN

  /* This will throw an exception which we do not handle,
     so execution will abort, and the caller will see
     the error. */

  DROP TABLE no_such_table;
  SELECT "we should never get here";



-- this guards against a regression to MySQL Bug#4902 (see sp.test),
-- a failure to handle MULTI_RESULTS correctly. That's a crashing bug.
CREATE PROCEDURE p7_show_warnings ()
BEGIN
  SHOW VARIABLES LIKE 'foo';
  SELECT "(SHOW WARNINGS does not have to come last)";

CREATE PROCEDURE p8a_empty ()
BEGIN
END|

CREATE PROCEDURE p8b_show_warnings ()
BEGIN
  SHOW WARNINGS;
DROP PROCEDURE p0_proc_with_warning;
DROP PROCEDURE p1_declare_handler_preserves;
DROP PROCEDURE p2_declare_variable_clears;
DROP PROCEDURE p5_declare_variable_clears;
DROP PROCEDURE p6_bubble_warning;
DROP PROCEDURE p3_non_diagnostics_stmt_clears;
DROP PROCEDURE p4_unhandled_exception_returned;
DROP PROCEDURE p7_show_warnings;
DROP TABLE no_such_table;
DROP PROCEDURE p8a_empty;
DROP TABLE no_such_table;
DROP PROCEDURE p8b_show_warnings;
CREATE FUNCTION f2_unseen_warnings() RETURNS INT
BEGIN
  /* throw a warning */
  SET @@max_heap_table_size= 1;
  /* RETURN counts as a statement as per the standard, so clears DA */
  RETURN 1;
CREATE FUNCTION f3_stacking_warnings() RETURNS TEXT
BEGIN
  /* throw a warning */
  RETURN CAST('2001-01-01' AS SIGNED INT);


-- show we didn't break this
DELIMITER |;
CREATE FUNCTION f4_show_warnings() RETURNS TEXT
BEGIN
  SHOW WARNINGS;
SELECT f2_unseen_warnings();
SET @@max_heap_table_size= 1;
DROP FUNCTION f2_unseen_warnings;
SELECT f3_stacking_warnings(),f3_stacking_warnings(),f3_stacking_warnings();
DROP FUNCTION f3_stacking_warnings;
DROP TABLE t1;

CREATE PROCEDURE p10_ps_with_warning ()
BEGIN
  DECLARE CONTINUE HANDLER FOR 1050 SELECT "a warn place";

DROP PROCEDURE p10_ps_with_warning;
DROP TABLE t1;
DROP TABLE t1;
SET @sql1='GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @err_txt = MESSAGE_TEXT';
SET @@max_heap_table_size= 1;
SELECT 1;
SET @@max_heap_table_size= 1;
SELECT 1 FROM (SELECT 1) t1;

CREATE PROCEDURE peter1 ()
BEGIN
  DECLARE v INTEGER DEFAULT 1234;
    SHOW WARNINGS;
    SELECT "handler done: ",v;

  CREATE TABLE gg (smallint_column SMALLINT);

CREATE PROCEDURE peter2 (INOUT v INTEGER)
BEGIN
  INSERT INTO gg (smallint_column) VALUES (32769);
  GET DIAGNOSTICS v = ROW_COUNT;

CREATE PROCEDURE peter3(a DECIMAL(2,2))
BEGIN
   DECLARE b DECIMAL(2,2) DEFAULT @var;

DROP PROCEDURE peter2;
DROP PROCEDURE peter1;
DROP TABLE gg;

SET @var="foo";
DROP PROCEDURE peter3;

CREATE TABLE t3 (id INT NOT NULL)|
  
CREATE PROCEDURE bug15231_1()
BEGIN
  DECLARE xid INTEGER;

  SET xid=NULL;
  SELECT "1,0", xid, xdone;

  SET xid=NULL;
  SELECT "NULL, 1", xid, xdone;

-- This no longer works;
CREATE PROCEDURE bug15231_2a(INOUT ioid INTEGER)
BEGIN
  SELECT "Before NOT FOUND condition is triggered" AS '1';
  SELECT id INTO ioid FROM t3 WHERE id=ioid;
  SELECT "After NOT FOUND condtition is triggered" AS '2';

  IF ioid IS NULL THEN
    SET ioid=1;
  END IF;

-- This works!  The warning is thrown on the last procedure
-- statement (END isn't, and therefore doesn't clear the
-- diagnostics area).  Therefore, the caller sees the warning,
-- and runs the NOT FOUND handler.
CREATE PROCEDURE bug15231_2b(INOUT ioid INTEGER)
BEGIN
  SELECT id INTO ioid FROM t3 WHERE id=ioid;

DROP PROCEDURE bug15231_1|
DROP PROCEDURE bug15231_2a|
DROP PROCEDURE bug15231_2b|

--echo --

CREATE PROCEDURE bug15231_3()
BEGIN
  DECLARE EXIT HANDLER FOR SQLWARNING
    SELECT 'Caught it (correct)' AS 'Result';

CREATE PROCEDURE bug15231_4()
BEGIN
  DECLARE x DECIMAL(2,1);

  SET x = 'zap';

CREATE PROCEDURE bug15231_5()
BEGIN
  DECLARE EXIT HANDLER FOR SQLWARNING
    SELECT 'Caught it (wrong)' AS 'Result';

CREATE PROCEDURE bug15231_6()
BEGIN
  DECLARE x DECIMAL(2,1);

  SET x = 'zap';
  SELECT id FROM t3;

CREATE PROCEDURE bug15231_7()
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    SELECT 'Caught it (right)' AS 'Result';

CREATE PROCEDURE bug15231_8()
BEGIN
  DROP TABLE no_such_table;
  SELECT 'Caught it (wrong)' AS 'Result';

DROP TABLE t3|

DROP PROCEDURE bug15231_3|
DROP PROCEDURE bug15231_4|
DROP PROCEDURE bug15231_5|
DROP PROCEDURE bug15231_6|
DROP PROCEDURE bug15231_7|
DROP PROCEDURE bug15231_8|

DELIMITER ;

SET sql_mode = 'NO_ENGINE_SUBSTITUTION';

SET @@max_heap_table_size= @old_max_heap_table_size;
