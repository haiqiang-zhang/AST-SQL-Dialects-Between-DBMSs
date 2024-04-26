
-- Drop stored routines (if any) for general SP-vars test cases. These routines
-- are created in include/sp-vars.inc file.

DROP PROCEDURE IF EXISTS sp_vars_check_dflt;
DROP PROCEDURE IF EXISTS sp_vars_check_assignment;
DROP FUNCTION IF EXISTS sp_vars_check_ret1;
DROP FUNCTION IF EXISTS sp_vars_check_ret2;
DROP FUNCTION IF EXISTS sp_vars_check_ret3;
DROP FUNCTION IF EXISTS sp_vars_check_ret4;
DROP FUNCTION IF EXISTS sp_vars_div_zero;

-- Create the procedure in ANSI mode. Check that all necessary warnings are
-- emitted properly.

SET @@sql_mode = 'ansi';

SELECT sp_vars_check_ret1();

SELECT sp_vars_check_ret2();

SELECT sp_vars_check_ret3();

SELECT sp_vars_check_ret4();

SELECT sp_vars_div_zero();

-- Check that changing sql_mode after creating a store procedure does not
-- matter.

SET @@sql_mode = 'traditional';

SELECT sp_vars_check_ret1();

SELECT sp_vars_check_ret2();

SELECT sp_vars_check_ret3();

SELECT sp_vars_check_ret4();

SELECT sp_vars_div_zero();

-- Create the procedure in TRADITIONAL mode. Check that error will be thrown on
-- execution.

DROP PROCEDURE sp_vars_check_dflt;
DROP PROCEDURE sp_vars_check_assignment;
DROP FUNCTION sp_vars_check_ret1;
DROP FUNCTION sp_vars_check_ret2;
DROP FUNCTION sp_vars_check_ret3;
DROP FUNCTION sp_vars_check_ret4;
DROP FUNCTION sp_vars_div_zero;
SELECT sp_vars_check_ret1();
SELECT sp_vars_check_ret2();
SELECT sp_vars_check_ret3();

SELECT sp_vars_check_ret4();
SELECT sp_vars_div_zero();

SET @@sql_mode = 'ansi';

--
-- Cleanup.
--

DROP PROCEDURE sp_vars_check_dflt;
DROP PROCEDURE sp_vars_check_assignment;
DROP FUNCTION sp_vars_check_ret1;
DROP FUNCTION sp_vars_check_ret2;
DROP FUNCTION sp_vars_check_ret3;
DROP FUNCTION sp_vars_check_ret4;
DROP FUNCTION sp_vars_div_zero;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;

--
-- Test case.
--

delimiter |;
CREATE PROCEDURE p1()
BEGIN
  DECLARE v1 BIT;

  SET v1 = v4;
  SET v2 = 0;
  SET v5 = v4;
  SET v6 = v3;

  SELECT HEX(v1);
  SELECT HEX(v2);
  SELECT HEX(v3);
  SELECT HEX(v4);
  SELECT HEX(v5);
  SELECT HEX(v6);
  SELECT HEX(v7);
  SELECT HEX(v8);
  SELECT HEX(v9);
  SELECT HEX(v10);

--
-- Cleanup.
--

DROP PROCEDURE p1;
--   - test for general functionality (scopes, nested cases, CASE in loops);
--   - test that if type of the CASE expression is changed on each iteration,
--     the execution will be correct.
--
--##########################################################################

--echo
--echo ---------------------------------------------------------------
--echo CASE expression tests.
--echo ---------------------------------------------------------------
--echo

--
-- Prepare.
--

DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP TABLE IF EXISTS t1;

--
-- Test case.
--

CREATE TABLE t1(log_msg VARCHAR(1024));

