select 1.1 IN (1.0, 1.2);
select 1.1 IN (1.0, 1.2, 1.1, 1.4, 0.5);
select 1.1 IN (1.0, 1.2, NULL, 1.4, 0.5);
select 0.5 IN (1.0, 1.2, NULL, 1.4, 0.5);
select 1 IN (1.11, 1.2, 1.1, 1.4, 1, 0.5);
select 1 IN (1.11, 1.2, 1.1, 1.4, NULL, 0.5);
select case 1.0 when 0.1 then "a" when 1.0 then "b" else "c" END;
select case 0.1 when 0.1 then "a" when 1.0 then "b" else "c" END;
select case 1 when 0.1 then "a" when 1.0 then "b" else "c" END;
select case 1.0 when 0.1 then "a" when 1 then "b" else "c" END;
select case 1.001 when 0.1 then "a" when 1 then "b" else "c" END;
create table t1 (a decimal(6,3));
insert into t1 values (1.0), (NULL), (0.1);
select * from t1;
select 0.1 in (1.0, 1.2, 1.1, a, 1.4, 0.5) from t1;
drop table t1;
create table t1 select if(1, 1.1, 1.2), if(0, 1.1, 1.2), if(0.1, 1.1, 1.2), if(0, 1, 1.1), if(0, NULL, 1.2), if(1, 0.22e1, 1.1), if(1E0, 1.1, 1.2);
select * from t1;
drop table t1;
create table t1 select nullif(1.1, 1.1), nullif(1.1, 1.2), nullif(1.1, 0.11e1), nullif(1.0, 1), nullif(1, 1.0), nullif(1, 1.1);
select * from t1;
drop table t1;
create table t1 (a decimal(4,2));
select a from t1;
drop table t1;
create table t1 (a decimal(4,2) unsigned);
select a from t1;
drop table t1;
create table t1 (a bigint);
select * from t1;
drop table t1;
create table t1 (a bigint unsigned);
insert into t1 values (18446744073709551615.0);
insert into t1 values (9223372036854775808.0);
select * from t1;
drop table t1;
create table t1 (a tinyint);
select * from t1;
drop table t1;
create table t1 select round(15.4,-1), truncate(-5678.123451,-3), abs(-1.1), -(-1.1);
drop table t1;
select 1e10/0e0;
create table wl1612 (col1 int, col2 decimal(38,10), col3 numeric(38,10));
insert into wl1612 values(1,12345678901234567890.1234567890,12345678901234567890.1234567890);
select * from wl1612;
insert into wl1612 values(2,01234567890123456789.0123456789,01234567890123456789.0123456789);
select * from wl1612 where col1=2;
insert into wl1612 values(3,1234567890123456789012345678.0123456789,1234567890123456789012345678.0123456789);
select * from wl1612 where col1=3;
select col1/0 from wl1612;
select col2/0 from wl1612;
select col3/0 from wl1612;
insert into wl1612 values(5,5000.0005,5000.0005);
insert into wl1612 values(6,5000.0005,5000.0005);
select sum(col2),sum(col3) from wl1612;
insert into wl1612 values(7,500000.000005,500000.000005);
insert into wl1612 values(8,500000.000005,500000.000005);
select sum(col2),sum(col3) from wl1612 where col1>4;
insert into wl1612 (col1, col2) values(9,1.01234567891);
insert into wl1612 (col1, col2) values(10,1.01234567894);
insert into wl1612 (col1, col2) values(11,1.01234567895);
insert into wl1612 (col1, col2) values(12,1.01234567896);
select col1,col2 from wl1612 where col1>8;
insert into wl1612 (col1, col3) values(13,1.01234567891);
insert into wl1612 (col1, col3) values(14,1.01234567894);
insert into wl1612 (col1, col3) values(15,1.01234567895);
insert into wl1612 (col1, col3) values(16,1.01234567896);
select col1,col3 from wl1612 where col1>12;
select col1 from wl1612 where col1>4 and col2=1.01234567891;
select col1 from wl1612 where col1>4 and col2=1.0123456789;
select col1 from wl1612 where col1>4 and col2<>1.0123456789;
select col1 from wl1612 where col1>4 and col2<1.0123456789;
select col1 from wl1612 where col1>4 and col2<=1.0123456789;
select col1 from wl1612 where col1>4 and col2>1.0123456789;
select col1 from wl1612 where col1>4 and col2>=1.0123456789;
select col1 from wl1612 where col1>4 and col2=1.012345679;
select col1 from wl1612 where col1>4 and col2<>1.012345679;
select col1 from wl1612 where col1>4 and col3=1.01234567891;
select col1 from wl1612 where col1>4 and col3=1.0123456789;
select col1 from wl1612 where col1>4 and col3<>1.0123456789;
select col1 from wl1612 where col1>4 and col3<1.0123456789;
select col1 from wl1612 where col1>4 and col3<=1.0123456789;
select col1 from wl1612 where col1>4 and col3>1.0123456789;
select col1 from wl1612 where col1>4 and col3>=1.0123456789;
select col1 from wl1612 where col1>4 and col3=1.012345679;
select col1 from wl1612 where col1>4 and col3<>1.012345679;
drop table wl1612;
select 1/3;
select 0.8=0.7+0.1;
select 0.7+0.1;
create table wl1612_1 (col1 int);
insert into wl1612_1 values(10);
select * from wl1612_1 where 0.8=0.7+0.1;
select 0.07+0.07 from wl1612_1;
select 0.07-0.07 from wl1612_1;
select 0.07*0.07 from wl1612_1;
select 0.07/0.07 from wl1612_1;
drop table wl1612_1;
create table wl1612_2 (col1 decimal(10,2), col2 numeric(10,2));
insert into wl1612_2 values(1,1);
insert into wl1612_2 values(+1,+1);
insert into wl1612_2 values(+01,+01);
insert into wl1612_2 values(+001,+001);
select col1,count(*) from wl1612_2 group by col1;
select col2,count(*) from wl1612_2 group by col2;
drop table wl1612_2;
create table wl1612_3 (col1 decimal(10,2), col2 numeric(10,2));
insert into wl1612_3 values('1','1');
insert into wl1612_3 values('+1','+1');
insert into wl1612_3 values('+01','+01');
insert into wl1612_3 values('+001','+001');
select col1,count(*) from wl1612_3 group by col1;
select col2,count(*) from wl1612_3 group by col2;
drop table wl1612_3;
select mod(234,10);
select mod(234.567,10.555);
select mod(-234.567,10.555);
select mod(234.567,-10.555);
select round(15.1);
select round(15.4);
select round(15.5);
select round(15.6);
select round(15.9);
select round(-15.1);
select round(-15.4);
select round(-15.5);
select round(-15.6);
select round(-15.9);
select round(15.1,1);
select round(15.4,1);
select round(15.5,1);
select round(15.6,1);
select round(15.9,1);
select round(-15.1,1);
select round(-15.4,1);
select round(-15.5,1);
select round(-15.6,1);
select round(-15.9,1);
select round(15.1,0);
select round(15.4,0);
select round(15.5,0);
select round(15.6,0);
select round(15.9,0);
select round(-15.1,0);
select round(-15.4,0);
select round(-15.5,0);
select round(-15.6,0);
select round(-15.9,0);
select round(15.1,-1);
select round(15.4,-1);
select round(15.5,-1);
select round(15.6,-1);
select round(15.9,-1);
select round(-15.1,-1);
select round(-15.4,-1);
select round(-15.5,-1);
select round(-15.6,-1);
select round(-15.91,-1);
select truncate(5678.123451,0);
select truncate(5678.123451,1);
select truncate(5678.123451,2);
select truncate(5678.123451,3);
select truncate(5678.123451,4);
select truncate(5678.123451,5);
select truncate(5678.123451,6);
select truncate(5678.123451,-1);
select truncate(5678.123451,-2);
select truncate(5678.123451,-3);
select truncate(5678.123451,-4);
select truncate(-5678.123451,0);
select truncate(-5678.123451,1);
select truncate(-5678.123451,2);
select truncate(-5678.123451,3);
select truncate(-5678.123451,4);
select truncate(-5678.123451,5);
select truncate(-5678.123451,6);
select truncate(-5678.123451,-1);
select truncate(-5678.123451,-2);
select truncate(-5678.123451,-3);
select truncate(-5678.123451,-4);
create table wl1612_4 (col1 int, col2 decimal(30,25), col3 numeric(30,25));
insert into wl1612_4 values(1,0.0123456789012345678912345,0.0123456789012345678912345);
select col2/9999999999 from wl1612_4 where col1=1;
select col3/9999999999 from wl1612_4 where col1=1;
select 9999999999/col2 from wl1612_4 where col1=1;
select 9999999999/col3 from wl1612_4 where col1=1;
select col2*9999999999 from wl1612_4 where col1=1;
select col3*9999999999 from wl1612_4 where col1=1;
insert into wl1612_4 values(2,55555.0123456789012345678912345,55555.0123456789012345678912345);
select col2/9999999999 from wl1612_4 where col1=2;
select col3/9999999999 from wl1612_4 where col1=2;
select 9999999999/col2 from wl1612_4 where col1=2;
select 9999999999/col3 from wl1612_4 where col1=2;
select col2*9999999999 from wl1612_4 where col1=2;
select col3*9999999999 from wl1612_4 where col1=2;
drop table wl1612_4;
select 23.4 + (-41.7), 23.4 - (41.7) = -18.3;
select -18.3=-18.3;
select 18.3=18.3;
select -18.3=18.3;
select 0.8 = 0.7 + 0.1;
drop table if exists t1;
create table t1 (col1 decimal(38));
insert into t1 values (12345678901234567890123456789012345678);
select * from t1;
drop table t1;
create table t1 (col1 decimal(31,30));
insert into t1 values (0.00000000001);
select * from t1;
drop table t1;
select 7777777777777777777777777777777777777 * 10;
select .7777777777777777777777777777777777777 *
       1000000000000000000;
