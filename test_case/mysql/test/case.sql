select CASE "b" when "a" then 1 when "b" then 2 END;
select CASE "c" when "a" then 1 when "b" then 2 END;
select CASE "c" when "a" then 1 when "b" then 2 ELSE 3 END;
select CASE BINARY "b" when "a" then 1 when "B" then 2 WHEN "b" then "ok" END;
select CASE "b" when "a" then 1 when binary "B" then 2 WHEN "b" then "ok" END;
select CASE concat("a","b") when concat("ab","") then "a" when "b" then "b" end;
select CASE when 1=0 then "true" else "false" END;
select CASE 1 when 1 then "one" WHEN 2 then "two" ELSE "more" END;
select CASE 2.0 when 1 then "one" WHEN 2.0 then "two" ELSE "more" END;
select (CASE "two" when "one" then "1" WHEN "two" then "2" END) | 0;
select (CASE "two" when "one" then 1.00 WHEN "two" then 2.00 END) +0.0;
select case 1/0 when "a" then "true" else "false" END;
select case 1/0 when "a" then "true" END;
select (case 1/0 when "a" then "true" END) | 0;
select (case 1/0 when "a" then "true" END) + 0.0;
select case when 1>0 then "TRUE" else "FALSE" END;
select case when 1<0 then "TRUE" else "FALSE" END;
create table t1 (a int);
insert into t1 values(1),(2),(3),(4);
select case a when 1 then 2 when 2 then 3 else 0 end as fcase, count(*) from t1 group by fcase;
drop table t1;
create table t1 (`row` int not null, col int not null, val varchar(255) not null);
insert into t1 values (1,1,'orange'),(1,2,'large'),(2,1,'yellow'),(2,2,'medium'),(3,1,'green'),(3,2,'small');
select max(case col when 1 then val else null end) as color from t1 group by `row`;
drop table t1;
CREATE TABLE t1 SELECT 
 CASE WHEN 1 THEN _latin1'a' COLLATE latin1_danish_ci ELSE _latin1'a' END AS c1,
 CASE WHEN 1 THEN _latin1'a' ELSE _latin1'a' COLLATE latin1_danish_ci END AS c2,
 CASE WHEN 1 THEN 'a' ELSE  1  END AS c3,
 CASE WHEN 1 THEN  1  ELSE 'a' END AS c4,
 CASE WHEN 1 THEN 'a' ELSE 1.0 END AS c5,
 CASE WHEN 1 THEN 1.0 ELSE 'a' END AS c6,
 CASE WHEN 1 THEN  1  ELSE 1.0 END AS c7,
 CASE WHEN 1 THEN 1.0 ELSE  1  END AS c8,
 CASE WHEN 1 THEN 1.0 END AS c9,
 CASE WHEN 1 THEN 0.1e1 else 0.1 END AS c10,
 CASE WHEN 1 THEN 0.1e1 else 1 END AS c11,
 CASE WHEN 1 THEN 0.1e1 else '1' END AS c12;
DROP TABLE t1;
SELECT 
CASE _latin1'a' COLLATE latin1_general_ci  WHEN _latin1'A' THEN '1' ELSE 2 END,
CASE _latin1'a' COLLATE latin1_bin         WHEN _latin1'A' THEN '1' ELSE 2 END,
CASE _latin1'a' WHEN _latin1'A' COLLATE latin1_swedish_ci THEN '1' ELSE 2 END,
CASE _latin1'a' WHEN _latin1'A' COLLATE latin1_bin        THEN '1' ELSE 2 END;
SELECT 'case+union+test'
UNION 
SELECT CASE LOWER('1') WHEN LOWER('2') THEN 'BUG' ELSE 'nobug' END;
SELECT CASE LOWER('1') WHEN LOWER('2') THEN 'BUG' ELSE 'nobug' END;
SELECT 'case+union+test'
UNION 
SELECT CASE '1' WHEN '2' THEN 'BUG' ELSE 'nobug' END;
create table t1(a float, b int default 3);
insert into t1 (a) values (2), (11), (8);
select min(a), min(case when 1=1 then a else NULL end),
  min(case when 1!=1 then NULL else a end) 
from t1 where b=3 group by b;
drop table t1;
CREATE TABLE t1 (EMPNUM INT);
INSERT INTO t1 VALUES (0), (2);
CREATE TABLE t2 (EMPNUM DECIMAL (4, 2));
INSERT INTO t2 VALUES (0.0), (9.0);
SELECT COALESCE(t2.EMPNUM,t1.EMPNUM) AS CEMPNUM,
               t1.EMPNUM AS EMPMUM1, t2.EMPNUM AS EMPNUM2
  FROM t1 LEFT JOIN t2 ON t1.EMPNUM=t2.EMPNUM;