CREATE PROCEDURE p1(arg VARCHAR(255))
BEGIN
  INSERT INTO t1 VALUES('p1: step1');
    WHEN 10 * 10 THEN
      INSERT INTO t1 VALUES('p1: case1: on 10');
    WHEN 10 * 10 + 10 * 10 THEN
      BEGIN
        CASE arg / 10
          WHEN 1 THEN
            INSERT INTO t1 VALUES('p1: case1: case2: on 1');
          WHEN 2 THEN
            BEGIN
              DECLARE i TINYINT DEFAULT 10;

              WHILE i > 0 DO
                INSERT INTO t1 VALUES(CONCAT('p1: case1: case2: loop: i: ', i));
                
                CASE MOD(i, 2)
                  WHEN 0 THEN
                    INSERT INTO t1 VALUES('p1: case1: case2: loop: i is even');
                  WHEN 1 THEN
                    INSERT INTO t1 VALUES('p1: case1: case2: loop: i is odd');
                  ELSE
                    INSERT INTO t1 VALUES('p1: case1: case2: loop: ERROR');
                END CASE;
                    
                SET i = i - 1;
              END WHILE;
            END;
          ELSE
            INSERT INTO t1 VALUES('p1: case1: case2: ERROR');
        END CASE;

        CASE arg
          WHEN 10 THEN
            INSERT INTO t1 VALUES('p1: case1: case3: on 10');
          WHEN 20 THEN
            INSERT INTO t1 VALUES('p1: case1: case3: on 20');
          ELSE
            INSERT INTO t1 VALUES('p1: case1: case3: ERROR');
        END CASE;
      END;
    ELSE
      INSERT INTO t1 VALUES('p1: case1: ERROR');
  END CASE;
    WHEN 10 * 10 THEN
      INSERT INTO t1 VALUES('p1: case4: on 10');
    WHEN 10 * 10 + 10 * 10 THEN
      BEGIN
        CASE arg / 10
          WHEN 1 THEN
            INSERT INTO t1 VALUES('p1: case4: case5: on 1');
          WHEN 2 THEN
            BEGIN
              DECLARE i TINYINT DEFAULT 10;

              WHILE i > 0 DO
                INSERT INTO t1 VALUES(CONCAT('p1: case4: case5: loop: i: ', i));
                
                CASE MOD(i, 2)
                  WHEN 0 THEN
                    INSERT INTO t1 VALUES('p1: case4: case5: loop: i is even');
                  WHEN 1 THEN
                    INSERT INTO t1 VALUES('p1: case4: case5: loop: i is odd');
                  ELSE
                    INSERT INTO t1 VALUES('p1: case4: case5: loop: ERROR');
                END CASE;
                    
                SET i = i - 1;
              END WHILE;
            END;
          ELSE
            INSERT INTO t1 VALUES('p1: case4: case5: ERROR');
        END CASE;

        CASE arg
          WHEN 10 THEN
            INSERT INTO t1 VALUES('p1: case4: case6: on 10');
          WHEN 20 THEN
            INSERT INTO t1 VALUES('p1: case4: case6: on 20');
          ELSE
            INSERT INTO t1 VALUES('p1: case4: case6: ERROR');
        END CASE;
      END;
    ELSE
      INSERT INTO t1 VALUES('p1: case4: ERROR');
  END CASE;

CREATE PROCEDURE p2()
BEGIN
  DECLARE i TINYINT DEFAULT 3;
    IF MOD(i, 2) = 0 THEN
      SET @_test_session_var = 10;
    ELSE
      SET @_test_session_var = 'test';
    END IF;

    CASE @_test_session_var
      WHEN 10 THEN
        INSERT INTO t1 VALUES('p2: case: numerical type');
      WHEN 'test' THEN
        INSERT INTO t1 VALUES('p2: case: string type');
      ELSE
        INSERT INTO t1 VALUES('p2: case: ERROR');
    END CASE;

    SET i = i - 1;
  END WHILE;

SELECT * FROM t1;

--
-- Cleanup.
--

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP TABLE t1;

--
-- Prepare.
--

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;

--
-- Test case.
--

CREATE TABLE t1(col BIGINT UNSIGNED);

INSERT INTO t1 VALUE(18446744073709551614);
CREATE PROCEDURE p1(IN arg BIGINT UNSIGNED)
BEGIN
  SELECT arg;
  SELECT * FROM t1;
  SELECT * FROM t1 WHERE col = arg;

--
-- Cleanup.
--

DROP TABLE t1;
DROP PROCEDURE p1;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;

--
-- Test case.
--

delimiter |;
CREATE PROCEDURE p1(x VARCHAR(10), y CHAR(3)) READS SQL DATA
BEGIN
  SELECT x, y;

--
-- Cleanup.
--

DROP PROCEDURE p1;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP TABLE IF EXISTS t1;

--
-- Test case.
--

delimiter |;
CREATE PROCEDURE p1(x DATETIME)
BEGIN
  CREATE TABLE t1 SELECT x;
  DROP TABLE t1;

--
-- Cleanup.
--

DROP PROCEDURE p1;

--
-- Prepare.
--

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;

--
-- Test case.
--

CREATE TABLE t1(b BIT(1));