select .7777777777777777777777777777777777777 - 0.1;
select .343434343434343434 + .343434343434343434;
select abs(9999999999999999999999);
select abs(-9999999999999999999999);
select ceiling(999999999999999999);
select ceiling(99999999999999999999);
select ceiling(9.9999999999999999999);
select ceiling(-9.9999999999999999999);
select floor(999999999999999999);
select floor(9999999999999999999999);
select floor(9.999999999999999999999);
select floor(-9.999999999999999999999);
select floor(-999999999999999999999.999);
select ceiling(999999999999999999999.999);
select 99999999999999999999999999999999999999 mod 3;
select round(99999999999999999.999);
select round(-99999999999999999.999);
select round(99999999999999999.999,3);
select round(-99999999999999999.999,3);
select truncate(99999999999999999999999999999999999999,31);
select truncate(99.999999999999999999999999999999999999,31);
select truncate(99999999999999999999999999999999999999,-31);
create table t1 as select 0.5;
drop table t1;
select round(1.5),round(2.5);
select 0.07 * 0.07;
select 1E-500 = 0;
select 1 / 1E-500;
select 1 / 0;
CREATE TABLE Sow6_2f (col1 NUMERIC(4,2));
INSERT INTO Sow6_2f VALUES (10.55);
INSERT INTO Sow6_2f VALUES (10.5555);
INSERT INTO Sow6_2f VALUES (-10.55);
INSERT INTO Sow6_2f VALUES (-10.5555);
INSERT INTO Sow6_2f VALUES (11);
SELECT MOD(col1,0) FROM Sow6_2f;
drop table Sow6_2f;
select 10.3330000000000/12.34500000;
select 0/0;
select 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 as x;
select 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 + 1 as x;
select 0.190287977636363637 + 0.040372670 * 0 -  0;
select -0.123 * 0;
CREATE TABLE t1 (f1 DECIMAL (12,9), f2 DECIMAL(2,2));
INSERT INTO t1 VALUES (10.5, 0);
UPDATE t1 SET f1 = 4.5;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (f1 DECIMAL (64,20), f2 DECIMAL(2,2));
INSERT INTO t1 VALUES (9999999999999999999999999999999999, 0);
SELECT * FROM t1;
DROP TABLE t1;
select abs(10/0);
select abs(NULL);
create table t1( d1 decimal(18) unsigned, d2 decimal(20) unsigned, d3 decimal (22) unsigned);
drop table t1;
create table t1 (col1 decimal(5,2), col2 numeric(5,2));
select * from t1;
drop table t1;
create table t1 (col1 int, col2 decimal(30,25), col3 numeric(30,25));
insert into t1 values (1,0.0123456789012345678912345,0.0123456789012345678912345);
select col2/9999999999 from t1 where col1=1;
select 9999999999/col2 from t1 where col1=1;
select 77777777/7777777;
drop table t1;
create table t1 (a decimal(4,2));
insert into t1 values (0.00);
select * from t1 where a > -0.00;
select * from t1 where a = -0.00;
drop table t1;
create table t1 (col1 bigint default -9223372036854775808);
insert into t1 values (default);
select * from t1;
drop table t1;
select cast('1.00000001335143196001808973960578441619873046875E-10' as decimal(30,15));
select ln(14000) c1, convert(ln(14000),decimal(5,3)) c2, cast(ln(14000) as decimal(5,3)) c3;
create table t1 (sl decimal(5, 5));
drop table t1;
create table t1 (sl decimal(65, 30));
drop table t1;
create table t1 (
       f1 decimal unsigned not null default 17.49, 
       f2 decimal unsigned not null default 17.68, 
       f3 decimal unsigned not null default 99.2, 
       f4 decimal unsigned not null default 99.7, 
       f5 decimal unsigned not null default 104.49, 
       f6 decimal unsigned not null default 199.91, 
       f7 decimal unsigned not null default 999.9, 
       f8 decimal unsigned not null default 9999.99);
