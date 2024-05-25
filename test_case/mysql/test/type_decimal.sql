DROP TABLE IF EXISTS t1, t2;
CREATE TABLE t1 (
   id int(11) NOT NULL auto_increment,
   datatype_id int(11) DEFAULT '0' NOT NULL,
   min_value decimal(20,10) DEFAULT '0.0000000000' NOT NULL,
   max_value decimal(20,10) DEFAULT '0.0000000000' NOT NULL,
   valuename varchar(20),
   forecolor int(11),
   backcolor int(11),
   PRIMARY KEY (id),
   UNIQUE datatype_id (datatype_id, min_value, max_value)
);
INSERT INTO t1 VALUES ( '1', '4', '0.0000000000', '0.0000000000', 'Ei saja', '0', '16776960');
INSERT INTO t1 VALUES ( '2', '4', '1.0000000000', '1.0000000000', 'Sajab', '16777215', '255');
INSERT INTO t1 VALUES ( '3', '1', '2.0000000000', '49.0000000000', '', '0', '16777215');
INSERT INTO t1 VALUES ( '60', '11', '0.0000000000', '0.0000000000', 'Rikkis', '16777215', '16711680');
INSERT INTO t1 VALUES ( '4', '12', '1.0000000000', '1.0000000000', 'nork sadu', '65280', '14474460');
INSERT INTO t1 VALUES ( '5', '12', '2.0000000000', '2.0000000000', 'keskmine sadu', '255', '14474460');
INSERT INTO t1 VALUES ( '6', '12', '3.0000000000', '3.0000000000', 'tugev sadu', '127', '14474460');
INSERT INTO t1 VALUES ( '43', '39', '6.0000000000', '6.0000000000', 'lobjakas', '13107327', '16763080');
INSERT INTO t1 VALUES ( '40', '39', '2.0000000000', '2.0000000000', 'vihm', '8355839', '16777215');
INSERT INTO t1 VALUES ( '53', '1', '-35.0000000000', '-5.0000000000', '', '0', '16777215');
INSERT INTO t1 VALUES ( '41', '39', '3.0000000000', '3.0000000000', 'kÃÂ¼lm vihm', '120', '16763080');
INSERT INTO t1 VALUES ( '12', '21', '21.0000000000', '21.0000000000', 'Kuiv', '13158600', '16777215');
INSERT INTO t1 VALUES ( '13', '21', '13.0000000000', '13.0000000000', 'MÃÂ¤rg', '5263615', '16777215');
INSERT INTO t1 VALUES ( '14', '21', '22.0000000000', '22.0000000000', 'Niiske', '9869055', '16777215');
INSERT INTO t1 VALUES ( '19', '21', '33.0000000000', '33.0000000000', 'MÃÂ¤rg', '5263615', '16777215');
INSERT INTO t1 VALUES ( '15', '21', '23.0000000000', '23.0000000000', 'MÃÂ¤rg', '5263615', '16777215');
INSERT INTO t1 VALUES ( '16', '21', '31.0000000000', '31.0000000000', 'Kuiv', '13158600', '16777215');
INSERT INTO t1 VALUES ( '17', '21', '12.0000000000', '12.0000000000', 'Niiske', '9869055', '16777215');
INSERT INTO t1 VALUES ( '18', '21', '32.0000000000', '32.0000000000', 'Niiske', '9869055', '16777215');
INSERT INTO t1 VALUES ( '21', '21', '11.0000000000', '11.0000000000', 'Kuiv', '13158600', '16777215');
INSERT INTO t1 VALUES ( '22', '33', '21.0000000000', '21.0000000000', 'Pilves, kuiv', '8355711', '12632256');
INSERT INTO t1 VALUES ( '23', '33', '13.0000000000', '13.0000000000', 'Sajab, mÃÂ¤rg', '0', '8355839');
INSERT INTO t1 VALUES ( '24', '33', '22.0000000000', '22.0000000000', 'Pilves, niiske', '8355711', '12632319');
INSERT INTO t1 VALUES ( '29', '33', '33.0000000000', '33.0000000000', 'Selge, mÃÂ¤rg', '16777215', '8355839');
INSERT INTO t1 VALUES ( '25', '33', '23.0000000000', '23.0000000000', 'Pilves, mÃÂ¤rg', '8355711', '8355839');
INSERT INTO t1 VALUES ( '26', '33', '31.0000000000', '31.0000000000', 'Selge, kuiv', '16777215', '12632256');
INSERT INTO t1 VALUES ( '27', '33', '12.0000000000', '12.0000000000', 'Sajab, niiske', '0', '12632319');
INSERT INTO t1 VALUES ( '28', '33', '32.0000000000', '32.0000000000', 'Selge, niiske', '16777215', '12632319');
INSERT INTO t1 VALUES ( '31', '33', '11.0000000000', '11.0000000000', 'Sajab, kuiv', '0', '12632256');
INSERT INTO t1 VALUES ( '32', '11', '1.0000000000', '1.0000000000', 'Korras', '16777215', '49152');
INSERT INTO t1 VALUES ( '33', '21', '335.0000000000', '335.0000000000', 'HÃÂ¤rmatis!', '14448840', '11842740');
INSERT INTO t1 VALUES ( '34', '21', '134.0000000000', '134.0000000000', 'Hoiatus, M+S!', '255', '13158600');
INSERT INTO t1 VALUES ( '35', '21', '133.0000000000', '133.0000000000', 'Hoiatus, mÃÂ¤rg!', '5263615', '13158600');
INSERT INTO t1 VALUES ( '36', '21', '135.0000000000', '135.0000000000', 'HÃÂ¤rmatis!', '14448840', '11842740');
INSERT INTO t1 VALUES ( '38', '21', '132.0000000000', '132.0000000000', 'Hoiatus, niiske!', '9869055', '13158600');
INSERT INTO t1 VALUES ( '39', '39', '1.0000000000', '1.0000000000', 'ei saja', '11206570', '16777215');
INSERT INTO t1 VALUES ( '44', '39', '4.0000000000', '5.0000000000', 'lumi', '16711680', '16763080');
INSERT INTO t1 VALUES ( '45', '12', '0.0000000000', '0.0000000000', '', '16777215', '14474460');
INSERT INTO t1 VALUES ( '46', '39', '8.0000000000', '8.0000000000', 'rahe', '9830400', '16763080');
INSERT INTO t1 VALUES ( '47', '39', '9.0000000000', '9.0000000000', 'tÃÂ¼ÃÂ¼p ebaselge', '12582912', '16777215');
INSERT INTO t1 VALUES ( '48', '39', '7.0000000000', '7.0000000000', 'lumetuisk', '7209070', '16763080');
INSERT INTO t1 VALUES ( '142', '15', '2.0000000000', '49.0000000000', '', '0', '16777215');
INSERT INTO t1 VALUES ( '52', '1', '-4.9000000000', '-0.1000000000', '', '0', '15774720');
INSERT INTO t1 VALUES ( '141', '15', '-4.9000000000', '-0.1000000000', '', '0', '15774720');
INSERT INTO t1 VALUES ( '55', '8', '0.0000000000', '0.0000000000', '', '0', '16777215');
INSERT INTO t1 VALUES ( '56', '8', '0.0100000000', '0.1000000000', '', '0', '16770560');
INSERT INTO t1 VALUES ( '57', '8', '0.1100000000', '25.0000000000', '', '0', '15774720');
INSERT INTO t1 VALUES ( '58', '2', '90.0000000000', '94.9000000000', '', NULL, '16770560');
INSERT INTO t1 VALUES ( '59', '6', '0.0000000000', '360.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '61', '21', '38.0000000000', '38.0000000000', 'Niiske', '9869055', '16777215');
INSERT INTO t1 VALUES ( '62', '38', '500.0000000000', '999.0000000000', '', '0', '16770560');
INSERT INTO t1 VALUES ( '63', '38', '1000.0000000000', '2000.0000000000', '', '0', '16777215');
INSERT INTO t1 VALUES ( '64', '17', '0.0000000000', '0.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '65', '17', '0.1000000000', '10.0000000000', '', NULL, '16770560');
INSERT INTO t1 VALUES ( '67', '21', '412.0000000000', '412.0000000000', 'Niiske', '9869055', '16777215');
INSERT INTO t1 VALUES ( '68', '21', '413.0000000000', '413.0000000000', 'MÃÂ¤rg', '5263615', '16777215');
INSERT INTO t1 VALUES ( '69', '21', '113.0000000000', '113.0000000000', 'MÃÂ¤rg', '5263615', '16777215');
INSERT INTO t1 VALUES ( '70', '21', '416.0000000000', '416.0000000000', 'Lumine!', '16711680', '11842740');
INSERT INTO t1 VALUES ( '71', '38', '0.0000000000', '499.0000000000', '', NULL, '16711680');
INSERT INTO t1 VALUES ( '72', '22', '-49.0000000000', '49.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '73', '13', '0.0000000000', '9.9000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '74', '13', '10.0000000000', '14.9000000000', '', NULL, '16770560');
INSERT INTO t1 VALUES ( '75', '7', '0.0000000000', '50.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '76', '18', '0.0000000000', '0.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '77', '18', '0.1000000000', '10.0000000000', '', NULL, '16770560');
INSERT INTO t1 VALUES ( '78', '19', '300.0000000000', '400.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '79', '19', '0.0000000000', '299.0000000000', '', NULL, '16770560');
INSERT INTO t1 VALUES ( '80', '23', '0.0000000000', '100.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '81', '24', '0.0000000000', '200.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '82', '26', '0.0000000000', '0.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '83', '26', '0.1000000000', '5.0000000000', '', NULL, '16776960');
INSERT INTO t1 VALUES ( '84', '21', '422.0000000000', '422.0000000000', 'Niiske', '9869055', '16777215');
INSERT INTO t1 VALUES ( '85', '21', '411.0000000000', '411.0000000000', 'Saju hoiat.,kuiv!', '16777215', '13158600');
INSERT INTO t1 VALUES ( '86', '21', '423.0000000000', '423.0000000000', 'MÃÂ¤rg', '5263615', '16777215');
INSERT INTO t1 VALUES ( '144', '16', '-49.0000000000', '-5.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '88', '16', '2.0000000000', '49.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '91', '21', '114.0000000000', '114.0000000000', 'Hoiatus, M+S!', '255', '13158600');
INSERT INTO t1 VALUES ( '92', '21', '117.0000000000', '117.0000000000', 'Hoiatus, JÃÂÃÂ!', '14448840', '16711680');
INSERT INTO t1 VALUES ( '93', '21', '116.0000000000', '116.0000000000', 'Lumine!', '16711680', '11842740');
INSERT INTO t1 VALUES ( '94', '21', '414.0000000000', '414.0000000000', 'Hoiatus, M+S!', '255', '13158600');
INSERT INTO t1 VALUES ( '95', '21', '325.0000000000', '325.0000000000', 'HÃÂ¤rmatis!', '14448840', '11842740');
INSERT INTO t1 VALUES ( '98', '21', '28.0000000000', '28.0000000000', 'Niiske ja sool', '9869055', '16777215');
INSERT INTO t1 VALUES ( '99', '21', '118.0000000000', '118.0000000000', 'Hoiatus, N+S!', '9869055', '13158600');
INSERT INTO t1 VALUES ( '100', '21', '418.0000000000', '418.0000000000', 'Hoiatus, N+S!', '9869055', '13158600');
INSERT INTO t1 VALUES ( '102', '21', '428.0000000000', '428.0000000000', 'Hoiatus, N+S!', '9869055', '13158600');
INSERT INTO t1 VALUES ( '103', '21', '432.0000000000', '432.0000000000', 'Hoiatus, niiske!', '7895240', '13158600');
INSERT INTO t1 VALUES ( '104', '21', '421.0000000000', '421.0000000000', 'Saju hoiat.,kuiv!', '16777215', '13158600');
INSERT INTO t1 VALUES ( '105', '21', '24.0000000000', '24.0000000000', 'MÃÂ¤rg ja sool', '255', '16777215');
INSERT INTO t1 VALUES ( '106', '21', '438.0000000000', '438.0000000000', 'Hoiatus, N+S!', '9869055', '13158600');
INSERT INTO t1 VALUES ( '107', '21', '112.0000000000', '112.0000000000', 'Hoiatus, niiske!', '9869055', '13158600');
INSERT INTO t1 VALUES ( '108', '21', '34.0000000000', '34.0000000000', 'MÃÂ¤rg ja sool', '255', '16777215');
INSERT INTO t1 VALUES ( '109', '21', '434.0000000000', '434.0000000000', 'Hoiatus, M+S!', '255', '13158600');
INSERT INTO t1 VALUES ( '110', '21', '124.0000000000', '124.0000000000', 'Hoiatus, M+S!', '255', '13158600');
INSERT INTO t1 VALUES ( '111', '21', '424.0000000000', '424.0000000000', 'Hoiatus, M+S!', '255', '13158600');
INSERT INTO t1 VALUES ( '112', '21', '123.0000000000', '123.0000000000', 'Hoiatus, mÃÂ¤rg!', '5263615', '13158600');
INSERT INTO t1 VALUES ( '140', '15', '-49.0000000000', '-5.0000000000', '', '0', '16777215');
INSERT INTO t1 VALUES ( '114', '21', '18.0000000000', '18.0000000000', 'Niiske ja sool', '9869055', '16777215');
INSERT INTO t1 VALUES ( '115', '21', '122.0000000000', '122.0000000000', 'Hoiatus, niiske!', '9869055', '13158600');
INSERT INTO t1 VALUES ( '116', '21', '14.0000000000', '14.0000000000', 'MÃÂ¤rg ja sool', '255', '16777215');
INSERT INTO t1 VALUES ( '121', '2', '95.0000000000', '100.0000000000', '', NULL, '15774720');
INSERT INTO t1 VALUES ( '118', '2', '0.0000000000', '89.9000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '119', '21', '16.0000000000', '16.0000000000', 'Lumine!', '16711680', '11842740');
INSERT INTO t1 VALUES ( '120', '21', '26.0000000000', '26.0000000000', 'Lumine!', '16711680', '11842740');
INSERT INTO t1 VALUES ( '122', '13', '15.0000000000', '50.0000000000', '', NULL, '15774720');
INSERT INTO t1 VALUES ( '123', '5', '0.0000000000', '9.9000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '124', '5', '10.0000000000', '14.9000000000', '', NULL, '16770560');
INSERT INTO t1 VALUES ( '125', '5', '15.0000000000', '50.0000000000', '', NULL, '15774720');
INSERT INTO t1 VALUES ( '126', '21', '128.0000000000', '128.0000000000', 'Hoiatus, N+S!', '9869055', '13158600');
INSERT INTO t1 VALUES ( '129', '21', '126.0000000000', '126.0000000000', 'Lumine!', '16711680', '11842740');
INSERT INTO t1 VALUES ( '131', '21', '316.0000000000', '316.0000000000', 'Lumine!', '16711680', '11842740');
INSERT INTO t1 VALUES ( '132', '1', '0.0000000000', '1.9000000000', '', NULL, '16769024');
INSERT INTO t1 VALUES ( '134', '3', '-50.0000000000', '50.0000000000', '', NULL, '16777215');
INSERT INTO t1 VALUES ( '135', '8', '26.0000000000', '2000.0000000000', '', '9868950', '15774720');
INSERT INTO t1 VALUES ( '136', '21', '426.0000000000', '426.0000000000', 'Lumine!', '16711680', '11842740');
INSERT INTO t1 VALUES ( '137', '21', '127.0000000000', '127.0000000000', 'Hoiatus, JÃÂÃÂ!', '14448840', '16711680');
INSERT INTO t1 VALUES ( '138', '21', '121.0000000000', '121.0000000000', 'Kuiv', '13158600', '16777215');
INSERT INTO t1 VALUES ( '139', '21', '326.0000000000', '326.0000000000', 'Lumine!', '16711680', '11842740');
INSERT INTO t1 VALUES ( '143', '16', '-4.9000000000', '-0.1000000000', '', NULL, '15774720');
INSERT INTO t1 VALUES ( '145', '15', '0.0000000000', '1.9000000000', '', '0', '16769024');
INSERT INTO t1 VALUES ( '146', '16', '0.0000000000', '1.9000000000', '', '0', '16769024');
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
SELECT a, b, ROUND(c, a) 
FROM t2;
CREATE TABLE t3( a INT, b DECIMAL(6, 3) );
INSERT INTO t3 VALUES( 0, 1.5 );
SELECT ROUND( b, a ) FROM t3;
CREATE TABLE t4( a INT, b DECIMAL( 12, 0) );
INSERT INTO t4 VALUES( -9, 1.5e9 );
SELECT ROUND( b, a ) FROM t4;
CREATE TABLE t5( a INT, b DECIMAL( 13, 12 ) );
INSERT INTO t5 VALUES( 0, 1.5 );
INSERT INTO t5 VALUES( 9, 1.5e-9 );
SELECT ROUND( b, a ) FROM t5;
CREATE TABLE t6( a INT );
INSERT INTO t6 VALUES( 6 / 8 );
SELECT * FROM t6;
SELECT ROUND(20061108085411.000002);
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