INSERT INTO t1(b) VALUES(b'0'), (b'1');
CREATE PROCEDURE p1()
BEGIN
  SELECT HEX(b),
    b = 0,
    b = FALSE,
    b IS FALSE,
    b = 1,
    b = TRUE,
    b IS TRUE
  FROM t1;

CREATE PROCEDURE p2()
BEGIN
  DECLARE vb BIT(1);
  SELECT b INTO vb FROM t1 WHERE b = 0;

  SELECT HEX(vb),
    vb = 0,
    vb = FALSE,
    vb IS FALSE,
    vb = 1,
    vb = TRUE,
    vb IS TRUE;

  SELECT b INTO vb FROM t1 WHERE b = 1;

  SELECT HEX(vb),
    vb = 0,
    vb = FALSE,
    vb IS FALSE,
    vb = 1,
    vb = TRUE,
    vb IS TRUE;

--
-- Cleanup.
--

DROP TABLE t1;
DROP PROCEDURE p1;
DROP PROCEDURE p2;

-- Additional tests for Bug#12976

--disable_warnings
DROP TABLE IF EXISTS table_12976_a;
DROP TABLE IF EXISTS table_12976_b;
DROP PROCEDURE IF EXISTS proc_12976_a;
DROP PROCEDURE IF EXISTS proc_12976_b;

CREATE TABLE table_12976_a (val bit(1));

CREATE TABLE table_12976_b(
  appname varchar(15),
  emailperm bit not null default 1,
  phoneperm bit not null default 0);

insert into table_12976_b values ('A', b'1', b'1'), ('B', b'0', b'0');
CREATE PROCEDURE proc_12976_a()
BEGIN
  declare localvar bit(1);
  SELECT val INTO localvar FROM table_12976_a;
  SELECT coalesce(localvar, 1)+1, coalesce(val, 1)+1 FROM table_12976_a;

CREATE PROCEDURE proc_12976_b(
  name varchar(15),
  out ep bit,
  out msg varchar(10))
BEGIN
  SELECT emailperm into ep FROM table_12976_b where (appname = name);
  IF ep is true THEN
    SET msg = 'True';
    SET msg = 'False';
  END IF;

INSERT table_12976_a VALUES (0);
UPDATE table_12976_a set val=1;
select @ep, @msg;
select @ep, @msg;

DROP TABLE table_12976_a;
DROP TABLE table_12976_b;
DROP PROCEDURE proc_12976_a;
DROP PROCEDURE proc_12976_b;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP PROCEDURE IF EXISTS p3;

DROP PROCEDURE IF EXISTS p4;
DROP PROCEDURE IF EXISTS p5;
DROP PROCEDURE IF EXISTS p6;

--
-- Test case.
--

SET @@sql_mode = 'traditional';

CREATE PROCEDURE p1()
BEGIN
  DECLARE v TINYINT DEFAULT 1e200;
  SELECT v;

CREATE PROCEDURE p2()
BEGIN
  DECLARE v DECIMAL(5) DEFAULT 1e200;
  SELECT v;

CREATE PROCEDURE p3()
BEGIN
  DECLARE v CHAR(5) DEFAULT 'abcdef';
  SELECT v LIKE 'abc___';

CREATE PROCEDURE p4(arg VARCHAR(2))
BEGIN
    DECLARE var VARCHAR(1);
    SET var := arg;
    SELECT arg, var;

CREATE PROCEDURE p5(arg CHAR(2))
BEGIN
    DECLARE var CHAR(1);
    SET var := arg;
    SELECT arg, var;

CREATE PROCEDURE p6(arg DECIMAL(2))
BEGIN
    DECLARE var DECIMAL(1);
    SET var := arg;
    SELECT arg, var;

--
-- Cleanup.
--

SET @@sql_mode = 'ansi';

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP PROCEDURE p3;

DROP PROCEDURE p4;
DROP PROCEDURE p5;
DROP PROCEDURE p6;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;

--
-- Test case.
--

delimiter |;
CREATE PROCEDURE p1 (arg DECIMAL(64,2))
BEGIN
  DECLARE var DECIMAL(64,2);

  SET var = arg;
  SELECT var;

--
-- Cleanup.
--

DROP PROCEDURE p1;

--
-- Prepare.
--

--disable_warnings
DROP FUNCTION IF EXISTS f1;

--
-- Test case.
--

-- Create a function in ANSI mode.

