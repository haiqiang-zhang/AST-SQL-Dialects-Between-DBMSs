
CREATE DATABASE wl7766;
USE wl7766;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2 (a int);
INSERT INTO t2 VALUES (1), (2);
SET @@session.session_track_schema=ON;
SET @@session.session_track_system_variables='*';
SET @@session.session_track_state_change=ON;
CREATE PROCEDURE t1_sel()
BEGIN
SET @var1=20;
SELECT * FROM t1 ORDER BY 1;
END |
DELIMITER ;
CREATE PROCEDURE t1_inssel()
BEGIN
SET @a=1;
INSERT INTO t1 VALUES (3),(4);
SELECT * FROM t1 ORDER BY 1;
SELECT "session state sent as part of above SELECT" AS col_heading;
END |
DELIMITER ;
CREATE PROCEDURE t1_selins()
BEGIN
SELECT * FROM t1 ORDER BY 1;
INSERT INTO t1 VALUES (5),(6);
SELECT "no session state exists" AS col_heading;
END |
DELIMITER ;
CREATE PROCEDURE t2t1_sel()
BEGIN
SET @a=20;
SELECT MIN(a) FROM t2;
SET @@session.sql_mode='traditional';
SELECT MAX(2) FROM t1;
END |
DELIMITER ;
CREATE PROCEDURE t1_call()
BEGIN
SET @a=20;
SELECT "session state sent for SELECT inside t1_sel()" AS col_heading;
END |
DELIMITER ;
CREATE PROCEDURE t1_inout(
  IN v0 INT,
  OUT v_str_1 CHAR(32),
  OUT v_dbl_1 DOUBLE(4, 2),
  OUT v_dec_1 DECIMAL(6, 3),
  OUT v_int_1 INT,
  IN v1 INT,
  INOUT v_str_2 CHAR(64),
  INOUT v_dbl_2 DOUBLE(5, 3),
  INOUT v_dec_2 DECIMAL(7, 4),
  INOUT v_int_2 INT)
 BEGIN
  SET v0 = -1;
  SET v1 = -1;
  SET v_str_1 = 'test_1';
  SET v_dbl_1 = 12.34;
  SET v_dec_1 = 567.891;
  SET v_int_1 = 2345;
  SET v_str_2 = 'test_2';
  SET v_dbl_2 = 67.891;
  SET v_dec_2 = 234.6789;
  SET v_int_2 = 6789;
  SET @@session.time_zone='Europe/Moscow';
  SELECT * FROM t1;
  SET @@session.TIMESTAMP=200;
  SELECT * FROM t2;
 END |
DELIMITER ;
SELECT @a,@b,@c,@d,@e,@f,@g,@h,@i,@j;
CREATE FUNCTION f1 () RETURNS int
BEGIN
SET NAMES 'big5';
END |
DELIMITER ;

SELECT f1();
CREATE VIEW v1 AS SELECT f1();
SELECT * FROM v1;
CREATE PROCEDURE sp1(OUT x INT)
BEGIN
SELECT MIN(a) INTO x FROM t1;
END |
CREATE FUNCTION f2() RETURNS int
BEGIN
DECLARE a int;
SET @a=20;
END |
DELIMITER ;

SELECT f2();
CREATE FUNCTION f3() RETURNS int
 BEGIN
   DECLARE a, b int;
   DROP TEMPORARY TABLE IF EXISTS t3;
   CREATE TEMPORARY TABLE t3 (id INT);
   INSERT INTO t3 VALUES (1), (2), (3);
   SET a:= (SELECT COUNT(*) FROM t3);
   SET b:= (SELECT COUNT(*) FROM t3 t3_alias);
 END |
DELIMITER ;

SELECT f3();
CREATE FUNCTION f4() RETURNS int
 BEGIN
   DECLARE x int;
   SET NAMES 'utf8mb3';
   SET @var1=20;
 END |
DELIMITER ;

SELECT f4();
CREATE PROCEDURE cursor1()
BEGIN
  DECLARE v1 int;
  SET @@session.transaction_isolation='READ-COMMITTED';
    FETCH cur1 INTO v1;
    IF done THEN
      LEAVE read_loop;
    END IF;
  END LOOP;
  SELECT v1;
END |
DELIMITER ;
CREATE PROCEDURE cursor2()
BEGIN
  DECLARE x int;
  SET @@session.transaction_isolation='READ-COMMITTED';
  SELECT (x+y);
  SELECT "session state sent as part of above SELECT" AS col_heading;
END |
DELIMITER ;

DROP DATABASE wl7766;

SET @@session.session_track_state_change=ON;

CREATE DATABASE bug19550875;
USE bug19550875;

CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2);
CREATE PROCEDURE t_cache()
BEGIN
  SET @A= 20;
  SELECT * FROM t1;
  SELECT * FROM t1;
  SELECT * FROM t1;
  SELECT * FROM t1;
END |
DELIMITER ;
CREATE PROCEDURE sel_with_session()
BEGIN
SET @var1=20;
SELECT * FROM t1 ORDER BY 1;
END |

CREATE PROCEDURE sel_with_no_session()
BEGIN
SELECT * FROM t1 ORDER BY 1;
END |
DELIMITER ;
DROP DATABASE bug19550875;
