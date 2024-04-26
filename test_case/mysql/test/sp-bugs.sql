
CREATE SCHEMA testdb;
USE testdb;
CREATE FUNCTION f2 () RETURNS INTEGER
BEGIN
   DECLARE CONTINUE HANDLER FOR SQLSTATE '42000' SET @aux = 1;
CREATE PROCEDURE p3 ( arg1 VARCHAR(32) )
BEGIN
   CALL p_not_exists ( );

DROP SCHEMA testdb;

CREATE SCHEMA testdb;
USE testdb;
CREATE FUNCTION f2 () RETURNS INTEGER
BEGIN
   DECLARE CONTINUE HANDLER FOR SQLSTATE '42000' SET @aux = 1;
CREATE PROCEDURE p3 ( arg2 INTEGER )
BEGIN
   CALL p_not_exists ( );

DROP SCHEMA testdb;

CREATE SCHEMA testdb;
USE testdb;
CREATE FUNCTION f2 () RETURNS INTEGER
BEGIN
   DECLARE CONTINUE HANDLER FOR SQLSTATE '42000' SET @aux = 1;
SELECT f2 ();

DROP SCHEMA testdb;

USE test;
DROP TABLE IF EXISTS t1;
DROP TRIGGER IF EXISTS tr1;
DROP PROCEDURE IF EXISTS p1;

CREATE TABLE t1 (f1 INTEGER);
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW SET @aux = 1;
CREATE PROCEDURE p1 () DROP TRIGGER tr1;

DROP TABLE t1;
DROP PROCEDURE p1;
DROP TABLE IF EXISTS t1;
DROP TRIGGER IF EXISTS tr1;
DROP PROCEDURE IF EXISTS p1;

CREATE TABLE t1 (f1 INTEGER);
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW SET @aux = 1;
CREATE PROCEDURE p1 () DROP TRIGGER tr1;

DROP TABLE t1;
DROP PROCEDURE p1;
SET @@SQL_MODE = 'STRICT_ALL_TABLES';
DROP DATABASE IF EXISTS db1;
CREATE DATABASE db1;
USE db1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (c1 int NOT NULL PRIMARY KEY);
INSERT INTO t1 VALUES (1);
CREATE FUNCTION f1 (
	some_value int
)
RETURNS smallint
DETERMINISTIC
BEGIN
	INSERT INTO t1 SET c1 = some_value;
        RETURN(LAST_INSERT_ID());
DROP DATABASE IF EXISTS db2;
CREATE DATABASE db2;
USE db2;
SELECT DATABASE();
SELECT db1.f1(1);
SELECT DATABASE();
USE test;
DROP FUNCTION db1.f1;
DROP TABLE db1.t1;
DROP DATABASE db1;
DROP DATABASE db2;
DROP DATABASE IF EXISTS testdb;
CREATE DATABASE testdb;
USE testdb;
CREATE TABLE t1 (id1 INT PRIMARY KEY);
CREATE PROCEDURE `p1`()
BEGIN
    CREATE TABLE IF NOT EXISTS t2(id INT PRIMARY KEY,
    CONSTRAINT FK FOREIGN KEY (id) REFERENCES t1( id1 ));
DROP DATABASE testdb;
USE test;

CREATE FUNCTION sf() RETURNS BLOB RETURN "";
SELECT sf();
DROP FUNCTION sf;
SET @@SQL_MODE = '';
CREATE FUNCTION testf_bug11763507() RETURNS INT
BEGIN
    RETURN 0;
END
$

CREATE PROCEDURE testp_bug11763507()
BEGIN
    SELECT "PROCEDURE testp_bug11763507";
END
$

DELIMITER ;

-- STORED FUNCTIONS
SELECT testf_bug11763507();
SELECT TESTF_bug11763507();

-- STORED PROCEDURE
CALL testp_bug11763507();

-- INFORMATION SCHEMA 
SELECT specific_name FROM INFORMATION_SCHEMA.ROUTINES WHERE specific_name LIKE 'testf_bug11763507';
SELECT specific_name FROM INFORMATION_SCHEMA.ROUTINES WHERE specific_name LIKE 'TESTF_bug11763507';

SELECT specific_name FROM INFORMATION_SCHEMA.ROUTINES WHERE specific_name='testf_bug11763507';
SELECT specific_name FROM INFORMATION_SCHEMA.ROUTINES WHERE specific_name='TESTF_bug11763507';

DROP PROCEDURE testp_bug11763507;
DROP FUNCTION testf_bug11763507;

SET sql_mode='NO_ENGINE_SUBSTITUTION';
CREATE FUNCTION f1(arg TINYINT UNSIGNED) RETURNS TINYINT
BEGIN
  RETURN abs('1abcd');
SELECT f1(-25);
SELECT f1(25);
SET sql_mode=default;
SELECT f1(-25);
SELECT f1(10);
DROP FUNCTION f1;

SET sql_mode='NO_ENGINE_SUBSTITUTION';
CREATE PROCEDURE f1(IN arg TINYINT UNSIGNED)
BEGIN
  DECLARE arg1 TINYINT;
  select abs('1abcd') into arg;
SET sql_mode=default;
DROP PROCEDURE f1;

-- Select does not give error in STRICT mode
SELECT SUBTIME('2006-07-16' , '05:05:02.040778');
SELECT abs('1bcd');