delimiter |;
CREATE FUNCTION f1(arg TINYINT UNSIGNED) RETURNS TINYINT
BEGIN
  RETURN arg;

SELECT f1(-2500);

-- Call in TRADITIONAL mode the function created in ANSI mode.

SET @@sql_mode = 'traditional';
SELECT f1(-2500);

-- Recreate the function in TRADITIONAL mode.

DROP FUNCTION f1;
CREATE FUNCTION f1(arg TINYINT UNSIGNED) RETURNS TINYINT
BEGIN
  RETURN arg;
SELECT f1(-2500);

--
-- Cleanup.
--

SET @@sql_mode = 'ansi';

DROP FUNCTION f1;

--
-- Prepare.
--

--disable_warnings
DROP FUNCTION IF EXISTS f1;

--
-- Test case.
--

-- Create a function in ANSI mode.

delimiter |;
CREATE FUNCTION f1(arg MEDIUMINT) RETURNS MEDIUMINT
BEGIN
  RETURN arg;

SELECT f1(8388699);

-- Call in TRADITIONAL mode the function created in ANSI mode.

SET @@sql_mode = 'traditional';
SELECT f1(8388699);

-- Recreate the function in TRADITIONAL mode.

DROP FUNCTION f1;
CREATE FUNCTION f1(arg MEDIUMINT) RETURNS MEDIUMINT
BEGIN
  RETURN arg;
SELECT f1(8388699);

--
-- Cleanup.
--

SET @@sql_mode = 'ansi';

DROP FUNCTION f1;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP TABLE IF EXISTS t1;

--
-- Test case.
--

CREATE TABLE t1(col VARCHAR(255));

INSERT INTO t1(col) VALUES('Hello, world!');
CREATE PROCEDURE p1()
BEGIN
  DECLARE sp_var INTEGER;

  SELECT col INTO sp_var FROM t1 LIMIT 1;
  SET @user_var = sp_var;

  SELECT sp_var;
  SELECT @user_var;

--
-- Cleanup.
--

DROP PROCEDURE p1;
DROP TABLE t1;

--
-- Prepare.
--

--disable_warnings
DROP FUNCTION IF EXISTS f1;
DROP TABLE IF EXISTS t1;

--
-- Test case.
--

CREATE TABLE t1(txt VARCHAR(255));
CREATE FUNCTION f1(arg VARCHAR(255)) RETURNS VARCHAR(255)
BEGIN
  DECLARE v1 VARCHAR(255);

  SET v1 = CONCAT(LOWER(arg), UPPER(arg));
  SET v2 = CONCAT(LOWER(v1), UPPER(v1));

  INSERT INTO t1 VALUES(v1), (v2);

SELECT f1('_aBcDe_');

SELECT * FROM t1;

--
-- Cleanup.
--

DROP FUNCTION f1;
DROP TABLE t1;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;
DROP FUNCTION IF EXISTS f1;

--
-- Test case.
--

delimiter |;

CREATE PROCEDURE p1(arg ENUM('a', 'b'))
BEGIN
  SELECT arg;

CREATE PROCEDURE p2(arg ENUM('a', 'b'))
BEGIN
  DECLARE var ENUM('c', 'd') DEFAULT arg;
  SELECT arg, var;

CREATE FUNCTION f1(arg ENUM('a', 'b')) RETURNS ENUM('c', 'd')
BEGIN
  RETURN arg;

SELECT f1('a');

--
-- Cleanup.
--

DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP FUNCTION f1;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;

--
-- Test case.
--

delimiter |;

CREATE PROCEDURE p1(arg VARCHAR(255))
BEGIN
  SELECT CHARSET(arg);

CREATE PROCEDURE p2(arg VARCHAR(255) CHARACTER SET utf8mb3)
BEGIN
    SELECT CHARSET(arg);

--
-- Cleanup.
--

DROP PROCEDURE p1;
DROP PROCEDURE p2;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;

--
-- Test case.
--

delimiter |;
CREATE PROCEDURE p1(arg1 BINARY(2), arg2 VARBINARY(2))
BEGIN
  DECLARE var1 BINARY(2) DEFAULT 0x41;

  SELECT HEX(arg1), HEX(arg2);
  SELECT HEX(var1), HEX(var2);

--
-- Cleanup.
--

DROP PROCEDURE p1;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP TABLE IF EXISTS t1;

--
-- Test case.
--

CREATE TABLE t1(col1 TINYINT, col2 TINYINT);

