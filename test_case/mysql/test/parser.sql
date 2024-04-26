--

--=============================================================================
-- LEXICAL PARSER (lex)
--=============================================================================

--
-- Maintainer: these tests are for the lexical parser, so every character,
-- even whitespace or comments, is significant here.
--

SET @save_sql_mode=@@sql_mode;

--
-- Documenting the current behavior, to detect incompatible changes.
-- In each cases:
-- - no error is the correct result
-- - an error is the expected result with the current implementation,
--   and is a limitation.

set SQL_MODE='';

create table ADDDATE(a int);
drop table ADDDATE;
create table ADDDATE (a int);
drop table ADDDATE;
create table BIT_AND(a int);
create table BIT_AND (a int);
drop table BIT_AND;
create table BIT_OR(a int);
create table BIT_OR (a int);
drop table BIT_OR;
create table BIT_XOR(a int);
create table BIT_XOR (a int);
drop table BIT_XOR;
create table CAST(a int);
create table CAST (a int);
drop table CAST;
create table COUNT(a int);
create table COUNT (a int);
drop table COUNT;
create table CURDATE(a int);
create table CURDATE (a int);
drop table CURDATE;
create table CURTIME(a int);
create table CURTIME (a int);
drop table CURTIME;
create table DATE_ADD(a int);
create table DATE_ADD (a int);
drop table DATE_ADD;
create table DATE_SUB(a int);
create table DATE_SUB (a int);
drop table DATE_SUB;
create table EXTRACT(a int);
create table EXTRACT (a int);
drop table EXTRACT;
create table GROUP_CONCAT(a int);
create table GROUP_CONCAT (a int);
drop table GROUP_CONCAT;

-- Limitation removed in 5.1
create table GROUP_UNIQUE_USERS(a int);
drop table GROUP_UNIQUE_USERS;
create table GROUP_UNIQUE_USERS (a int);
drop table GROUP_UNIQUE_USERS;
create table MAX(a int);
create table MAX (a int);
drop table MAX;
create table MID(a int);
create table MID (a int);
drop table MID;
create table MIN(a int);
create table MIN (a int);
drop table MIN;
create table NOW(a int);
create table NOW (a int);
drop table NOW;
create table POSITION(a int);
create table POSITION (a int);
drop table POSITION;

create table SESSION_USER(a int);
drop table SESSION_USER;
create table SESSION_USER (a int);
drop table SESSION_USER;
create table STD(a int);
create table STD (a int);
drop table STD;
create table STDDEV(a int);
create table STDDEV (a int);
drop table STDDEV;
create table STDDEV_POP(a int);
create table STDDEV_POP (a int);
drop table STDDEV_POP;
create table STDDEV_SAMP(a int);
create table STDDEV_SAMP (a int);
drop table STDDEV_SAMP;

create table SUBDATE(a int);
drop table SUBDATE;
create table SUBDATE (a int);
drop table SUBDATE;
create table SUBSTR(a int);
create table SUBSTR (a int);
drop table SUBSTR;
create table SUBSTRING(a int);
create table SUBSTRING (a int);
drop table SUBSTRING;
create table SUM(a int);
create table SUM (a int);
drop table SUM;
create table SYSDATE(a int);
create table SYSDATE (a int);
drop table SYSDATE;

create table SYSTEM_USER(a int);
drop table SYSTEM_USER;
create table SYSTEM_USER (a int);
drop table SYSTEM_USER;
create table TRIM(a int);
create table TRIM (a int);
drop table TRIM;

-- Limitation removed in 5.1
create table UNIQUE_USERS(a int);
drop table UNIQUE_USERS;
create table UNIQUE_USERS (a int);
drop table UNIQUE_USERS;
create table VARIANCE(a int);
create table VARIANCE (a int);
drop table VARIANCE;
create table VAR_POP(a int);
create table VAR_POP (a int);
drop table VAR_POP;
create table VAR_SAMP(a int);
create table VAR_SAMP (a int);
drop table VAR_SAMP;

set SQL_MODE='IGNORE_SPACE';

create table ADDDATE(a int);
drop table ADDDATE;
create table ADDDATE (a int);
drop table ADDDATE;
create table BIT_AND(a int);
create table BIT_AND (a int);
create table BIT_OR(a int);
create table BIT_OR (a int);
create table BIT_XOR(a int);
create table BIT_XOR (a int);
create table CAST(a int);
create table CAST (a int);
create table COUNT(a int);
create table COUNT (a int);
create table CURDATE(a int);
create table CURDATE (a int);
create table CURTIME(a int);
create table CURTIME (a int);
create table DATE_ADD(a int);
create table DATE_ADD (a int);
create table DATE_SUB(a int);
create table DATE_SUB (a int);
create table EXTRACT(a int);
create table EXTRACT (a int);
create table GROUP_CONCAT(a int);
create table GROUP_CONCAT (a int);

-- Limitation removed in 5.1
create table GROUP_UNIQUE_USERS(a int);
drop table GROUP_UNIQUE_USERS;
create table GROUP_UNIQUE_USERS (a int);
drop table GROUP_UNIQUE_USERS;
create table MAX(a int);
create table MAX (a int);
create table MID(a int);
create table MID (a int);
create table MIN(a int);
create table MIN (a int);
create table NOW(a int);
create table NOW (a int);
create table POSITION(a int);
create table POSITION (a int);

create table SESSION_USER(a int);
drop table SESSION_USER;
create table SESSION_USER (a int);
drop table SESSION_USER;
create table STD(a int);
create table STD (a int);
create table STDDEV(a int);
create table STDDEV (a int);
create table STDDEV_POP(a int);
create table STDDEV_POP (a int);
create table STDDEV_SAMP(a int);
create table STDDEV_SAMP (a int);

create table SUBDATE(a int);
drop table SUBDATE;
create table SUBDATE (a int);
drop table SUBDATE;
create table SUBSTR(a int);
create table SUBSTR (a int);
create table SUBSTRING(a int);
create table SUBSTRING (a int);
create table SUM(a int);
create table SUM (a int);
create table SYSDATE(a int);
create table SYSDATE (a int);

create table SYSTEM_USER(a int);
drop table SYSTEM_USER;
create table SYSTEM_USER (a int);
drop table SYSTEM_USER;
create table TRIM(a int);
create table TRIM (a int);

-- Limitation removed in 5.1
create table UNIQUE_USERS(a int);
drop table UNIQUE_USERS;
create table UNIQUE_USERS (a int);
drop table UNIQUE_USERS;
create table VARIANCE(a int);
create table VARIANCE (a int);
create table VAR_POP(a int);
create table VAR_POP (a int);
create table VAR_SAMP(a int);
create table VAR_SAMP (a int);

CREATE TABLE t1 (i INT KEY);

CREATE TABLE t2 (i INT UNIQUE);

CREATE TABLE t3 (i INT UNIQUE KEY);

DROP TABLE t1, t2, t3;

--
-- Bug#25930 (CREATE TABLE x SELECT ... parses columns wrong when ran with
--            ANSI_QUOTES mode)
--

--disable_warnings
DROP TABLE IF EXISTS table_25930_a;
DROP TABLE IF EXISTS table_25930_b;