-- Create Stored Procedure in STRICT mode.
delimiter |;
CREATE PROCEDURE sp1()
BEGIN
SELECT SUBTIME('2006-07-16' , '05:05:02.040778');
CREATE PROCEDURE sp2()
BEGIN
DECLARE v1 TINYINT DEFAULT 450000;
DROP PROCEDURE sp1;
DROP PROCEDURE sp2;

-- Create Stored Function in STRICT mode
CREATE FUNCTION fn1(arg TINYINT UNSIGNED) RETURNS float deterministic RETURN abs('1abcd');
CREATE FUNCTION fn2() RETURNS tinyint
BEGIN
DECLARE v1 TINYINT DEFAULT 450000;
SELECT fn1(25);
SELECT fn1(-25);
SELECT fn2();
SET sql_mode='NO_ENGINE_SUBSTITUTION';
SELECT fn1(-25);
DROP FUNCTION fn1;
DROP FUNCTION fn2;
CREATE FUNCTION fn1() RETURNS float deterministic RETURN floor('1.1a');
SET sql_mode=default;
CREATE TABLE t1(a INT);
CREATE FUNCTION fn2() RETURNS float deterministic RETURN floor('1.1a');
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW SET @a=fn2();
INSERT INTO t1 VALUES(1);
DROP TRIGGER tr1;
CREATE TRIGGER tr1 BEFORE INSERT ON t1 FOR EACH ROW SET @a=fn1();
INSERT INTO t1 VALUES(1);
DROP FUNCTION fn1;
DROP FUNCTION fn2;
DROP TRIGGER tr1;
DROP TABLE t1;

-- Test for 'division by zero'
SET sql_mode=traditional;
SELECT 1/0;
SET sql_mode='';
CREATE PROCEDURE proc_c()
BEGIN
  DECLARE div_zero INTEGER;
  SET SQL_MODE='TRADITIONAL';
  SELECT 1/0;
DROP PROCEDURE proc_c;
SET sql_mode=traditional;
CREATE FUNCTION fn1() RETURNS TINYINT
BEGIN
SET  @x=floor('1a');
SELECT fn1();
DROP FUNCTION fn1;
SET sql_mode= default;

CREATE FUNCTION crc(_text TEXT) RETURNS BIGINT(20) UNSIGNED DETERMINISTIC
  RETURN CONV(LEFT(SHA2(_text, 0),16),16,10);

CREATE TABLE t1 (
  id bigint(20) UNSIGNED NOT NULL
);

INSERT INTO t1 (id) VALUES (crc('photos'));
INSERT INTO t1 (id) VALUES (crc('photos1'));

ALTER TABLE t1 ADD INDEX idx (id);

SELECT * FROM t1 FORCE INDEX (idx) WHERE (id = crc('photos')) AND TRUE;
SELECT * FROM t1 IGNORE INDEX (idx) WHERE (id = crc('photos')) AND TRUE;

DROP FUNCTION crc;
DROP TABLE t1;

CREATE TABLE t1(a INTEGER, b INTEGER);

CREATE TRIGGER tr1 AFTER INSERT ON t1 FOR EACH ROW
BEGIN
     CALL proc(NEW.a,NEW.b);
END |

CREATE PROCEDURE proc(IN aa INTEGER)
BEGIN
END |

DELIMITER ;
INSERT INTO t1 VALUES (1,10);

DROP PROCEDURE proc;
DROP TABLE t1;
SET NAMES utf8mb3;
CREATE PROCEDURE cafe() BEGIN END;
CREATE PROCEDURE café() BEGIN END;
CREATE PROCEDURE CAFE() BEGIN END;
DROP PROCEDURE CaFé;
CREATE PROCEDURE очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_e() BEGIN END;
CREATE PROCEDURE очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_é() BEGIN END;
CREATE PROCEDURE очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_E() BEGIN END;
DROP PROCEDURE очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_é;
CREATE FUNCTION cafe() RETURNS INT return 15081947;
CREATE FUNCTION café() RETURNS INT return 15081947;
CREATE FUNCTION CAFE() RETURNS INT return 15081947;
DROP FUNCTION CaFé;
CREATE FUNCTION очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_e() RETURNS INT return 15081947;
CREATE FUNCTION очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_é() RETURNS INT return 15081947;
CREATE FUNCTION очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_E() RETURNS INT return 15081947;
DROP FUNCTION очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_é;

SET NAMES default;
CREATE FUNCTION myfunc(dt VARCHAR(50)) RETURNS VARCHAR(32) DETERMINISTIC
BEGIN
  DECLARE dt_local TIMESTAMP(0);
  SET dt_local = dt;
SELECT myfunc('2019-01-01 00:00:00');
SELECT myfunc('2019-01-01 00:00:71');
SELECT myfunc('2019-01-01 00:00:00');
DROP FUNCTION myfunc;
SET @var = '2019-01-01 00:00:00';
SET @var = '2019-01-01 00:00:71';
SET @var = '2019-01-01 00:00:00';
CREATE FUNCTION func1() RETURNS INT
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION RETURN NULL;
  SELECT * INTO @a FROM fake_table;

CREATE FUNCTION func2() RETURNS INT
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION RETURN NULL;
  SELECT * INTO @a FROM fake_db.fake_table;

SELECT func1();
SELECT func2();

DROP FUNCTION func1;
DROP FUNCTION func2;
CREATE PROCEDURE p()
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;

  SET @x = 0;
    CASE((SELECT q > 1)) WHEN 1 THEN SELECT 1;
    SET @x = @x + 1;
  END WHILE;
DROP PROCEDURE p;