insert into t1 (f1) values (1);
select * from t1;
drop table t1;
create table t1 (
        f0 decimal (30,30) zerofill not null DEFAULT 0,
        f1 decimal (0,0) zerofill not null default 0);
drop table t1;
drop procedure if exists wg2;
select cast(@non_existing_user_var/2 as DECIMAL);
CREATE TABLE t1 (
   my_float   FLOAT,
   my_double  DOUBLE,
   my_varchar VARCHAR(50),
   my_decimal DECIMAL(65,30)
);
SELECT my_float, my_double, my_varchar FROM t1;
SELECT CAST(my_float   AS DECIMAL(65,30)), my_float FROM t1;
SELECT CAST(my_double  AS DECIMAL(65,30)), my_double FROM t1;
SELECT CAST(my_varchar AS DECIMAL(65,30)), my_varchar FROM t1;
UPDATE t1 SET my_decimal = my_float;
SELECT my_decimal, my_float   FROM t1;
UPDATE t1 SET my_decimal = my_double;
SELECT my_decimal, my_double  FROM t1;
UPDATE t1 SET my_decimal = my_varchar;
SELECT my_decimal, my_varchar FROM t1;
DROP TABLE t1;
create table t1 (c1 decimal(64));
select * from t1;
drop table t1;
create table t1(a decimal(7,2));
insert into t1 values(123.12);
select * from t1;
alter table t1 modify a decimal(10,2);
select * from t1;
drop table t1;
create table t1 (i int, j int);
insert into t1 values (1,1), (1,2), (2,3), (2,4);
select i, count(distinct j) from t1 group by i;
select i+0.0 as i2, count(distinct j) from t1 group by i2;
drop table t1;
create table t1(f1 decimal(20,6));
insert into t1 values (CAST('10:11:12' AS date) + interval 14 microsecond);
insert into t1 values (CAST('10:11:12' AS time));
select * from t1;
drop table t1;
select cast(19999999999999999999 as unsigned);
create table t1(a decimal(18));
insert into t1 values(123456789012345678);
alter table t1 modify column a decimal(19);
select * from t1;
drop table t1;
select cast(11.1234 as DECIMAL(3,2));
select * from (select cast(11.1234 as DECIMAL(3,2))) t;
select cast(a as DECIMAL(3,2))
 from (select 11.1233 as a
  UNION select 11.1234
  UNION select 12.1234
 ) t;
