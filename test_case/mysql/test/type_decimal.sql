select * from t1 where min_value<=1 and max_value>=-1 and datatype_id=16;
select * from t1 where min_value<=-1 and max_value>=-1 and datatype_id=16;
drop table t1;
create table t1 (a decimal(10,2));
insert into t1 values ("0.0"),("-0.0"),("+0.0"),("01.0"),("+01.0"),("-01.0");
insert into t1 values ("-.1"),("+.1"),(".1");
insert into t1 values ("00000000000001"),("+0000000000001"),("-0000000000001");
select * from t1;
drop  table t1;
create table t1 (a decimal(10,2) unsigned);
select * from t1;
drop  table t1;
create table t1 (a decimal(10,2) zerofill);
select * from t1;
drop  table t1;
create table t1 (a decimal(10,2));
insert into t1 values (0.0),("-0.0"),(+0.0),(01.0),(+01.0),(-01.0);
insert into t1 values (-.1),(+.1),(.1);
insert into t1 values (00000000000001),(+0000000000001),(-0000000000001);
insert into t1 values (123.4e0),(123.4e+2),(123.4e-2),(123e1),(123e+0);
insert into t1 values (MID("987",1,2)),("987 "),("987.6e+2 ");
select * from t1;
drop  table t1;
create table t1 (a decimal);
select * from t1;
drop  table t1;
create table t1 (a decimal unsigned);
select * from t1;
drop  table t1;
create table t1 (a decimal zerofill);
select * from t1;
drop  table t1;
create table t1 (a decimal unsigned zerofill);
select * from t1;
drop  table t1;
create table t1(a decimal(10,0));
select * from t1;
delete from t1;
select * from t1;
drop table t1;
create table t1(a decimal(7,3));
select * from t1;
drop table t1;
create table t1(a decimal(7,3) unsigned);
select * from t1;
drop table t1;
create table t1(a decimal(7,3) zerofill);
select * from t1;
drop table t1;
create table t1(a decimal(10,5), b decimal(10,1));
insert into t1 values(123.12345, 123.12345);
update t1 set b=a;
select * from t1;
drop table t1;
CREATE TABLE t1
(EMPNUM   CHAR(3) NOT NULL,
HOURS    DECIMAL(5));
CREATE TABLE t2
(EMPNUM   CHAR(3) NOT NULL,
HOURS    BIGINT);
INSERT INTO t1 VALUES ('E1',40);
INSERT INTO t1 VALUES ('E8',NULL);
INSERT INTO t2 VALUES ('E1',40);
SELECT EMPNUM FROM t1 WHERE HOURS IN (SELECT HOURS FROM t2);
SELECT EMPNUM FROM t1 WHERE HOURS IN (SELECT HOURS FROM t1);
DROP TABLE t1,t2;
create table t1 (d decimal(64,0));
insert into t1 values (1);
select * from t1;
drop table t1;
create table t1 (d decimal(5));
drop table t1;
create table t1 (d decimal);
drop table t1;
CREATE TABLE t1 (i INT, d1 DECIMAL(9,2), d2 DECIMAL(9,2));
INSERT INTO t1 VALUES (1, 101.40, 21.40), (1, -80.00, 0.00),
(2, 0.00, 0.00), (2, -13.20, 0.00), (2, 59.60, 46.40),
(2, 30.40, 30.40), (3, 37.00, 7.40), (3, -29.60, 0.00),
(4, 60.00, 15.40), (4, -10.60, 0.00), (4, -34.00, 0.00),
(5, 33.00, 0.00), (5, -25.80, 0.00), (5, 0.00, 7.20),
(6, 0.00, 0.00), (6, -51.40, 0.00);
SELECT i, SUM(d1) AS a, SUM(d2) AS b FROM t1 GROUP BY i HAVING a <> b;
SELECT i, ROUND(SUM(d1), 2) AS a, ROUND(SUM(d2), 2) AS b FROM t1 GROUP BY i
HAVING a <> b;
drop table t1;
create table t1 (c1 varchar(100), c2 longtext);
insert into t1 set c1= 'non PS, 1.0 as constant', c2=1.0;
prepare stmt from "insert into t1 set c1='PS, 1.0 as constant    ', c2=1.0";
insert into t1 set c1='non PS, 1.0 in parameter', c2=@a;
prepare stmt from "insert into t1 set c1='PS, 1.0 in parameter    ', c2=?";
select * from t1;
deallocate prepare stmt;
drop table t1;
create table t1 (
  strippedproductid char(15) not null default '',
  zlevelprice decimal(10,2) default null,
  primary key (strippedproductid)
);
create table t2 (
  productid char(15) not null default '',
  zlevelprice char(21) default null,
  primary key (productid)
);
insert into t1 values ('002trans','49.99');
insert into t1 values ('003trans','39.98');
insert into t1 values ('004trans','31.18');
insert INTO t2 SELECT * FROM t1;
select * from t2;
drop table t1, t2;
create table t1 (f1 decimal(5));
insert into t1 values (40);
select f1 from t1 where f1 in (select f1 from t1);
drop table t1;
CREATE TABLE t1 (
  qty decimal(16,6) default NULL, 
  dps tinyint(3) unsigned default NULL 
);
INSERT INTO t1 VALUES (1.1325,3);
SELECT ROUND(qty,3), dps, ROUND(qty,dps) FROM t1;
DROP TABLE t1;
create table t1 (c1 decimal(10,6));
insert into t1 (c1) values (9.99e-4);
insert into t1 (c1) values (9.98e-4);
insert into t1 (c1) values (0.000999);
insert into t1 (c1) values (cast(9.99e-4 as decimal(10,6)));
select * from t1;
drop table t1;
SELECT 1 % .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS '%';
SELECT MOD(1, .123456789123456789123456789123456789123456789123456789123456789123456789123456789) AS 'MOD()';
create table t1 (f1 decimal(6,6),f2 decimal(6,6) zerofill);
insert into t1 values (-0.123456,0.123456);
select group_concat(f1),group_concat(f2) from t1;
drop table t1;
create table t1 (
  ua_id decimal(22,0) not null,
  ua_invited_by_id decimal(22,0) default NULL,
  primary key(ua_id)
);
insert into t1 values (123, NULL), (456, NULL);
select * from t1 where ua_invited_by_id not in (select ua_id from t1);
drop table t1;
DROP TABLE IF EXISTS t3;
DROP TABLE IF EXISTS t4;
CREATE TABLE t1( a NUMERIC, b INT );
INSERT INTO t1 VALUES (123456, 40), (123456, 40);
SELECT TRUNCATE( a, b ) AS c FROM t1 ORDER BY c;
SELECT ROUND( a, b ) AS c FROM t1 ORDER BY c;
SELECT ROUND( a, 100 ) AS c FROM t1 ORDER BY c;
CREATE TABLE t2( a NUMERIC, b INT );
INSERT INTO t2 VALUES (123456, 100);
SELECT TRUNCATE( a, b ) AS c FROM t2 ORDER BY c;
SELECT ROUND( a, b ) AS c FROM t2 ORDER BY c;
CREATE TABLE t3( a DECIMAL, b INT );
INSERT INTO t3 VALUES (123456, 40), (123456, 40);
SELECT TRUNCATE( a, b ) AS c FROM t3 ORDER BY c;
SELECT ROUND( a, b ) AS c FROM t3 ORDER BY c;
SELECT ROUND( a, 100 ) AS c FROM t3 ORDER BY c;
CREATE TABLE t4( a DECIMAL, b INT );
INSERT INTO t4 VALUES (123456, 40), (123456, 40);
SELECT TRUNCATE( a, b ) AS c FROM t4 ORDER BY c;
SELECT ROUND( a, b ) AS c FROM t4 ORDER BY c;
SELECT ROUND( a, 100 ) AS c FROM t4 ORDER BY c;
delete from t1;
INSERT INTO t1 VALUES (1234567890, 20), (999.99, 5);
select round(a,b) as c from t1 order by c;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1( a DECIMAL(4, 3), b INT );
INSERT INTO t1 VALUES ( 1, 5 ), ( 2, 4 ), ( 3, 3 ), ( 4, 2 ), ( 5, 1 );
SELECT a, b, ROUND( a, b ) AS c FROM t1 ORDER BY c;
SELECT a, b, ROUND( a, b ) AS c FROM t1 ORDER BY c DESC;
CREATE TABLE t2 ( a INT, b INT, c DECIMAL(5, 4) );
INSERT INTO t2 VALUES ( 0, 1, 1.2345 ), ( 1, 2, 1.2345 ),
                      ( 3, 3, 1.2345 ), ( 2, 4, 1.2345 );
