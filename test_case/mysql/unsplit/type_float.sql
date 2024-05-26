SELECT 10,10.0,10.,.1e+2,100.0e-1;
SELECT 6e-16, -6e-16, --6e-16, -6e-16+1.000000;
SELECT 1e1,1.e1,1.0e1,1e+1,1.e+1,1.0e+1,1e-1,1.e-1,1.0e-1;
SELECT 0.001e+1,0.001e-1, -0.001e+01,-0.001e-01;
SELECT 123.23E+02,-123.23E-02,"123.23E+02"+0.0,"-123.23E-02"+0.0;
SELECT 2147483647E+02,21474836.47E+06;
create table t1 (f1 float(24),f2 float(52));
insert into t1 values(-10,-10),(1e-5,1e-5),(1e-10,1e-10),(1e-15,1e-15),(1e-20,1e-20),(1e-50,1e-50),(1e-150,1e-150);
select * from t1;
drop table t1;
create table t1 (datum double);
insert into t1 values (0.5),(1.0),(1.5),(2.0),(2.5);
select * from t1;
select * from t1 where datum < 1.5;
select * from t1 where datum > 1.5;
select * from t1 where datum = 1.5;
drop table t1;
create table t1 (a  decimal(7,3) not null, key (a));
insert into t1 values ("0"),("-0.00"),("-0.01"),("-0.002"),("1");
select a from t1 order by a;
select min(a) from t1;
drop table t1;
create table t1 (c1 double, c2 varchar(20));
insert t1 values (121,"16");
select c1 + c1 * (c2 / 100) as col from t1;
create table t2 select c1 + c1 * (c2 / 100) as col1, round(c1, 5) as col2, round(c1, 35) as col3, sqrt(c1*1e-15) col4 from t1;
select * from t2;
drop table t1,t2;
create table t1 (a float);
insert into t1 values (1);
select max(a),min(a),avg(a) from t1;
drop table t1;
create table t1 (f float, f2 float(24), f3 float(6,2), d double, d2 float(53), d3 double(10,3), de decimal, de2 decimal(6), de3 decimal(5,2), n numeric, n2 numeric(8), n3 numeric(7,6));
drop table t1;
create table t1 (a  decimal(7,3) not null, key (a));
insert into t1 values ("0"),("-0.00"),("-0.01"),("-0.002"),("1");
select a from t1 order by a;
drop table t1;
create table t1 (c20 char);
drop table t1;
drop table if exists t1;
create table t1 (d1 double, d2 double unsigned);
insert into t1 set d1 = -1.0;
select * from t1;
drop table t1;
create table t1 (f float(4,3));
select * from t1;
drop table if exists t1;
create table t1 (f double(4,3));
select * from t1;
drop table if exists t1;
create table t1 (c char(20));
insert into t1 values (5e-28);
select * from t1;
drop table t1;
create table t1 (c char(6));
insert into t1 values (2e5),(2e6),(2e-4),(2e-5);
select * from t1;
drop table t1;
create table t1 (d double(10,1));
create table t2 (d double(10,9));
insert into t1 values ("100000000.0");
insert into t2 values ("1.23456780");
create table t3 select * from t2 union select * from t1;
select * from t3;
drop table t1, t2, t3;
create table t1 select  105213674794682365.00 + 0.0 x;
drop table t1;
create table t1 select 0.0 x;
create table t2 select 105213674794682365.00 y;
create table t3 select x+y a from t1,t2;
drop table t1,t2,t3;
select 1e-308, 1.00000001e-300, 100000000e-300;
select 10e307;
create table t1(a int, b double(8, 2));
insert into t1 values
(1, 28.50), (1, 121.85), (1, 157.23), (1, 1351.00), (1, -1965.35), (1, 81.75), 
(1, 217.08), (1, 7.94), (4, 96.07), (4, 6404.65), (4, -6500.72), (2, 100.00),
(5, 5.00), (5, -2104.80), (5, 2033.80), (5, 0.07), (5, 65.93),
(3, -4986.24), (3, 5.00), (3, 4857.34), (3, 123.74), (3,  0.16),
(6, -1695.31), (6, 1003.77), (6, 499.72), (6, 191.82);
select sum(b) s from t1 group by a;
select sum(b) s from t1 group by a having s <> 0;
select sum(b) s from t1 group by a having s <> 0 order by s;
select sum(b) s from t1 group by a having s <=> 0;
select sum(b) s from t1 group by a having s <=> 0 order by s;
alter table t1 add key (a, b);
select sum(b) s from t1 group by a;
select sum(b) s from t1 group by a having s <> 0;
select sum(b) s from t1 group by a having s <> 0 order by s;
select sum(b) s from t1 group by a having s <=> 0;
select sum(b) s from t1 group by a having s <=> 0 order by s;
drop table t1;
CREATE TABLE t1 (
  f1 real zerofill,
  f2 double zerofill,
  f3 float zerofill);
INSERT INTO t1 VALUES ( 0.314152e+1, 0.314152e+1, 0.314152e+1);
select f1, f2, f3 FROM t1;
DROP TABLE t1;
create table t1 (f1 double(200, 0));
insert into t1 values (1e199), (-1e199);
insert into t1 values (1e200), (-1e200);
select f1 + 0e0 from t1;
drop table t1;
create table t1 (f1 float(30, 0));
insert into t1 values (1e29), (-1e29);
insert into t1 values (1e30), (-1e30);
select f1 + 0e0 from t1;
drop table t1;
create table t1 (c char(6));
insert into t1 values (2e6),(2e-5);
select * from t1;
drop table t1;
CREATE TABLE d1 (d DOUBLE);
INSERT INTO d1 VALUES (1.7976931348623157E+308);
SELECT * FROM d1;
SELECT * FROM d1;
DROP TABLE d1;
create table t1 (a char(20));
insert into t1 values (1.225e-05);
select a+0 from t1;
drop table t1;
create table t1(d double, u bigint unsigned);
insert into t1(d) values (9.22337203685479e18),
                         (1.84e19);