select cast(a as DECIMAL(3,2)), count(*)
 from (select 11.1233 as a
  UNION select 11.1234
  UNION select 12.1234
 ) t group by 1;
create table t1 (s varchar(100));
insert into t1 values (0.00000000010000000000000000364321973154977415791655470655996396089904010295867919921875);
drop table t1;
SELECT 1.000000000000 * 99.999999999998 / 100 a,1.000000000000 * (99.999999999998 / 100) b;
SELECT CAST(1 AS decimal(65,10));
SELECT CAST(1 AS decimal(65,30));
CREATE TABLE t1 (a int DEFAULT NULL, b int DEFAULT NULL);
INSERT INTO t1 VALUES (3,30), (1,10), (2,10);
SELECT a+CAST(1 AS decimal(65,30)) AS aa, SUM(b) FROM t1 GROUP BY aa;
DROP TABLE t1;
CREATE TABLE t1 (a int DEFAULT NULL, b int DEFAULT NULL);
INSERT INTO t1 VALUES (3,30), (1,10), (2,10);
SELECT 1 FROM t1 GROUP BY @b := @a, @b;
DROP TABLE t1;
CREATE TABLE t1 SELECT 0.123456789012345678901234567890123456 AS f1;
SELECT f1 FROM t1;
DROP TABLE t1;
select (1.20396873 * 0.89550000 * 0.68000000 * 1.08721696 * 0.99500000 *
        1.01500000 * 1.01500000 * 0.99500000);