SELECT a, b, MAX(ROUND(c, a)) 
FROM t2 
GROUP BY a, b 
ORDER BY b;
CREATE TABLE t3( a INT, b DECIMAL(6, 3) );
INSERT INTO t3 VALUES( 0, 1.5 );
CREATE TABLE t4( a INT, b DECIMAL( 12, 0) );
INSERT INTO t4 VALUES( -9, 1.5e9 );
CREATE TABLE t5( a INT, b DECIMAL( 13, 12 ) );
INSERT INTO t5 VALUES( 0, 1.5 );
INSERT INTO t5 VALUES( 9, 1.5e-9 );
CREATE TABLE t6( a INT );
INSERT INTO t6 VALUES( 6 / 8 );
SELECT * FROM t6;
DROP TABLE t1, t2, t3, t4, t5, t6;
create table t1(`c` decimal(9,2));
insert into t1 values (300),(201.11);
select max(case 1 when 1 then c else null end) from t1 group by c;
drop table t1;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (NULL);
CREATE TABLE t2 (b INTEGER);
INSERT INTO t2 VALUES (NULL), (NULL);
SELECT b FROM t1 JOIN t2 WHERE CONVERT(a, DECIMAL)|CONVERT(b, DECIMAL);
DROP TABLE t1, t2;
CREATE TABLE t1 (col0 INTEGER, col1 REAL);
CREATE TABLE t2 (col0 INTEGER);
INSERT INTO t1 VALUES (0, 0.0), (NULL, NULL);
INSERT INTO t2 VALUES (1);
SELECT 1 FROM t1 
JOIN
( 
  SELECT t2.col0 FROM t2 RIGHT JOIN t1 USING(col0) 
  GROUP BY t2.col0
) AS subq  
WHERE t1.col1 + CAST(subq.col0 AS DECIMAL);
SELECT 1 FROM t1 
JOIN
( 
  SELECT t2.col0 FROM t2 RIGHT JOIN t1 USING(col0) 
  GROUP BY t2.col0
) AS subq  
WHERE CONCAT(t1.col1, CAST(subq.col0 AS DECIMAL));
DROP TABLE t1, t2;
SELECT CAST(9.9 AS SIGNED INTEGER) AS f;
SELECT 1 < ALL(VALUES ROW(2),ROW(CAST(3 AS DECIMAL))) FROM DUAL;
SELECT 1 < ALL(VALUES ROW(2),ROW(3.0)) FROM DUAL;
