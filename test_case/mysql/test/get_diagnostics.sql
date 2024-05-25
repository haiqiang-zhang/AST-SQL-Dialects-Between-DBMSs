DROP PROCEDURE IF EXISTS p1;
CREATE TABLE t1 (`get` INT);
INSERT INTO t1 (`get`) values (1);
SELECT `get` FROM t1 WHERE `get` = 1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;
CREATE TABLE t1 (current INT, diagnostics INT, number INT, returned_sqlstate INT);
INSERT INTO t1 (current, diagnostics, number, returned_sqlstate) values (1,2,3,4);
SELECT current, diagnostics, number, returned_sqlstate FROM t1 WHERE number = 3;
SELECT `current`, `number` FROM t1 WHERE `current` = 1 AND `number` = 3;
DROP TABLE t1;
DROP PROCEDURE IF EXISTS p1;
SELECT CAST(-19999999999999999999 AS SIGNED);
SELECT CAST(-19999999999999999999 AS SIGNED);
SELECT CAST(-19999999999999999999 AS SIGNED),
       CAST(-19999999999999999999 AS SIGNED);
SELECT @var;
SELECT @var;
SELECT 1;
SELECT @var;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
SELECT @var;
DROP TABLE t1;
SELECT CAST(-19999999999999999999 AS SIGNED),
         CAST(-19999999999999999999 AS SIGNED);
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
DROP TABLE t1;
SELECT CAST(-19999999999999999999 AS SIGNED);
SELECT
  @class_origin,
  @subclass_origin,
  @constraint_catalog,
  @constraint_schema,
  @constraint_name,
  @catalog_name,
  @schema_name,
  @table_name,
  @column_name,
  @cursor_name,
  @message_text,
  @mysql_errno,
  @returned_sqlstate;
SELECT CAST(-19999999999999999999 AS SIGNED);
SELECT CAST(-19999999999999999999 AS SIGNED);
SELECT @mysql_errno, @message_text, @returned_sqlstate, @class_origin;
SELECT
  @class_origin,
  @subclass_origin,
  @constraint_catalog,
  @constraint_schema,
  @constraint_name,
  @catalog_name,
  @schema_name,
  @table_name,
  @column_name,
  @cursor_name,
  @message_text,
  @mysql_errno,
  @returned_sqlstate;
CREATE TABLE IF NOT EXISTS t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a REAL, b INT);
INSERT INTO t1 VALUES (1.1, 1);
DROP TABLE t1;
SELECT @x, @y;
SELECT @var1, @var2;
SELECT @var1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1), (2);
SELECT @var1, @var2;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);
SELECT @var1, @var2;
DROP TABLE t1;
SELECT CAST(-19999999999999999999 AS SIGNED);
SELECT CHARSET(@var1), COLLATION(@var1), COERCIBILITY(@var1);
SELECT CHARSET(@var2), COLLATION(@var2), COERCIBILITY(@var2);
CREATE TABLE t1 (stacked INT);
INSERT INTO t1 (stacked) values (1);
SELECT stacked FROM t1 WHERE stacked = 1;
SELECT `stacked` FROM t1 WHERE `stacked` = 1;
DROP TABLE t1;
CREATE PROCEDURE p1() GET STACKED DIAGNOSTICS @var1 = NUMBER;
DROP PROCEDURE p1;
CREATE TABLE t1(a INT);
SELECT @msg1, @errno1;
SELECT @msg2, @errno2;
SELECT * FROM t1;
SELECT @cno;
SELECT @msg4, @errno4;
DROP TABLE t1;
SELECT @msg1, @errno1;
SELECT @msg2, @errno2;
SELECT @msg3, @errno3;
SELECT @msg4, @errno4;
SELECT 10 + 'a';