create table t1 as select 5.05 / 0.014;
select * from t1;
DROP TABLE t1;
select cast(143.481 as decimal(4,1));
select cast(143.481 as decimal(4,0));
select cast(143.481 as decimal(2,1));
select cast(-3.4 as decimal(2,1));
select cast(99.6 as decimal(2,0));
select cast(-13.4 as decimal(2,1));
select cast(98.6 as decimal(2,0));
CREATE TABLE t1 SELECT .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT 1 + .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT 1 * .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT 1 / .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT 1 % .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 SELECT
  /* 82 */ 1000000000000000000000000000000000000000000000000000000000000000000000000000000001
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT
  /* 1 */ 1.10000000000000000000000000000000000000000000000000000000000000000000000000000001 /* 80 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT
  /* 1 */ 1.100000000000000000000000000000000000000000000000000000000000000000000000000000001 /* 81 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT
  .100000000000000000000000000000000000000000000000000000000000000000000000000000001 /* 81 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT
  .123456789012345678901234567890123456789012345678901234567890123456 /* 66 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT 123.1234567890123456789012345678901 /* 31 */ AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 SELECT 1.1 + CAST(1 AS DECIMAL(65,30)) AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DECIMAL(30,30));
INSERT INTO t1 VALUES (0.1),(0.2),(0.3);
CREATE TABLE t2 SELECT MIN(a + 0.0000000000000000000000000000001) AS c1 FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a DECIMAL(30,30));
INSERT INTO t1 VALUES (0.1),(0.2),(0.3);
CREATE TABLE t2 SELECT IFNULL(a + 0.0000000000000000000000000000001, NULL) AS c1 FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a DECIMAL(30,30));
INSERT INTO t1 VALUES (0.1),(0.2),(0.3);
CREATE TABLE t2 SELECT CASE a WHEN 0.1 THEN 0.0000000000000000000000000000000000000000000000000000000000000000001 END AS c1 FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t1 SELECT @decimal AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 
SELECT .123456789012345678901234567890123456789012345678901234567890123456 AS a;
DROP TABLE t1;
SELECT 1 % 
.123456789123456789123456789123456789123456789123456789123456789123456789123456789 
  AS my_col;
CREATE TABLE currencies (id int, rate decimal(16,4), 
  PRIMARY KEY (id), KEY (rate));