SET SQL_MODE = 'ANSI_QUOTES';
CREATE TABLE table_25930_a ( "blah" INT );
CREATE TABLE table_25930_b SELECT "blah" - 1 FROM table_25930_a;

-- The lexer used to chop the first <">,
-- not marking the start of the token "blah" correctly.
desc table_25930_b;

DROP TABLE table_25930_a;
DROP TABLE table_25930_b;


SET @@sql_mode=@save_sql_mode;

--
-- Bug#26030 (Parsing fails for stored routine w/multi-statement execution
-- enabled)
--

--disable_warnings
DROP PROCEDURE IF EXISTS p26030;

select "non terminated"$$
select "terminated";
select "non terminated, space"      $$
select "terminated, space";
select "non terminated, comment" /* comment */$$
select "terminated, comment";

select "stmt 1";
select "stmt 1";
select "stmt 1";
select "stmt 1";
select "stmt 1";
select "stmt 1";

select "stmt 1";
select "stmt 1";

DROP PROCEDURE IF EXISTS p26030;
$$

DROP PROCEDURE IF EXISTS p26030;
$$

delimiter ;
DROP PROCEDURE p26030;

--
--
-- Bug#21114 (Foreign key creation fails to table with name format)
-- 

-- Test coverage with edge conditions

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select pi(3.14);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select tan();
select tan(1, 2);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select makedate(1);
select makedate(1, 2, 3);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select maketime();
select maketime(1);
select maketime(1, 2);
select maketime(1, 2, 3, 4);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select atan();
select atan2(1, 2, 3);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select concat();
select concat("foo");

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select concat_ws();
select concat_ws("foo");

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select elt();
select elt(1);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select export_set();
select export_set("p1");
select export_set("p1", "p2");
select export_set("p1", "p2", "p3", "p4", "p5", "p6");

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select field();
select field("p1");

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select from_unixtime();
select from_unixtime(1, 2, 3);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select unix_timestamp(1, 2);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select greatest();
select greatest(12);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select last_insert_id(1, 2);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select least();
select least(12);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select locate();
select locate(1);
select locate(1, 2, 3, 4);

-- error ER_PARSE_ERROR
select log();
select log(1, 2, 3);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select make_set();
select make_set(1);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select source_pos_wait();
select source_pos_wait(1);
select source_pos_wait('binlog.999999', 4, -1);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select rand(1, 2, 3);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select round(1, 2, 3);

-- error ER_WRONG_PARAMCOUNT_TO_NATIVE_FCT
select yearweek();
select yearweek(1, 2, 3);

--
-- Bug#24736: UDF functions parsed as Stored Functions
--

-- Verify that the syntax for calling UDF : foo(expr AS param, ...)
-- can not be used when calling native functions

-- Native function with 1 argument

select abs(3);
select abs(3 AS three);
select abs(3 three);
select abs(3 AS "three");
select abs(3 "three");

-- Native function with 2 arguments

set @bar="bar";
set @foobar="foobar";

select instr("foobar", "bar");
select instr("foobar" AS p1, "bar");
select instr("foobar" p1, "bar");
select instr("foobar" AS "p1", "bar");
--# String concatenation, valid syntax
select instr("foobar" "p1", "bar");
select instr(@foobar "p1", "bar");
select instr("foobar", "bar" AS p2);
select instr("foobar", "bar" p2);
select instr("foobar", "bar" AS "p2");
--# String concatenation, valid syntax
select instr("foobar", "bar" "p2");
select instr("foobar", @bar "p2");
select instr("foobar" AS p1, "bar" AS p2);

-- Native function with 3 arguments

select conv(255, 10, 16);
select conv(255 AS p1, 10, 16);
select conv(255 p1, 10, 16);
select conv(255 AS "p1", 10, 16);
select conv(255 "p1", 10, 16);
select conv(255, 10 AS p2, 16);
select conv(255, 10 p2, 16);
select conv(255, 10 AS "p2", 16);
select conv(255, 10 "p2", 16);
select conv(255, 10, 16 AS p3);
select conv(255, 10, 16 p3);
select conv(255, 10, 16 AS "p3");
select conv(255, 10, 16 "p3");
select conv(255 AS p1, 10 AS p2, 16 AS p3);

-- Native function with a variable number of arguments

-- Bug in libm.so on Solaris:
--   atan(10) from 32-bit version returns 1.4711276743037347
--   atan(10) from 64-bit version returns 1.4711276743037345
--replace_result 1.4711276743037345 1.4711276743037347
select atan(10);
select atan(10 AS p1);
select atan(10 p1);
select atan(10 AS "p1");
select atan(10 "p1");

select atan(10, 20);
select atan(10 AS p1, 20);
select atan(10 p1, 20);
select atan(10 AS "p1", 20);
select atan(10 "p1", 20);
select atan(10, 20 AS p2);
select atan(10, 20 p2);
select atan(10, 20 AS "p2");
select atan(10, 20 "p2");
select atan(10 AS p1, 20 AS p2);

--
-- Bug#22312 Syntax error in expression with INTERVAL()
--

--disable_warnings
DROP TABLE IF EXISTS t1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
SELECT STR_TO_DATE('10:00 PM', '%h:%i %p') + INTERVAL 10 MINUTE;
SELECT STR_TO_DATE('10:00 PM', '%h:%i %p') + INTERVAL (INTERVAL(1,2,3) + 1) MINUTE;
SELECT "1997-12-31 23:59:59" + INTERVAL 1 SECOND;
SELECT 1 + INTERVAL(1,0,1,2) + 1;
SELECT INTERVAL(1^1,0,1,2) + 1;
SELECT INTERVAL(1,0+1,2,3) * 5.5;
SELECT INTERVAL(3,3,1+3,4+4) / 0.5;
SELECT (INTERVAL(1,0,1,2) + 5) * 7 + INTERVAL(1,0,1,2) / 2;
SELECT INTERVAL(1,0,1,2) + 1, 5 * INTERVAL(1,0,1,2);
SELECT INTERVAL(0,(1*5)/2) + INTERVAL(5,4,3);
SELECT 1^1 + INTERVAL 1+1 SECOND & 1 + INTERVAL 1+1 SECOND;
SELECT 1%2 - INTERVAL 1^1 SECOND | 1%2 - INTERVAL 1^1 SECOND;

CREATE TABLE t1 (a INT, b DATETIME);
INSERT INTO t1 VALUES (INTERVAL(3,2,1) + 1, "1997-12-31 23:59:59" + INTERVAL 1 SECOND);
SELECT * FROM t1 WHERE a = INTERVAL(3,2,1) + 1;
DROP TABLE t1;
SET sql_mode = default;
--

--disable_warnings
DROP TABLE IF EXISTS t1,t2,t3;
CREATE TABLE t1 (a1 INT, a2 INT, a3 INT, a4 DATETIME);
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
SELECT t1.* FROM t1 AS t0, { OJ t2 INNER JOIN t1 ON (t1.a1=t2.a1) } WHERE t0.a3=2;
SELECT t1.*,t2.* FROM { OJ ((t1 INNER JOIN t2 ON (t1.a1=t2.a2)) LEFT OUTER JOIN t3 ON t3.a3=t2.a1)};
SELECT t1.*,t2.* FROM { OJ ((t1 LEFT OUTER JOIN t2 ON t1.a3=t2.a2) INNER JOIN t3 ON (t3.a1=t2.a2))};
SELECT t1.*,t2.* FROM { OJ (t1 LEFT OUTER JOIN t2 ON t1.a1=t2.a2) CROSS JOIN t3 ON (t3.a2=t2.a3)};
SELECT * FROM {oj t1 LEFT OUTER JOIN t2 ON t1.a1=t2.a3} WHERE t1.a2 > 10;
SELECT {fn CONCAT(a1,a2)} FROM t1;
UPDATE t3 SET a4={d '1789-07-14'} WHERE a1=0;
SELECT a1, a4 FROM t2 WHERE a4 LIKE {fn UCASE('1789-07-14')};
DROP TABLE t1, t2, t3;