SELECT IFNULL(t2.EMPNUM,t1.EMPNUM) AS CEMPNUM,
               t1.EMPNUM AS EMPMUM1, t2.EMPNUM AS EMPNUM2
  FROM t1 LEFT JOIN t2 ON t1.EMPNUM=t2.EMPNUM;
DROP TABLE t1,t2;
create table t1 (a int, b bigint unsigned);
create table t2 (c int);
insert into t1 (a, b) values (1,4572794622775114594), (2,18196094287899841997),
  (3,11120436154190595086);
insert into t2 (c) values (1), (2), (3);
select t1.a, (case t1.a when 0 then 0 else t1.b end) d from t1 
  join t2 on t1.a=t2.c order by d;
select t1.a, (case t1.a when 0 then 0 else t1.b end) d from t1 
  join t2 on t1.a=t2.c where b=11120436154190595086 order by d;
drop table t1, t2;
CREATE TABLE t1(a YEAR);
SELECT 1 FROM t1 WHERE a=1 AND CASE 1 WHEN a THEN 1 ELSE 1 END;
DROP TABLE t1;
CREATE TABLE source(bt INTEGER, bf INTEGER, i8u BIGINT UNSIGNED, i8s BIGINT);
INSERT INTO source VALUES
(1,0,0,-9223372036854775808), (1,0,18446744073709551615,9223372036854775807);
CREATE TABLE target
SELECT IF(bt,i8u,i8s) AS u, IF(bf,i8u,i8s) AS s
FROM source;
SELECT IF(bt,i8u,i8s) AS u, IF(bf,i8u,i8s) AS s
FROM source;
SELECT * FROM target;
DROP TABLE target;
CREATE TABLE target
SELECT CASE WHEN bt THEN i8u ELSE i8s END AS u,
       CASE WHEN bf THEN i8u ELSE i8s END AS s
FROM source;
SELECT CASE WHEN bt THEN i8u ELSE i8s END AS u,
       CASE WHEN bf THEN i8u ELSE i8s END AS s
FROM source;
SELECT * FROM target;
DROP TABLE target;
CREATE TABLE target
SELECT CASE bt WHEN TRUE THEN i8u WHEN FALSE THEN i8s END AS u,
       CASE bf WHEN TRUE THEN i8u WHEN FALSE THEN i8s END AS s
FROM source;
SELECT CASE bt WHEN TRUE THEN i8u WHEN FALSE THEN i8s END AS u,
       CASE bf WHEN TRUE THEN i8u WHEN FALSE THEN i8s END AS s
FROM source;
SELECT * FROM target;
DROP TABLE target;
CREATE TABLE target
SELECT COALESCE(i8u, i8s) AS u, COALESCE(i8s, i8u) AS s
FROM source;
SELECT COALESCE(i8u, i8s) AS u, COALESCE(i8s, i8u) AS s
FROM source;
SELECT * FROM target;
DROP TABLE source, target;
CREATE TABLE t (a bit(5));
INSERT INTO t VALUES
 (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),
 (10),(11),(12),(19),(20),(21),(29),(30),(31);
SELECT HEX(a),
       IFNULL(a,a) AS b,
       IFNULL(a,a)+0 AS c,
       IFNULL(a+0,a+0) AS d,
       IFNULL(a+0,a) AS e,
       IFNULL(a,a+0) AS f
FROM t;
CREATE TABLE t00(a INTEGER);
INSERT INTO t00 VALUES (1),(2);
CREATE TABLE t01(a INTEGER);
INSERT INTO t01 VALUES (1);
CREATE VIEW v0 AS
SELECT t00.a, t01.a AS b, IFNULL(t01.a, 666) AS c
FROM t00 LEFT JOIN t01 USING(a);
SELECT * FROM v0
WHERE c >= 0;
DROP TABLE t00, t01;
DROP TABLE t;
CREATE TABLE t1 (dt2 DATETIME(2), t3 TIME(3), d DATE);
INSERT INTO t1 VALUES ('2001-01-01 00:00:00.12', '00:00:00.567', '2002-01-01');
SELECT CONCAT(IFNULL(t3, d)) AS col1 FROM t1;
SELECT CONCAT(IFNULL(t3, d)) AS col1 FROM t1 GROUP BY col1;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(110));
INSERT INTO t1 VALUES (REPEAT("a",100));
SELECT (t1.a,t1.a) IN (('a','c'),('a','b')) END FROM t1;
SELECT CASE t1.a WHEN 'a' THEN 'c' ELSE 'd' END FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (col_int int, col_double double, j json);
INSERT INTO t1 VALUES (382218415, -36452.389, '{"key1": 220655528}');
DROP TABLE t1;