INSERT INTO currencies VALUES (11,0.7028);
INSERT INTO currencies VALUES (1,1);
CREATE TABLE payments (
  id int,
  supplier_id int,
  status int,
  currency_id int,
  vat decimal(7,4),
  PRIMARY KEY (id),
  KEY currency_id (currency_id),
  KEY supplier_id (supplier_id)
);
INSERT INTO payments (id,status,vat,supplier_id,currency_id) VALUES
(3001,2,0.0000,344,11), (1,2,0.0000,1,1);
CREATE TABLE sub_tasks (
  id int,
  currency_id int,
  price decimal(16,4),
  discount decimal(10,4),
  payment_id int,
  PRIMARY KEY (id),
  KEY currency_id (currency_id),
  KEY payment_id (payment_id)
);
INSERT INTO sub_tasks (id, price, discount, payment_id, currency_id) VALUES
(52, 12.60, 0, 3001, 11), (56, 14.58, 0, 3001, 11);
DROP TABLE currencies, payments, sub_tasks;
CREATE TABLE t1 (a DECIMAL(4,4) UNSIGNED);
INSERT INTO t1 VALUES (0);
SELECT AVG(DISTINCT a) FROM t1;
SELECT SUM(DISTINCT a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(d1 DECIMAL(60,0) NOT NULL,
                d2 DECIMAL(60,0) NOT NULL);
INSERT INTO t1 (d1, d2) VALUES(0.0, 0.0);
SELECT d1 * d2 FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a DECIMAL(20,3) NOT NULL);
INSERT INTO t1 VALUES (20000716055804.035);
INSERT INTO t1 VALUES (20080821000000.000);
INSERT INTO t1 VALUES (0);
SELECT GREATEST(a, 1323) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (b INT, KEY(b));
INSERT INTO t1 VALUES (1),(2);
UPDATE  IGNORE t1 SET b = 1
WHERE b NOT IN (NULL, -3333333333333333333333);
DROP TABLE t1;
CREATE TABLE t1(b INT, KEY(b));
INSERT INTO t1 VALUES (0);
SELECT 1 FROM t1 WHERE b NOT IN (0.1,-0.1);
DROP TABLE t1;
CREATE TABLE t1(
a DECIMAL(25,20) UNSIGNED, KEY(a)
);
INSERT INTO t1 VALUES (1), (NULL);
DROP TABLE t1;
CREATE TABLE t (id SERIAL, d DECIMAL(65,30));
INSERT INTO t VALUES (),(),(),(),(),(),(),(),();
INSERT INTO t VALUES (),(),(),(),(),(),(),(),();
INSERT INTO t VALUES (),(),(),(),(),(),(),(),();
UPDATE t SET d = CONCAT('1e-', id);
SELECT d, d MOD 1 FROM t;
DROP TABLE t;
CREATE TABLE t1(value DECIMAL(24,0) NOT NULL);
INSERT INTO t1(value) 
VALUES('100000000000000000000001'),
      ('100000000000000000000002'), 
      ('100000000000000000000003');