--
-- Bug#12546960 - 60993: NAME QUOTED WITH QUOTE INSTEAD OF BACKTICK 
--                       GIVES NO SYNTAX ERROR
--
CREATE TABLE t (id INT PRIMARY KEY);
DROP TABLE t;

CREATE TABLE t1 (i INT);
SELECT (SELECT EXISTS(SELECT * LIMIT 1 ORDER BY VALUES (c00)));
CREATE TABLE a(a int);
CREATE TABLE b(a int);
DELETE FROM b ORDER BY(SELECT 1 FROM a ORDER BY a ORDER BY a);
DROP TABLE a, b;
SELECT '' IN (SELECT '1' c FROM t1 ORDER BY '' ORDER BY '') FROM t1;

SELECT 1 FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1
  FOR UPDATE;

SELECT 1 FROM
  (SELECT 1 FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1
   FOR UPDATE) a;

SELECT 1 FROM t1
  WHERE EXISTS(SELECT 1 FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1
               FOR UPDATE);

SELECT 1 FROM t1
UNION
SELECT 1 FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1
  FOR UPDATE;
 FOR UPDATE);

SELECT 1 FROM t1 UNION SELECT 1 FROM t1 ORDER BY 1 LIMIT 1;
SELECT 1 FROM t1 FOR UPDATE UNION SELECT 1 FROM t1 ORDER BY 1 LIMIT 1;
SELECT 1 FROM t1 UNION SELECT 1 FROM t1 ORDER BY 1 LIMIT 1 FOR UPDATE;

SELECT 1 FROM t1 INTO @var17727401;
SELECT 1 FROM DUAL INTO @var17727401;
SELECT 1 INTO @var17727401;

SELECT 1 INTO @var17727401 FROM t1;
SELECT 1 INTO @var17727401 FROM DUAL;

-- Double "INTO" clause: parse error is "near 'INTO @var17727401_2' at line 1"
--error ER_MULTIPLE_INTO_CLAUSES
SELECT 1 INTO @var17727401_1 FROM t1 INTO @var17727401_2;

-- Double "INTO" clause: parse error is "near 'INTO @var17727401_2' at line 2"
--error ER_MULTIPLE_INTO_CLAUSES
SELECT 1 INTO @var17727401_1 FROM DUAL
  INTO @var17727401_2;

SELECT 1 INTO @var17727401 FROM t1 WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1 LIMIT 1;
SELECT 1 FROM t1 WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1 LIMIT 1 INTO @var17727401;
SELECT 1 FROM t1 WHERE 1 INTO @var17727401 GROUP BY 1 HAVING 1 ORDER BY 1 LIMIT 1;
SELECT 1 INTO @var17727401_1
  FROM t1 WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1 LIMIT 1
  INTO @var17727401_2;
SELECT (SELECT 1 FROM t1 INTO @var17727401);
SELECT 1 FROM (SELECT 1 FROM t1 INTO @var17727401) a;
SELECT EXISTS(SELECT 1 FROM t1 INTO @var17727401);
SELECT 1 FROM t1 INTO @var17727401 UNION SELECT 1 FROM t1 INTO t1;

SELECT 1 FROM t1 UNION SELECT 1 FROM t1 INTO @var17727401;

-- ORDER/LIMIT and UNION:

let $q=SELECT 1 FROM t1 UNION SELECT 1 FROM t1 ORDER BY 1;

let $q=SELECT 1 FROM t1 UNION SELECT 1 FROM t1 LIMIT 1;

let $q=SELECT 1 FROM t1 UNION SELECT 1 FROM t1 ORDER BY 1 LIMIT 1;

let $q=SELECT 1 FROM t1 UNION SELECT 1 FROM t1 LIMIT 1 ORDER BY 1;

let $q=SELECT 1 FROM t1 ORDER BY 1 UNION SELECT 1 FROM t1;

let $q=SELECT 1 FROM t1 LIMIT 1 UNION SELECT 1 FROM t1;

let $q=SELECT 1 FROM t1 ORDER BY 1 LIMIT 1 UNION SELECT 1 FROM t1;

let $q=SELECT 1 FROM t1 LIMIT 1 ORDER BY 1 UNION SELECT 1 FROM t1;

let $q=SELECT 1 FROM t1 ORDER BY 1 UNION SELECT 1 FROM t1 ORDER BY 1;

let $q=SELECT 1 FROM t1 LIMIT 1 UNION SELECT 1 FROM t1 LIMIT 1;

let $q=SELECT 1 FROM t1 LIMIT 1 UNION SELECT 1 FROM t1 ORDER BY 1;

let $q=SELECT 1 FROM t1 ORDER BY 1 UNION SELECT 1 FROM t1 LIMIT 1;

DROP TABLE t1;

SELECT COUNT(1) FROM DUAL GROUP BY '1' ORDER BY 1 ;
SELECT COUNT(1)           GROUP BY '1' ORDER BY 1 ;