INSERT INTO t1 VALUES(1, 2), (11, 12);
CREATE PROCEDURE p1(arg TINYINT)
BEGIN
  SELECT arg;

--
-- Cleanup.
--

DROP PROCEDURE p1;
DROP TABLE t1;

--
-- Prepare.
--

--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP FUNCTION IF EXISTS f1;

--
-- Test case.
--

delimiter |;

CREATE PROCEDURE p1(x VARCHAR(50))
BEGIN
  SET x = SUBSTRING(x, 1, 3);
  SELECT x;

CREATE FUNCTION f1(x VARCHAR(50)) RETURNS VARCHAR(50)
BEGIN
  RETURN SUBSTRING(x, 1, 3);

SELECT f1('ABCDEF');

--
-- Cleanup.
--

DROP PROCEDURE p1;
DROP FUNCTION f1;

--
-- Prepare.
--

--disable_warnings
DROP FUNCTION IF EXISTS f1;

--
-- Test case.
--

delimiter |;
CREATE FUNCTION f1() RETURNS VARCHAR(2000)
BEGIN
  DECLARE var VARCHAR(2000);

  SET var = '';
  SET var = CONCAT(var, 'abc');
  SET var = CONCAT(var, '');

SELECT f1();

--
-- Cleanup.
--

DROP FUNCTION f1;


--
-- Bug#17226: Variable set in cursor on first iteration is assigned
-- second iterations value
--
-- The problem was in incorrect handling of local variables of type
-- TEXT (BLOB).
--
--disable_warnings
DROP PROCEDURE IF EXISTS p1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE v_char VARCHAR(255);

  SET v_char = 'abc';

  SET v_text = v_char;

  SET v_char = 'def';

  SET v_text = concat(v_text, '|', v_char);

  SELECT v_text;

DROP PROCEDURE p1;

--
-- Bug #27415 Text Variables in stored procedures
-- If the SP varible was also referenced on the right side
-- the result was corrupted.
--
DELIMITER |;
DROP PROCEDURE IF EXISTS bug27415_text_test|
DROP PROCEDURE IF EXISTS bug27415_text_test2|
--enable_warnings

CREATE PROCEDURE bug27415_text_test(entity_id_str_in text)
BEGIN
    DECLARE str_remainder text;

    SET str_remainder = entity_id_str_in;

    select 'before substr', str_remainder;
    SET str_remainder = SUBSTRING(str_remainder, 3);
    select 'after substr', str_remainder;

CREATE PROCEDURE bug27415_text_test2(entity_id_str_in text)
BEGIN
    DECLARE str_remainder text;
    DECLARE str_remainder2 text;
 
    SET str_remainder2 = entity_id_str_in;
    select 'before substr', str_remainder2;
    SET str_remainder = SUBSTRING(str_remainder2, 3);
    select 'after substr', str_remainder;

DROP PROCEDURE bug27415_text_test|
DROP PROCEDURE bug27415_text_test2|

DELIMITER ;

-- End of 5.0 tests.

--
-- Bug #26277 User variable returns one type in SELECT @v and other for CREATE as SELECT @v
--
--disable_warnings
drop function if exists f1;
drop table if exists t1;
create function f1() returns int 
begin
 if @a=1 then set @b='abc';
 end if;
 set @a=1;

create table t1 (a int)|
insert into t1 (a) values (1), (2)|

set @b=1|
set @a=0|
select f1(), @b from t1|

set @b:='test'|
set @a=0|
select f1(), @b from t1|

delimiter ;

drop function f1;
drop table t1;
CREATE PROCEDURE ctest()
BEGIN
  DECLARE i CHAR(16);
  SET i= 'string';
  SET j= 1 + i;
DROP PROCEDURE ctest;
CREATE PROCEDURE vctest()
BEGIN
  DECLARE i VARCHAR(16);
  SET i= 'string';
  SET j= 1 + i;
DROP PROCEDURE vctest;

CREATE TABLE t (a INT PRIMARY KEY, b TEXT, FULLTEXT(b)) ENGINE=InnoDB;
CREATE FUNCTION f() RETURNS TEXT RETURN @@GLOBAL.innodb_ft_aux_table;
SELECT @@GLOBAL.innodb_ft_aux_table, f();
SET GLOBAL innodb_ft_aux_table="test/t";
SELECT @@GLOBAL.innodb_ft_aux_table, f();
SET GLOBAL innodb_ft_aux_table= default;
DROP FUNCTION f;
DROP TABLE t;
