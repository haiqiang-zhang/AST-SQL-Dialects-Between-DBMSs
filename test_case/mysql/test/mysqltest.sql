select otto from (select 1 as otto) as t1;
select otto from (select 1 as otto) as t1;
select otto from (select 1 as otto) as t1;
select otto from (select 1 as otto) as t1;
drop table if exists t1;
drop table if exists t1;
create table t1 ( f1 char(10));
prepare stmt from "select 3 from t1";
drop table t1;
deallocate prepare stmt;
select 2;
select 3;
select 5;
select 7;
select "CASE" as "LOWER";
select "xyz" as name union select "abc" as name order by name desc;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
create table t1 (a varchar(100)) charset utf8mb4;
insert into t1 values ('`select 42`');
insert into t1 values ('$dollar');
drop table t1;
SELECT 'In loop' AS "";
select "a" as col1, "c" as col2;
select "a" as col1, "c" as col2;
select "a" as col1, "c" as col2;
select "a" as col1, "c" as col2;
SELECT 1 as a;
select 1 as `a'b`, 2 as `a"b`;
select 'aaa\\','aa''a',"aa""a";
select "at" as col1, "c" as col2;
select "at" as col1, "AT" as col2, "c" as col3;
select "a" as col1, "ct" as col2;
select "strawberry","blueberry","potato";
create table t1 (a int, b int);
insert into t1 values (1,3);
insert into t1 values (2,4);
select * from t1;
drop table t1;
select "a is a and less is more" as txt;
select "a is a and less is more" as txt;
create table t2 ( a char(10));
drop table t2;
create table t1 ( f1 char(10));
insert into t1 values ("Abcd");
select * from t1;
select 1;
drop table t1;
create table t1( a int, b char(255), c timestamp);
insert into t1 values(1, 'Line 1', '2007-04-05'), (2, "Part 2", '2007-04-05');
insert into t1 values(1, 'Line 1', '2007-04-05'), (2, "Part 3", '2007-04-05');
select * from t1;
select * from t1;
select * from t1;
select * from t1;
select '';
select "h";
select "he";
select "hep";
select "hepp";
drop table t1;
SELECT 2 as "my_col"
UNION
SELECT 1;
SELECT 2 as "my_col" UNION SELECT 1;
SELECT 2 as "my_col"
UNION
SELECT 1;
SELECT '2' as "3"
UNION
SELECT '1';
CREATE TABLE t1( a CHAR);
SELECT * FROM t1;
DROP TABLE t1;
SELECT NULL as "my_col1",2 AS "my_col2"
UNION
SELECT NULL,1;
SELECT NULL as "my_col1",2 AS "my_col2"
UNION
SELECT NULL,1;
SELECT 2 as "my_col1",NULL AS "my_col2"
UNION
SELECT 1,NULL;
SELECT 2 as "my_col1",NULL AS "my_col2"
UNION
SELECT 1,NULL;
SELECT 2 as "my_col"
UNION
SELECT 1;
SELECT 1;
SELECT '1' as "my_col1",2 as "my_col2"
UNION
SELECT '2',1;
CREATE TABLE t1 (f1 INT);
INSERT INTO t1 SET f1 = 1024;
INSERT INTO t1 SELECT f1 - 1 FROM t1;
INSERT INTO t1 SELECT f1 - 2 FROM t1;
INSERT INTO t1 SELECT f1 - 4 FROM t1;
INSERT INTO t1 SELECT f1 - 8 FROM t1;
INSERT INTO t1 SELECT f1 - 16 FROM t1;
INSERT INTO t1 SELECT f1 - 32 FROM t1;
INSERT INTO t1 SELECT f1 - 64 FROM t1;
INSERT INTO t1 SELECT f1 - 128 FROM t1;
INSERT INTO t1 SELECT f1 - 256 FROM t1;
INSERT INTO t1 SELECT f1 - 512 FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a BINARY(32), b BINARY(32));
INSERT INTO t1 VALUES
('1abc', 'abc2'), ('\0', '\0'), ('1a', 'ba');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a CHAR(32), b CHAR(32));
INSERT INTO t1 VALUES
('\0', 'abc2'), ('abcd', '\0'), ('1a', 'ba');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a CHAR(32), b CHAR(32), c CHAR(32));
INSERT INTO t1 VALUES
('abc', '1a', '2a'), ('abc', 'west', 'east'), ('\0', '1a', 'north'),
('\0', 'west', 'south'), ('abc', 'sun', 'moon');
SELECT a, b, c FROM t1 ORDER by a;
SELECT a, b, c FROM t1 ORDER by a, b;
DROP TABLE t1;
CREATE TABLE t1(i INT, j INT, k INT);
INSERT INTO t1 VALUES
(1, 2, 1),
(1, 2, 4),
(1, 2, 3),
(2, 3, 1),
(3, 4, 1),
(2, 5, 0),
(1, 6, 0),
(1, 7, 1);
SELECT i, j, k FROM t1 ORDER by i;
SELECT i, j, k FROM t1 ORDER by i, j;
DROP TABLE t1;
SELECT "500g BLÃÂÃÂBÃÂÃÂRSYLTETÃÂÃÂY" AS "WILL BE lower cased";
SELECT "UPPER" AS "WILL NOT BE lower cased";
SELECT 0 as "UP AGAIN";
SELECT "Xyz" AS Name UNION SELECT "Abc" as Name ORDER BY Name DESC;
SELECT 1 as "SOME OLD TEXT";
SELECT 0 as "WILL Lower CASE ÃÂ";
CREATE TABLE t1(
 a int, b varchar(255), c datetime
);
drop table t1;
SELECT "bla bla file" as x;
SELECT 'c:\\a.txt' AS col;
select 1;
select "a" as a;
select "a" as a;
select "a" as a;
SELECT 100 + /* Shouldn't fail */ 1 AS result;
SELECT 100 /* Shouldn't fail */ + 1 AS result;
SELECT 100 +
/*
Shouldn't
fail
*/
1 AS result;
SELECT 100
/*
Shouldn't
fail
*/
+ 1 AS result;
SELECT 100 /* shouldn't / fail */ + 1 AS result;
SELECT 100 /* shouldn't * fail */ + 1 AS result;
SELECT 100 /* shouldn't /* fail */ + 1 AS result;
SELECT 100 /* shouldn't /* fail */ + 1 AS res1, 'ABC' AS res2;
SELECT 100 + /* "shouldnt fail */ 1 AS result;
SELECT 100 + /* "shouldn't fail" */ 1 AS result;
SELECT 100 + /* `shouldn't fail */ 1 AS result;
SELECT 100 + /* `shouldn't fail` */ 1 AS result;
SELECT 100 + /*  + shouldn't fail */ 1 AS result;
SELECT 100 + /*  ! shouldn't fail */ 1 AS result;
SELECT 1 /*!,"\'" */;
SELECT 100 + /***/ 1 AS result;
SELECT 100 + /**'*/ 1 AS result;
SELECT 100 + /*/*/ 1 AS result;
SELECT 100 + /*/'*/ 1 AS result;
CREATE TABLE t1(a INT PRIMARY KEY);
INSERT INTO t1 values (1),(5),(10) /* doesn't throw error */;
SELECT * FROM t1 /* shouldn't throw error */;
DROP TABLE t1;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO;
CREATE /*! TEMPORARY */ TABLE t1 /* shouldn't fail */ (a INT) CHARSET utf8mb4;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.INNODB_TEMP_TABLE_INFO;
DROP TEMPORARY TABLE t1;
SELECT 1 AS res;
SELECT 1 AS res;
SELECT 100 AS res;
SELECT 100 AS res;
SELECT 100;
SELECT 100;
SELECT 100;
SELECT 100;
SELECT 100;
CREATE TABLE t1(f FLOAT, k DOUBLE);
INSERT INTO t1 VALUES(124.7892,1.23456e200);
INSERT INTO t1 VALUES(6.9999999,1.000000000);
INSERT INTO t1 VALUES(12900.019,37489e-12);
SELECT * FROM t1;
DROP TABLE t1;
SELECT 'aaaa(12.123484502750487)';
SELECT 19.955934879;
CREATE TABLE t1(c1 INT);
DROP TABLE t1;
CREATE TABLE t1(c1 INT);
DROP TABLE t1;
SELECT "this will not be executed" AS not_executed;
SELECT "this will be executed" AS executed;
SELECT "this will not be executed" AS not_executed;
SELECT "this will be executed" AS executed;
SELECT "this will not be executed" AS not_executed;
SELECT "this will be executed" AS executed;
SELECT 1 AS res;
SELECT 1 AS res;
SELECT 1 AS res;
SELECT 1 AS res;
SELECT 1 AS res;
SELECT 1 AS res;
SELECT 1 AS res;
CREATE TABLE t1 (
  c1 DOUBLE NOT NULL AUTO_INCREMENT,
  c2 INT,
  c3 DECIMAL(2) UNSIGNED,
  c4 DECIMAL,
  PRIMARY KEY (c1)
);
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (
  c1 DOUBLE NOT NULL AUTO_INCREMENT,
  c2 INT,
  c3 DECIMAL(2) UNSIGNED,
  c4 DECIMAL,
  PRIMARY KEY (c1)
);
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DELETE FROM t1;
DROP TABLE t1;
SELECT 'b-','ab';
SELECT "$,*,." as escape_chars;
SELECT "(";
SELECT "[";
SELECT 0x00, 0xff;
SELECT 0x00, 0xff;
SELECT 0x00;
SELECT "[ MY-012345 ]" as err;
SELECT CONCAT('winpath','\\');
SELECT "mtr";
SELECT "mtr";
SELECT "mtr";
SELECT "mtr";
SELECT "abc", "abd";
SELECT "abc", "abd";
SELECT "many words form a sentence" as text;
SELECT "many words form a sentence" as text;
SELECT "absolute", "accent";
SELECT 1 as num, "abc" as lc, "ABC" as uc;
SELECT 'a' as letter, 0x00 as nullchar, 0xff as nonprintable;
CREATE TABLE t1(col1 INT, col2 INT, col3 INT);
CREATE TABLE t2(col1 INT, col2 INT, col3 INT);
DROP TABLE t1, t2;
SELECT "abc 456.27" as c1;
SELECT "abc 456.27" as c1;
CREATE TABLE t1 (i int primary key not null);
INSERT INTO t1 values(3);
DROP TABLE t1;