update t1 set u = d;
select u from t1;
drop table t1;
CREATE TABLE t1 (f1 DOUBLE);
INSERT INTO t1 VALUES(-1.79769313486231e+308);
SELECT f1 FROM t1;
DROP TABLE t1;
select format(-1.7976931348623157E+307,256) as foo;
select least(-1.1111111111111111111111111,
             - group_concat(1.7976931348623157E+308)) as foo;
select format(truncate('1.7976931348623157E+308',-12),1,'fr_BE') as foo;
CREATE TABLE t1 (f FLOAT);
INSERT INTO t1 VALUES ('1.');
SELECT * FROM t1 ORDER BY f;
DROP TABLE t1;
CREATE TABLE t5u(c1 FLOAT(58,0) UNSIGNED NOT NULL);
CREATE TABLE t5s(c1 FLOAT(58,0) SIGNED NOT NULL);
SELECT * from t5u;
SELECT * from t5s;
DROP TABLE t5u, t5s;
CREATE TABLE t1(a FLOAT PRIMARY KEY AUTO_INCREMENT);
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3(a FLOAT);
ALTER TABLE t3 MODIFY COLUMN a FLOAT PRIMARY KEY AUTO_INCREMENT;
CREATE TABLE t4(a INT PRIMARY KEY);
ALTER TABLE t4 DROP PRIMARY KEY, ADD COLUMN b FLOAT PRIMARY KEY AUTO_INCREMENT;
DROP TABLE t4, t3, t2, t1;
CREATE TABLE t1(a DOUBLE PRIMARY KEY AUTO_INCREMENT);
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3(a DOUBLE);
ALTER TABLE t3 MODIFY COLUMN a DOUBLE PRIMARY KEY AUTO_INCREMENT;
CREATE TABLE t4(a INT PRIMARY KEY);
ALTER TABLE t4 DROP PRIMARY KEY, ADD COLUMN b DOUBLE PRIMARY KEY AUTO_INCREMENT;
DROP TABLE t4, t3, t2, t1;
CREATE TABLE t1(a FLOAT(255,0));
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE TABLE t4(a FLOAT);
ALTER TABLE t4 MODIFY COLUMN a FLOAT(255,0);
CREATE TABLE t5(a INT PRIMARY KEY);
ALTER TABLE t5 ADD COLUMN b FLOAT(255,0);
CREATE TABLE t6(a FLOAT(12));
DROP TABLE t6, t5, t4, t3, t2, t1;
CREATE TABLE t1(a DOUBLE(42,12));
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE TABLE t4(a DOUBLE);
ALTER TABLE t4 MODIFY COLUMN a DOUBLE(42,12);
CREATE TABLE t5(a INT PRIMARY KEY);
ALTER TABLE t5 ADD COLUMN b DOUBLE(42,12);
DROP TABLE t5, t4, t3, t2, t1;
CREATE TABLE t1(a DOUBLE PRECISION(42,12));
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE TABLE t4(a DOUBLE);
ALTER TABLE t4 MODIFY COLUMN a DOUBLE PRECISION(42,12);
CREATE TABLE t5(a INT PRIMARY KEY);
ALTER TABLE t5 ADD COLUMN b DOUBLE PRECISION(42,12);
DROP TABLE t5, t4, t3, t2, t1;
CREATE TABLE t1(a REAL(42,12));
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE TABLE t4(a REAL);
ALTER TABLE t4 MODIFY COLUMN a REAL(42,12);
CREATE TABLE t5(a INT PRIMARY KEY);
ALTER TABLE t5 ADD COLUMN b REAL(42,12);
DROP TABLE t5, t4, t3, t2, t1;
CREATE TABLE t1(a FLOAT UNSIGNED);
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE TABLE t4(a FLOAT);
ALTER TABLE t4 MODIFY COLUMN a FLOAT UNSIGNED;
CREATE TABLE t5(a INT PRIMARY KEY);
ALTER TABLE t5 ADD COLUMN b FLOAT UNSIGNED;
DROP TABLE t5, t4, t3, t2, t1;
CREATE TABLE t1(a DOUBLE UNSIGNED);
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE TABLE t4(a DOUBLE);
ALTER TABLE t4 MODIFY COLUMN a DOUBLE UNSIGNED;
CREATE TABLE t5(a INT PRIMARY KEY);
ALTER TABLE t5 ADD COLUMN b DOUBLE UNSIGNED;
DROP TABLE t5, t4, t3, t2, t1;
CREATE TABLE t1(a REAL UNSIGNED);
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE TABLE t4(a REAL);
ALTER TABLE t4 MODIFY COLUMN a REAL UNSIGNED;
CREATE TABLE t5(a INT PRIMARY KEY);
ALTER TABLE t5 ADD COLUMN b REAL UNSIGNED;
DROP TABLE t5, t4, t3, t2, t1;
CREATE TABLE t1(a DECIMAL(4,2) UNSIGNED);
ALTER TABLE t1 ADD COLUMN b INT;
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE TABLE t4(a DECIMAL(4,2));
ALTER TABLE t4 MODIFY COLUMN a DECIMAL(4,2) UNSIGNED;
CREATE TABLE t5(a INT PRIMARY KEY);
ALTER TABLE t5 ADD COLUMN b DECIMAL(4,2) UNSIGNED;
DROP TABLE t5, t4, t3, t2, t1;