SELECT * FROM t1 WHERE value = '100000000000000000000002';
SELECT * FROM t1 WHERE '100000000000000000000002' = value;
SELECT * FROM t1 WHERE value + 0 = '100000000000000000000002';
SELECT * FROM t1 WHERE value = 100000000000000000000002;
SELECT * FROM t1 WHERE value + 0 = 100000000000000000000002;
PREPARE stmt FROM 'SELECT * FROM t1 WHERE value = ?';
DEALLOCATE PREPARE stmt;
ALTER TABLE t1 ADD INDEX value (value);
SELECT * FROM t1 WHERE value = '100000000000000000000002';
DROP TABLE t1;
SELECT CAST(-0.0e0 AS DECIMAL) = 0;
CREATE TABLE t1(a time);
INSERT INTO t1 VALUES('00:00:01');
SELECT 1 FROM t1 WHERE EXISTS
(SELECT 1 FROM t1 HAVING (a / -7777777777) in ("a"));
DROP TABLE t1;
CREATE TABLE t1 (
  d decimal(18,2) unsigned DEFAULT NULL,
  i int unsigned DEFAULT NULL
)
SELECT
1000 AS d,
3 AS i;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t(a DECIMAL(56,13) NOT NULL);
INSERT INTO t VALUES(0);
SELECT 1 FROM t WHERE a<=>time('-t');
DROP TABLE t;
select maketime(1,1.1,1);
CREATE TABLE t1
(
  f1 INT(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2
(
  f1 SMALLINT(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT INTO t2 VALUES (84), (126), (36), (36);
SELECT DISTINCT q1.f1 / 3 FROM (SELECT SUM(f1) AS f1 FROM t2  ) q1, (SELECT 0 FROM t1) q2;
SELECT DISTINCT q1.f1 / 3 FROM (SELECT SUM(f1) AS f1 FROM t2  ) q1;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT UNSIGNED, b DECIMAL(10,2) UNSIGNED);
INSERT INTO t1 VALUES (2015, 123456.78);
CREATE TABLE t2(a INT UNSIGNED, b INT UNSIGNED);
INSERT INTO t2 VALUES (2015, 123456);
CREATE TABLE t3(a DECIMAL(10,2) UNSIGNED, b DECIMAL(10,2) UNSIGNED);
INSERT INTO t3 VALUES (2015, 123456);
DROP TABLE t1, t2, t3;
CREATE TABLE t(
  a YEAR NOT NULL,
  b DECIMAL(29,5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=INNODB;
INSERT INTO t VALUES (2000,1),(2000,1),(2000,9999);
DROP TABLE t;
CREATE TABLE t1(a DATETIME(4));
INSERT INTO t1 VALUES(NOW()),(NOW()),(NOW()),(NOW()),(NOW());
SELECT SQL_BUFFER_RESULT JSON_OBJECT('a', a MOD 1) FROM t1;
DROP TABLE t1;
SELECT -1 DIV LEAST(1, JSON_EXTRACT('1', '$.abc'));
SELECT 1.056448745601382294204817708678199647327125723403005048300399553 *
CAST(0.996 AS DECIMAL(14,3)) AS RESULT;
SELECT 1.0564487456013822942048177086781996473271257234030050483003995531 *
CAST(0.996 AS DECIMAL(14,3)) AS RESULT;
SELECT CAST(0.996 AS DECIMAL(14,3)) *
1.056448745601382294204817708678199647327125723403005048300399553 AS RESULT;
SELECT CAST(0.996 AS DECIMAL(14,3)) *
1.0564487456013822942048177086781996473271257234030050483003995531 AS RESULT;
CREATE TABLE t2 (i DECIMAL (30,27));
INSERT INTO t2 VALUES (6.8926822182388193469056146);
DROP TABLE t2;
CREATE TABLE t (a int);
INSERT INTO t() VALUES(),(),(),();
SELECT
lag(1,96,
-66812354762147309124165421419678600705366236356475480.892682218238819346905614650696)
over()
FROM t;
DROP TABLE t;
CREATE TABLE t1(a DECIMAL(10,0));
INSERT INTO t1 VALUES(0);
SELECT * FROM t1 AS alias1 NATURAL JOIN t1 AS alias2;
DROP TABLE t1;
CREATE TABLE t(a DECIMAL(10,4));
INSERT INTO t VALUES(-1),(1),(100);
DROP TABLE t;
CREATE TABLE t(a DECIMAL(14,14) DEFAULT NULL);
INSERT INTO t VALUES
 (-0.99999999999999), (-0.99999999999999), (0.15610000000000);
SELECT WEIGHT_STRING(TRUNCATE((SELECT a FROM t), -17410));
DROP TABLE t;
SELECT 1.0 div (@a:='xx');
SELECT 1.0 div (@a:='1xx');
CREATE TABLE t1 (a DECIMAL(10,0), b DECIMAL(10,0), KEY(a)) ENGINE=INNODB;
INSERT INTO t1 VALUES (0,0),(1,1);
SELECT a FROM t1 FORCE INDEX(a) WHERE a='m';
SELECT a FROM t1 FORCE INDEX(a) WHERE a=CONCAT('m');
SELECT a FROM t1 FORCE INDEX(a) WHERE a=COALESCE('m');
SELECT * FROM t1 WHERE b='m';
SELECT * FROM t1 WHERE b=CONCAT('m');
SELECT * FROM t1 WHERE b=COALESCE('m');
SELECT a FROM t1 FORCE INDEX(a) WHERE a='';
SELECT a FROM t1 FORCE INDEX(a) WHERE a=CONCAT('');
SELECT a FROM t1 FORCE INDEX(a) WHERE a=COALESCE('');
SELECT * FROM t1 WHERE b='';
SELECT * FROM t1 WHERE b=CONCAT('');
SELECT * FROM t1 WHERE b=COALESCE('');
CREATE TABLE t2 (a char(10), b varchar(10));
INSERT INTO t2 VALUES('x1 y ', 'x1 y ');
SELECT maketime(1, 2, a) FROM t2;
SELECT maketime(1, 2, b) FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1 (d DECIMAL(20,10));
INSERT INTO t1 VALUES (93.33);
SELECT * FROM t1 WHERE
d<0000000000000000000000000000000000000000000000000000000000000000000000000000000020.01;
SELECT * FROM t1 WHERE
d>0000000000000000000000000000000000000000000000000000000000000000000000000000000020.01;
SELECT * FROM t1 WHERE
d<000000000000000000000000000000000000000000000000000000000000000000000000000000000.01;
SELECT * FROM t1 WHERE
d>000000000000000000000000000000000000000000000000000000000000000000000000000000000.01;
DROP TABLE t1;