SELECT (SELECT 1 c                   GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is not expected';
SELECT (SELECT 1 c FROM DUAL         GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is not expected';
SELECT (SELECT 1 c                   GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c FROM DUAL         GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';

SELECT (SELECT 1 c           WHERE 1 GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is not expected';
SELECT (SELECT 1 c FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is not expected';
SELECT (SELECT 1 c           WHERE 1 GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c FROM DUAL WHERE 1 GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';

SELECT (SELECT 1 c           WHERE 0 GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c FROM DUAL WHERE 0 GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c           WHERE 0 GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c FROM DUAL WHERE 0 GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';

SELECT 1 c FROM DUAL GROUP BY 1 HAVING 1 ORDER BY COUNT(1);
SELECT 1 c FROM DUAL GROUP BY 1 HAVING 0 ORDER BY COUNT(1);
SELECT 1 c           GROUP BY 1 HAVING 1 ORDER BY COUNT(1);

CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);

SELECT ((SELECT 1 AS f           HAVING EXISTS(SELECT 1 FROM t1) IS TRUE
  ORDER BY f));
SELECT ((SELECT 1 AS f FROM DUAL HAVING EXISTS(SELECT 1 FROM t1) IS TRUE
  ORDER BY f));

SELECT 1 AS f          FROM DUAL HAVING EXISTS(SELECT 1 FROM t1) IS TRUE
  ORDER BY f;
SELECT 1 AS f                   HAVING EXISTS(SELECT 1 FROM t1) IS TRUE
  ORDER BY f;

DROP TABLE t1;
SET default_storage_engine=a.myisam;
SET default_storage_engine = .a.MyISAM;
SET default_storage_engine = a.b.MyISAM;
SET default_storage_engine = `a`.MyISAM;
SET default_storage_engine = `a`.`MyISAM`;
set default_storage_engine = "a.MYISAM";
set default_storage_engine = 'a.MYISAM';
set default_storage_engine = `a.MYISAM`;
CREATE TABLE t1 (s VARCHAR(100));
CREATE TRIGGER trigger1 BEFORE INSERT ON t1 FOR EACH ROW
SET default_storage_engine = NEW.INNODB;
DROP TABLE t1;

CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2 (i INT);
INSERT INTO t2 VALUES (10), (20);

SELECT i FROM t1 WHERE i = 1
UNION
SELECT i FROM t2 WHERE i = 10
ORDER BY i;

SELECT i FROM t1 WHERE i = 1
UNION
SELECT i FROM t2 WHERE i = 10
LIMIT 100;

SELECT i FROM t1 WHERE i = 1
UNION
SELECT i FROM t2 GROUP BY i HAVING i = 10
ORDER BY i;

SELECT i FROM t1 WHERE i = 1
UNION
SELECT i FROM t2 GROUP BY i HAVING i = 10
LIMIT 100;

DROP TABLE t1, t2;

CREATE TABLE t1(b INT);
CREATE TABLE t2(a INT, b INT, c INT, d INT);
(
  SELECT
  ROW(t1.b, a) = ROW( ROW(1, t2.c) = ROW(1, d), c) = a
  FROM t1
)
FROM t2 GROUP BY a;

DROP TABLE t1, t2;

CREATE TABLE t1 (
  a INT
);

INSERT INTO t1 VALUES ( 2 );
SELECT *
FROM ( SELECT a FROM t1 UNION SELECT 1 ORDER BY a ) AS a1
WHERE a1.a = 1 OR a1.a = 2;

DROP TABLE t1;

-- original bugreport:
--error ER_TOO_BIG_PRECISION
DO(CONVERT(CONVERT('',DECIMAL(66,0)), DECIMAL(66,0))), CAST(CONVERT(1,DECIMAL(65,31)) AS DATE);

-- test an error message for the complex "column" name: "CONVERT('',DECIMAL(65,0))"
--error ER_TOO_BIG_PRECISION
SELECT CONVERT(CONVERT('',DECIMAL(65,0)), DECIMAL(66,0));
SELECT 1<
!(1 XOR TO_BASE64()));
SELECT 1<
!(1 XOR TO_BASE64());
SELECT  !('' XOR LENGTH());
SELECT  !((UNHEX() IS NULL));
CREATE DATABASE mysqltest1 CHARACTER SET LATIN2;
USE mysqltest1;
CREATE TABLE t1 (a VARCHAR(255) CHARACTER SET LATIN2);
SET CHARACTER SET cp1250_latin2;
INSERT INTO t1 VALUES ('����');
INSERT INTO t1 VALUES ('����' '');
SELECT HEX(a) FROM t1;
DROP DATABASE mysqltest1;
USE test;

CREATE TABLE t1 (i INT);

INSERT INTO t1 () SELECT * FROM t1;
INSERT INTO t1 SELECT HIGH_PRIORITY * FROM t1;
INSERT INTO t1 SELECT DISTINCT ALL * FROM t1;
DELETE QUICK FROM t1 WHERE i = 0;

DROP TABLE t1;

SET @parse_gcol_expr = 1;

SELECT 1 AS parse_gcol_expr;

CREATE TABLE parse_gcol_expr (i INT);
DROP TABLE parse_gcol_expr;
CREATE PROCEDURE p1()
BEGIN
parse_gcol_expr: LOOP
  SELECT 1;
END LOOP parse_gcol_expr;

DROP PROCEDURE p1;

-- Test some variant of dummy ALTER TABLE statements.

CREATE TABLE t1 (x INT PRIMARY KEY);
ALTER TABLE t1;
ALTER TABLE t1 ALGORITHM=DEFAULT;
ALTER TABLE t1 ALGORITHM=COPY;
ALTER TABLE t1 ALGORITHM=INPLACE;
ALTER TABLE t1 LOCK=DEFAULT;
ALTER TABLE t1 LOCK=NONE;
ALTER TABLE t1 LOCK=SHARED;
ALTER TABLE t1 LOCK=EXCLUSIVE;
ALTER TABLE t1 LOCK=SHARED, ALGORITHM=COPY,
               LOCK=NONE, ALGORITHM=DEFAULT,
               LOCK=EXCLUSIVE, ALGORITHM=INPLACE;
ALTER TABLE t1 WITH VALIDATION;
ALTER TABLE t1 WITHOUT VALIDATION;
ALTER TABLE t1 LOCK=SHARED, WITH VALIDATION, ALGORITHM=COPY,
               LOCK=EXCLUSIVE, WITHOUT VALIDATION, ALGORITHM=INPLACE;
DROP TABLE t1;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES ( 1 );

CREATE TABLE t2 ( a INT );
INSERT INTO t2 VALUES ( 2 ), ( 2 );

CREATE TABLE t3 ( a INT );
INSERT INTO t3 VALUES ( 3 ), ( 3 ), ( 3 );

SELECT 1 UNION SELECT 2;
SELECT 1 UNION (SELECT 2);

  SELECT 2 FROM t1 UNION ((SELECT 3 FROM t1));
SELECT a FROM t1 LIMIT 1 UNION ALL SELECT a FROM t1;
SELECT 1 UNION SELECT 2 FROM t1 ORDER BY a LIMIT 1;
SELECT 1 UNION (SELECT 2 FROM t1 ORDER BY a LIMIT 1);

-- [ before WL11350: Generally speaking, we don't support nested unions]
-- We do now.

SELECT 1 UNION ( SELECT 1 UNION SELECT 1 );

-- Missing ")":
--error ER_PARSE_ERROR
( SELECT 1 UNION ( SELECT 1 UNION SELECT 1 ) UNION SELECT 1;
SELECT a FROM t1 ORDER BY a UNION SELECT a FROM t1;
SELECT a FROM t1
UNION
SELECT a FROM t1 ORDER BY a
UNION
SELECT a FROM t1;

DROP TABLE t1, t2, t3;

CREATE PROCEDURE p1() BEGIN IF whatever THEN SELECT 1;

DROP PROCEDURE p1;

CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES ( 1 );

CREATE TABLE t2 ( a INT );
INSERT INTO t2 VALUES ( 2 ), ( 2 );

CREATE TABLE t3 ( a INT );
INSERT INTO t3 VALUES ( 3 ), ( 3 ), ( 3 );

   (SELECT 1 FROM t1   UNION   SELECT 2 FROM t1);

DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES ( 1 );

CREATE TABLE t2 ( a INT );
INSERT INTO t2 VALUES ( 2 );

CREATE TABLE t3 ( a INT );
INSERT INTO t3 VALUES ( 3 );

CREATE TABLE t4 ( a INT );
INSERT INTO t4 VALUES ( 3 );

SELECT * FROM    (SELECT 1 FROM t1   UNION   SELECT 2 FROM t1) dt;
SELECT * FROM   ((SELECT 1 FROM t1   UNION   SELECT 2 FROM t1)) dt;
SELECT * FROM    (SELECT 1 FROM t1   UNION  (SELECT 2 FROM t1)) dt;
SELECT * FROM   ((SELECT 1 FROM t1   UNION  (SELECT 2 FROM t1))) dt;
SELECT * FROM   ((SELECT 1 FROM t1   UNION ((SELECT 2 FROM t1)))) dt;
SELECT * FROM   ((SELECT 1 FROM t1)  UNION   SELECT 2 FROM t1) dt;
SELECT * FROM  (((SELECT 1 FROM t1)) UNION   SELECT 2 FROM t1) dt;
SELECT * FROM ((((SELECT 1 FROM t1)) UNION   SELECT 2 FROM t1)) dt;
SELECT * FROM   ((SELECT 1 FROM t1)  UNION  (SELECT 2 FROM t1)) dt;
SELECT * FROM  (((SELECT 1 FROM t1)  UNION  (SELECT 2 FROM t1))) dt;
SELECT * FROM ((((SELECT 1 FROM t1)) UNION  (SELECT 2 FROM t1))) dt;
SELECT * FROM  (((SELECT 1 FROM t1)  UNION ((SELECT 2 FROM t1)))) dt;
SELECT * FROM ((((SELECT 1 FROM t1)) UNION ((SELECT 2 FROM t1)))) dt;
SELECT * FROM    (SELECT 1 FROM t1   UNION   SELECT 2 FROM t1);
SELECT * FROM   ((SELECT 1 FROM t1   UNION   SELECT 2 FROM t1));
SELECT * FROM    (SELECT 1 FROM t1   UNION  (SELECT 2 FROM t1));
SELECT * FROM   ((SELECT 1 FROM t1   UNION  (SELECT 2 FROM t1)));
SELECT * FROM   ((SELECT 1 FROM t1   UNION ((SELECT 2 FROM t1))));
SELECT * FROM   ((SELECT 1 FROM t1)  UNION   SELECT 2 FROM t1);
SELECT * FROM  (((SELECT 1 FROM t1)) UNION   SELECT 2 FROM t1);
SELECT * FROM ((((SELECT 1 FROM t1)) UNION   SELECT 2 FROM t1));
SELECT * FROM   ((SELECT 1 FROM t1)  UNION  (SELECT 2 FROM t1));
SELECT * FROM  (((SELECT 1 FROM t1)  UNION  (SELECT 2 FROM t1)));
SELECT * FROM ((((SELECT 1 FROM t1)) UNION  (SELECT 2 FROM t1)));
SELECT * FROM  (((SELECT 1 FROM t1)  UNION ((SELECT 2 FROM t1))));
SELECT * FROM ((((SELECT 1 FROM t1)) UNION ((SELECT 2 FROM t1))));

SELECT * FROM  ( t1 JOIN t2 ON TRUE );
SELECT * FROM (( t1 JOIN t2 ON TRUE ));

SELECT * FROM ( t1 JOIN t2 ON TRUE  JOIN t3 ON TRUE );
SELECT * FROM ((t1 JOIN t2 ON TRUE) JOIN t3 ON TRUE );

SELECT * FROM (t1 INNER JOIN t2 ON (t1.a = t2.a));
SELECT 1 FROM (SELECT 1 FROM t1 INTO @v) a;

SELECT 1 FROM (t1);
SELECT 1 FROM ((t1));

SELECT 1 UNION SELECT 2 FROM (t2);

SELECT 1 FROM  (SELECT 2  ORDER BY 1) AS res;
SELECT 1 FROM ((SELECT 2) ORDER BY 1) AS res;
SELECT 1 FROM ((SELECT 2) a ORDER BY 1) AS res;
SELECT 1 FROM ((SELECT 2) LIMIT 1) AS res;
SELECT 1 FROM ((SELECT 2) a LIMIT 1) AS res;

SELECT * FROM ( t1 AS alias1 );
SELECT * FROM   t1 AS alias1, t2 AS alias2;
SELECT * FROM ( t1 AS alias1, t2 AS alias2 );
SELECT * FROM ( t1 JOIN t2 ON TRUE, t1 JOIN t3 ON TRUE );
SELECT * FROM ( t1 JOIN t2 ON TRUE, t1 t11 JOIN t3 ON TRUE ) t1a;
SELECT * FROM ( t1 JOIN t2 ON TRUE, SELECT 1 FROM DUAL );
SELECT * FROM ( t1 JOIN t2 ON TRUE, (SELECT 1 FROM DUAL) t1a );
SELECT * FROM t1 JOIN t2 ON TRUE, (SELECT 1 FROM DUAL) t1a;
SELECT * FROM ( SELECT 1 FROM DUAL );

SELECT * FROM ( SELECT 1 FROM DUAL ) t1a;

SELECT * FROM  ( t1, t2 );
SELECT * FROM (( t1, t2 ));

SELECT * FROM  ( (t1),   t2  );
SELECT * FROM  (((t1)),  t2  );
SELECT * FROM  ( (t1),  (t2) );
SELECT * FROM  (  t1,   (t2) );
SELECT * FROM ((SELECT 1 UNION SELECT 1) UNION SELECT 1) a;

SELECT * FROM (t1, t2) JOIN (t3, t4) ON TRUE;
SELECT * FROM ((t1, t2) JOIN t3 ON TRUE);
SELECT * FROM t1 JOIN ( t2, t3 ) USING ( a );

DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (a INT);
DROP TABLE t1;

CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( b INT );
CREATE TABLE t3 ( c INT );
CREATE TABLE t4 ( d INT );
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t3 VALUES (2);
INSERT INTO t4 VALUES (2);

SELECT * FROM t1 LEFT JOIN ( t2, t3, t4 ) ON a = c;
SELECT * FROM t1 NATURAL JOIN ((t1 NATURAL JOIN t1), (t1 NATURAL JOIN t1));

DROP TABLE t1, t2, t3, t4;

CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( b INT );
CREATE TABLE t3 ( c INT );
CREATE TABLE t4 ( d INT );
CREATE TABLE t5 ( d INT );

SELECT * FROM t5 NATURAL JOIN ((t1 NATURAL JOIN t2), (t3 NATURAL JOIN t4));

SELECT * FROM ((t1 NATURAL JOIN t2), (t3 NATURAL JOIN t4)) NATURAL JOIN t5;

SELECT * FROM t1 JOIN ( t2, t3 ) ON TRUE;

SELECT * FROM ( t1, t2 , t3 );
SELECT * FROM ( ( t1, t2 ), t3 );
SELECT * FROM ( ((t1, t2)), t3 );
SELECT * FROM ( t1, ( t2, t3 ) );
SELECT * FROM ( t1, ((t2, t3)) );

SELECT * FROM ((( t1, t2 ), t3));
SELECT * FROM ((((t1, t2)), t3));
SELECT * FROM ((t1, ( t2, t3 )));
SELECT * FROM ((t1, ((t2, t3))));
CREATE VIEW v1 AS SELECT 1 INTO @v;

CREATE VIEW v1 AS SELECT 1 FROM ( SELECT 1 FROM t1 ) my_table;

DROP TABLE t1, t2, t3, t4, t5;
DROP VIEW v1;

CREATE TABLE t1( a INT );
INSERT INTO t1 VALUES (1);

SELECT 1 INTO @v;

SELECT 1 FROM t1 INTO @v;
SELECT 1 FROM t1 INTO @v UNION SELECT 1;
SELECT 1 FROM t1 INTO @v UNION (SELECT 1);
SELECT 1 INTO @v UNION SELECT 1;
SELECT 1 INTO @v UNION (SELECT 1);
SELECT 1 UNION SELECT 2 INTO @v;
SELECT 1 UNION SELECT 2 INTO @v FROM t1;

SELECT 1 UNION SELECT 1 INTO @v FROM t1;

SELECT 1 UNION SELECT 2 INTO OUTFILE 'parser.test.file1';
SELECT 1 UNION (SELECT 2 INTO OUTFILE 'parser.test.file2');
SELECT * FROM (SELECT a INTO @v FROM t1) t1a;
SELECT * FROM (SELECT a INTO @v) t1a;

DROP TABLE t1;
CREATE TABLE t1( a INT );
CREATE TABLE t2( b INT );
CREATE TABLE t3( c INT );
CREATE TABLE t4( d INT );
CREATE TABLE t5( e INT );

SET optimizer_switch = 'block_nested_loop=off';

SELECT * FROM t1 JOIN t2;
SELECT * FROM t1 JOIN t2 ON a = b;
SELECT * FROM t1 t11 JOIN t1 t12 USING ( a );
SELECT * FROM t1 INNER JOIN t2;
SELECT * FROM t1 INNER JOIN t2 ON a = b;
SELECT * FROM t1 t11 INNER JOIN t1 t12 USING ( a );

SELECT * FROM t1 CROSS JOIN t2;
SELECT * FROM t1 CROSS JOIN t2 ON a = b;
SELECT * FROM t1 t11 CROSS JOIN t1 t12 USING ( a );

SELECT * FROM t1 STRAIGHT_JOIN t2;
SELECT * FROM t1 STRAIGHT_JOIN t2 ON a = b;
SELECT * FROM t1 t11 STRAIGHT_JOIN t1 t12 USING ( a );

SELECT * FROM t1 t11 NATURAL JOIN t1 t12;
SELECT * FROM t1 t11 NATURAL JOIN t1 t12 ON t11.a = t12.a;
SELECT * FROM t1 t11 NATURAL JOIN t1 t12 USING ( a );
SELECT * FROM t1 t11 NATURAL INNER JOIN t1 t12;
SELECT * FROM t1 LEFT JOIN t2;
SELECT * FROM t1 LEFT JOIN t2 ON a = b;
SELECT * FROM t1 t11 LEFT JOIN t1 t12 USING ( a );
SELECT * FROM t1 NATURAL LEFT JOIN t2;
SELECT * FROM t1 LEFT OUTER JOIN t2;
SELECT * FROM t1 LEFT OUTER JOIN t2 ON a = b;
SELECT * FROM t1 t11 LEFT OUTER JOIN t1 t12 USING ( a );
SELECT * FROM t1 NATURAL LEFT OUTER JOIN t2;
SELECT * FROM t1 RIGHT JOIN t2;
SELECT * FROM t1 RIGHT JOIN t2 ON a = b;
SELECT * FROM t1 t11 RIGHT JOIN t1 t12 USING ( a );
SELECT * FROM t1 NATURAL RIGHT JOIN t2;
SELECT * FROM t1 RIGHT OUTER JOIN t2;
SELECT * FROM t1 RIGHT OUTER JOIN t2 ON a = b;
SELECT * FROM t1 t11 RIGHT OUTER JOIN t1 t12 USING ( a );
SELECT * FROM t1 NATURAL RIGHT OUTER JOIN t2;

SET optimizer_switch = DEFAULT;

DROP TABLE t1, t2, t3, t4, t5;
CREATE TABLE t1( a INT, b int );
CREATE TABLE t2( a INT, c int );
CREATE TABLE t3( a INT, d int );

INSERT INTO t1 VALUES (1, 1), (2, 2), (3, 3);
INSERT INTO t2 VALUES         (2, 2), (3, 3), (4, 4);
INSERT INTO t3 VALUES                 (3, 3), (4, 4), (5, 5);
SELECT * FROM t1 NATURAL LEFT JOIN t2 NATURAL RIGHT JOIN t3;
SELECT * FROM (t1 NATURAL LEFT JOIN t2) NATURAL RIGHT JOIN t3;
SELECT * FROM t1 NATURAL LEFT JOIN (t2 NATURAL RIGHT JOIN t3);

DROP TABLE t1, t2, t3;

CREATE TABLE t1 (
  a INT,
  b INT,
  c INT,
  d INT,
  e INT,
  f INT,
  g INT,
  h INT,
  i INT,
  j INT,
  k INT,
  l INT,
  m INT,
  n INT,
  o INT
 );

CREATE        INDEX a_index             ON t1( a );
CREATE UNIQUE INDEX b_index             ON t1( b );
CREATE        INDEX c_index USING btree ON t1( c );
CREATE        INDEX c_index USING btree USING btree ON t1( c );
CREATE        INDEX d_index USING rtree ON t1( d );
CREATE        INDEX e_index TYPE  btree ON t1( e );
CREATE        INDEX type TYPE  btree ON t1( f );
CREATE        INDEX TYPE  btree ON t1( g );
CREATE        INDEX h_index TYPE  rtree ON t1( h );
CREATE        INDEX i_index             ON t1( i ) KEY_BLOCK_SIZE = 1;
CREATE        INDEX j_index             ON t1( j ) KEY_BLOCK_SIZE = 1 KEY_BLOCK_SIZE = 1;
CREATE        INDEX k_index             ON t1( k ) COMMENT 'A comment';
CREATE        INDEX k_index2            ON t1( k ) COMMENT 'A comment' COMMENT 'Another comment';
CREATE        INDEX l_index             ON t1( l ) USING btree;
CREATE        INDEX m_index             ON t1( m ) TYPE btree;
CREATE        INDEX n_index USING btree ON t1( n ) USING btree;
CREATE        INDEX x_index USING btree ON t1( o ) USING rtree;
CREATE        INDEX o_index USING rtree ON t1( o ) USING btree;

DROP TABLE t1;

CREATE VIEW v1 AS SELECT /*+ QB_NAME(a) */ 1;
ALTER VIEW v1 AS SELECT /*+ QB_NAME(a) */ 1;
SELECT * FROM v1;
DROP VIEW v1;

CREATE VIEW v1 AS SELECT /*+ BAD_HINT */ 1;
ALTER VIEW v1 AS SELECT /*+ BAD_HINT */ 1;
SELECT * FROM v1;
DROP VIEW v1;
CREATE TABLE t1( a INT );
CREATE TABLE t2( a INT );
CREATE TABLE t3( a INT );
CREATE TABLE t4( a INT );
SELECT 1
FROM ( SELECT 1 FROM t1 JOIN t2 ON @@q ) AS d
JOIN t3 LEFT JOIN t4 ON 1;

DROP TABLE t1, t2, t3, t4;
select 2 as expected, /*!01000/**/*/ 2 as result;
select 1 as expected, /*!99998/**/*/ 1 as result;
select 3 as expected, /*!01000 1 + */ 2 as result;
select 2 as expected, /*!99990 1 + */ 2 as result;
select 7 as expected, /*!01000 1 + /* 8 + */ 2 + */ 4 as result;
select 8 as expected, /*!99998 1 + /* 2 + */ 4 + */ 8 as result;
select 7 as expected, /*!01000 1 + /*!01000 8 + */ 2 + */ 4 as result;
select 7 as expected, /*!01000 1 + /*!99998 8 + */ 2 + */ 4 as result;
select 4 as expected, /*!99998 1 + /*!99998 8 + */ 2 + */ 4 as result;
select 4 as expected, /*!99998 1 + /*!01000 8 + */ 2 + */ 4 as result;
select 7 as expected, /*!01000 1 + /*!01000 8 + /*!01000 error */ 16 + */ 2 + */ 4 as result;
select 4 as expected, /* 1 + /*!01000 8 + */ 2 + */ 4;
EOF

--exec $MYSQL --comments --force --table test <$MYSQLTEST_VARDIR/tmp/bug39559.sql
--remove_file $MYSQLTEST_VARDIR/tmp/bug39559.sql

--echo -- Bug#46527 "COMMIT AND CHAIN RELEASE does not make sense"
--echo --
--error ER_PARSE_ERROR
COMMIT AND CHAIN RELEASE;
CREATE TABLE t1 (a INT PRIMARY KEY) PARTITION BY HASH (a) PARTITIONS 1;
ALTER TABLE t1 ADD PARTITION;
DROP TABLE t1;

SET @save_sql_mode=@@sql_mode;
SET sql_mode='IGNORE_SPACE';
CREATE
TABLE;
CREATE
--
--
--
TABLE;

CREATE TEMPORARY TABLE t1(a INT);
DROP TABLE t1;
ALTER TABLE t1 RENAME TO ``.t1;
CREATE TABLE t1 (a INT) PARTITION BY KEY ALGORITHM = 10 () PARTITIONS 3;
ALTER EVENT ev1;
ALTER INSTANCE ROTATE MyISAM MASTER KEY;
CREATE INDEX idx1 ON `` (c1);
ALTER TABLE t1 EXCHANGE PARTITION p0 WITH TABLE `` WITH VALIDATION;
DROP INDEX idx1 ON ``;


SET @@sql_mode=@save_sql_mode;
SELECT 1,,2;
SELECT ,,1;
SELECT ,,,;
CREATE DATABASE db CHARSET DEFAULT;
CREATE DATABASE db COLLATE DEFAULT;
CREATE TABLE t (i INT) CHARSET DEFAULT;
CREATE TABLE t (i INT) COLLATE DEFAULT;
ALTER DATABASE db CHARSET DEFAULT;
ALTER DATABASE db COLLATE DEFAULT;
ALTER TABLE t COLLATE DEFAULT;
SET NAMES utf8mb3 COLLATE DEFAULT;
SET NAMES DEFAULT COLLATE DEFAULT;
CREATE PROCEDURE p1()
BEGIN
  DECLARE c CHAR(1) CHARSET DEFAULT;
CREATE PROCEDURE p1()
BEGIN
  DECLARE c CHAR(1) COLLATE DEFAULT;
CREATE PROCEDURE p1(c CHAR(1) CHARSET DEFAULT) BEGIN END;
CREATE PROCEDURE p1(c CHAR(1) COLLATE DEFAULT) BEGIN END;
CREATE FUNCTION f1(c CHAR(1) CHARSET DEFAULT) RETURNS INT RETURN 1;
CREATE FUNCTION f1(c CHAR(1) COLLATE DEFAULT) RETURNS INT RETURN 1;
CREATE FUNCTION f1() RETURNS CHAR(1) CHARSET DEFAULT RETURN '';
CREATE FUNCTION f1() RETURNS CHAR(1) COLLATE DEFAULT RETURN '';

CREATE TEMPORARY TABLE admin (admin INT);
DROP TABLE admin;

SELECT @@default_collation_for_utf8mb4;

CREATE DATABASE db1 CHARSET cp1251 COLLATE cp1251_general_ci;
USE db1;
CREATE TABLE t1 (i INT) CHARSET utf8mb4;

ALTER TABLE t1 CONVERT TO CHARACTER SET DEFAULT;

ALTER TABLE t1 CONVERT TO CHARACTER SET DEFAULT COLLATE cp1251_bin;

DROP DATABASE db1;

SET @@default_collation_for_utf8mb4 = utf8mb4_general_ci;

CREATE DATABASE db2 COLLATE utf8mb4_0900_ai_ci;
USE db2;

CREATE TABLE t2 (i INT) CHARSET latin1;

ALTER TABLE t2 CONVERT TO CHARACTER SET DEFAULT;
ALTER TABLE t2 CONVERT TO CHARACTER SET latin1;

ALTER TABLE t2 CONVERT TO CHARACTER SET DEFAULT COLLATE utf8mb4_bin;

DROP DATABASE db2;

SET @@default_collation_for_utf8mb4 = DEFAULT;
SELECT @@default_collation_for_utf8mb4;

CREATE DATABASE db3 COLLATE utf8mb4_general_ci;
USE db3;

CREATE TABLE t3 (i INT) CHARSET latin1;

ALTER TABLE t3 CONVERT TO CHARACTER SET DEFAULT;

ALTER TABLE t3 CONVERT TO CHARACTER SET DEFAULT COLLATE utf8mb4_bin;
ALTER TABLE t3 CONVERT TO CHARACTER SET DEFAULT COLLATE cp1251_general_cs;

DROP DATABASE db3;

USE test;

SET parser_max_mem_size = 10000000;
SET parser_max_mem_size = default;
CREATE PROCEDURE p1 () wrong syntax;

-- PERSIST and PERSIST_ONLY are not reserved words any more:

SELECT 1 AS PERSIST, 2 AS PERSIST_ONLY;

-- Negative checks for non-reserved words not allowed as role names:

--error ER_PARSE_ERROR
CREATE ROLE EVENT;
CREATE ROLE FILE;
CREATE ROLE NONE;
CREATE ROLE PROCESS;
CREATE ROLE PROXY;
CREATE ROLE RELOAD;
CREATE ROLE REPLICATION;
CREATE ROLE RESOURCE;
CREATE ROLE SUPER;

-- Negative checks for non-reserved words not allowed as system variable names:

--error ER_PARSE_ERROR
SET GLOBAL = DEFAULT;
SET LOCAL = DEFAULT;
SET PERSIST = DEFAULT;
SET PERSIST_ONLY = DEFAULT;
SET SESSION = DEFAULT;

CREATE FUNCTION f1() RETURNS INT
BEGIN
  ACCOUNT: LOOP RETURN 1;

DROP FUNCTION f1;

CREATE TABLE t1 (i INT);
SELECT * FROM t1=a;
SELECT * FROM (SELECT 1)=a;
SELECT * FROM t1 JOIN t1=a;
UPDATE t1=a SET i=0;
DROP TABLE t1;

CREATE TEMPORARY TABLE t1 (i INT);
CREATE TEMPORARY TABLE t2 (i INT);

SELECT * FROM { OJ t1 LEFT JOIN t2 ON TRUE };
SELECT * FROM { `OJ` t1 LEFT JOIN t2 ON TRUE };
SELECT * FROM { random_identifier t1 LEFT JOIN t2 ON TRUE };

DROP TABLE t1, t2;

-- Even compatible multiple COLLATE clauses should fail:

--error ER_PARSE_ERROR
CREATE TABLE t1 (
  x VARCHAR(10)
  COLLATE ascii_bin
  COLLATE ascii_bin
);

-- Incompatible COLLATE clauses should fail with the same error message:

--error ER_PARSE_ERROR
CREATE TABLE t2 (
  x VARCHAR(10)
  COLLATE ascii_bin
  COLLATE ascii_general_ci
);

-- Multiple COLLATE clauses mixed with other column attributes should fail too:

--error ER_PARSE_ERROR
CREATE TABLE t3 (
  x VARCHAR(10)
  COLLATE ascii_bin
  NOT NULL
  COLLATE ascii_bin
);

-- Multiple COLLATE clauses should fail in gcol definitions (syntax 1):

--error ER_PARSE_ERROR
CREATE TABLE t3 (
  x VARCHAR(10)
  COLLATE ascii_bin
  GENERATED ALWAYS AS(NULL)
  COLLATE ascii_bin
);

-- Multiple COLLATE clauses should fail in gcol definitions (syntax 2):

--error ER_PARSE_ERROR
CREATE TABLE t4 (
  x VARCHAR(10)
  GENERATED ALWAYS AS(NULL)
  COLLATE ascii_bin
  COLLATE ascii_bin
);

CREATE VIEW v1 AS (SELECT 1 ORDER BY 1) UNION (SELECT 3 ORDER BY 1) ORDER BY 1;
DROP VIEW v1;
CREATE TABLE t1(a INTEGER);
CREATE TABLE t2(a INTEGER);
CREATE TABLE t3(a INTEGER, b INTEGER, c INTEGER);
INSERT INTO t3 VALUES(1, 10, 100), (2, 20, 200), (3, 30, 300), (4, 40, 400);

CREATE VIEW v1 as (SELECT a FROM t1 ORDER BY a LIMIT 1) UNION SELECT a FROM t2;

CREATE VIEW v2 as SELECT a FROM t1 UNION (SELECT a FROM t2 ORDER BY a LIMIT 1);
            ORDER BY b DESC LIMIT 2)
                ORDER BY c LIMIT 1;

DROP VIEW v1;
DROP VIEW v2;
DROP TABLE t1, t2, t3;

SET sql_mode=(SELECT CONCAT(@@sql_mode, ',PIPES_AS_CONCAT'));

-- `||` should have higher precedence than `LIKE` and `ESCAPE`:

SELECT 'ab' LIKE 'a%', 'ab' LIKE 'a' || '%';
SELECT 'ab' NOT LIKE 'a%', 'ab' NOT LIKE 'a' || '%';

SELECT 'ab' LIKE 'ac', 'ab' LIKE 'a' || 'c';
SELECT 'ab' NOT LIKE 'ac', 'ab' NOT LIKE 'a' || 'c';

SELECT 'a%' LIKE 'a!%' ESCAPE '!', 'a%' LIKE 'a!' || '%' ESCAPE '!';
SELECT 'a%' NOT LIKE 'a!%' ESCAPE '!', 'a%' NOT LIKE 'a!' || '%' ESCAPE '!';

SELECT 'a%' LIKE 'a!%' ESCAPE '$', 'a%' LIKE 'a!' || '%' ESCAPE '$';
SELECT 'a%' NOT LIKE 'a!%' ESCAPE '$', 'a%' NOT LIKE 'a!' || '%' ESCAPE '$';

SELECT 'a%' LIKE 'a!%' ESCAPE '!', 'a%' LIKE 'a!%' ESCAPE '' || '!';
SELECT 'a%' NOT LIKE 'a!%' ESCAPE '!', 'a%' NOT LIKE 'a!%' ESCAPE '' || '!';

SELECT 'a%' LIKE 'a!%' ESCAPE '' || '$', 'a%' LIKE 'a!%' ESCAPE '' || '$';
SELECT 'a%' NOT LIKE 'a!%' ESCAPE '' || '$', 'a%' NOT LIKE 'a!%' ESCAPE '' || '$';

-- `||` should have a higher precedence than `^`:

SELECT 1 ^ 100, 1 ^ '10' || '0';

-- `||` should have a lower precedence than the unary `-`:

SELECT -1 || '0';

SET sql_mode=DEFAULT;

SELECT 1 UNION SELECT 1 INTO @var;

SELECT 1 UNION SELECT 1 FROM DUAL INTO @var;

SELECT 1 UNION SELECT 1 FROM DUAL FOR UPDATE INTO @var;

SELECT 1 UNION SELECT 1 INTO @var FROM DUAL;
SELECT 1 UNION (SELECT 1 INTO @var FROM DUAL);

SELECT 1 UNION SELECT 1 FROM DUAL INTO @var FOR UPDATE;

SELECT 1 UNION SELECT 1 INTO @var FOR UPDATE;
SELECT 1 UNION (SELECT 1 FROM DUAL INTO @var);

CREATE TABLE t1 (c1 INT, `*` INT, c3 INT);
INSERT INTO t1 VALUES (1, 2, 3);

SELECT `*` FROM t1;
SELECT t1.`*`, t1.* FROM t1;
SELECT test.t1.`*`, test.t1.* FROM t1;

DROP TABLE t1;
SELECT @var;
SELECT @var;
SELECT @var;
SELECT @var;

SET time_zone = '+01:00';
SELECT cast( DATE'2019-10-10' AT LOCAL AS DATETIME );
SELECT cast( DATE'2019-10-10' AT TIME ZONE 'UTC' AS DATETIME );
SELECT cast( TIME'10:10' AT LOCAL AS DATETIME );
SELECT cast( TIME'10:10' AT TIME ZONE '+01:00' AS DATETIME );
SELECT cast( TIME'10:10' AT TIME ZONE INTERVAL 'UTC' AS DATETIME );
SELECT cast( TIME'10:10' AT TIME ZONE '' AS DATETIME );
SELECT cast( TIME'10:10' AT TIME ZONE INTERVAL '' AS DATETIME );
SELECT cast( TIMESTAMP'2019-10-10 10:11:12' AT LOCAL AS DATETIME );

SELECT cast( NULL AT TIME ZONE 'UTC' AS DATETIME );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS BINARY );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS CHAR );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS DATE );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS DECIMAL );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS DOUBLE );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS FLOAT );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS SIGNED INTEGER );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS TIME );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS UNSIGNED INTEGER );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS JSON );
SELECT cast( TIMESTAMP'2019-10-10 10:40:00' AT TIME ZONE 'UTC' AS REAL );

-- The next two statements used to give no error when running with
-- EXPLAIN. Verify that they give the expected error.
--error ER_MULTIPLE_INTO_CLAUSES
EXPLAIN SELECT 1 INTO @x FROM DUAL INTO @y;
CREATE TABLE full(i INT);
DROP TABLE full;
CREATE TABLE `full`(i INT);
SELECT * from `full`;
SELECT * from `full` AS full;
SELECT * from `full` AS `full`;
SELECT * from full;
SELECT * from full as full;
SELECT * from `full` full;
SELECT * from full outer;

SET @save_sql_mode=@@sql_mode;
SET SQL_MODE = 'ANSI_QUOTES';
SELECT * from `full`;
SELECT * from "full";
SELECT * from full;
SET @@sql_mode=@save_sql_mode;

DROP TABLE `full`;
