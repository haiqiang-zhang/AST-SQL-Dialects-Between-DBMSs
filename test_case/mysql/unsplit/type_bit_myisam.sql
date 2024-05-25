select 0 + b'1';
select 0 + b'0';
select 0 + b'000001';
select 0 + b'000011';
select 0 + b'000101';
select 0 + b'000000';
select 0 + b'10000000';
select 0 + b'11111111';
select 0 + b'10000001';
select 0 + b'1000000000000000';
select 0 + b'1111111111111111';
select 0 + b'1000000000000001';
drop table if exists t1,t2;
create table t1 (a bit(64));
insert into t1 values
(b'1111111111111111111111111111111111111111111111111111111111111111'),
(b'1000000000000000000000000000000000000000000000000000000000000000'),
(b'0000000000000000000000000000000000000000000000000000000000000001'),
(b'1010101010101010101010101010101010101010101010101010101010101010'),
(b'0101010101010101010101010101010101010101010101010101010101010101');
select hex(a) from t1;
drop table t1;
create table t1 (a bit);
select hex(a) from t1;
alter table t1 add unique (a);
drop table t1;
create table t1 (a bit(2));
select a+0 from t1;
alter table t1 add key (a);
select a+0 from t1;
drop table t1;
create table t1 (a bit(7), b bit(9), key(a, b));
insert into t1 values
(94, 46), (31, 438), (61, 152), (78, 123), (88, 411), (122, 118), (0, 177),
(75, 42), (108, 67), (79, 349), (59, 188), (68, 206), (49, 345), (118, 380),
(111, 368), (94, 468), (56, 379), (77, 133), (29, 399), (9, 363), (23, 36),
(116, 390), (119, 368), (87, 351), (123, 411), (24, 398), (34, 202), (28, 499),
(30, 83), (5, 178), (60, 343), (4, 245), (104, 280), (106, 446), (127, 403),
(44, 307), (68, 454), (57, 135);
select a+0 from t1;
select b+0 from t1;
select a+0, b+0 from t1;
select a+0, b+0 from t1 where a > 40 and b > 200 order by 1;
select a+0, b+0 from t1 where a > 40 and a < 70 order by 2;
select hex(min(a)) from t1;
select hex(min(b)) from t1;
select hex(min(a)), hex(max(a)), hex(min(b)), hex(max(b)) from t1;
drop table t1;
create table t1 (a int not null, b bit, c bit(9), key(a, b, c));
insert into t1 values
(4, NULL, 1), (4, 0, 3), (2, 1, 4), (1, 1, 100), (4, 0, 23), (4, 0, 54),
(56, 0, 22), (4, 1, 100), (23, 0, 1), (4, 0, 34);
select a+0, b+0, c+0 from t1;
select hex(min(b)) from t1 where a = 4;
select hex(min(c)) from t1 where a = 4 and b = 0;
select hex(max(b)) from t1;
select a+0, b+0, c+0 from t1 where a = 4 and b = 0 limit 2;
select a+0, b+0, c+0 from t1 where a = 4 and b = 1;
select a+0, b+0, c+0 from t1 where a = 4 and b = 1 and c=100;
select b+0, a+0, c+0 from t1 order by b desc;
select c+0, a+0, b+0 from t1 order by c;
drop table t1;
create table t1(a bit(2), b bit(2));
insert into t1 (a) values (0x01), (0x03), (0x02);
update t1 set b= concat(a);
select a+0, b+0 from t1;
drop table t1;
create table t1 (a bit(7), key(a));
insert into t1 values (44), (57);
select a+0 from t1;
drop table t1;
create table t1 (a bit(3), b bit(12));
insert into t1 values (7,(1<<12)-2), (0x01,0x01ff);
select hex(a),hex(b) from t1;
select hex(concat(a)),hex(concat(b)) from t1;
drop table t1;
create table t1(a int, b bit not null);
alter table t1 add primary key (a);
drop table t1;
create table t1 (a bit(19), b bit(5));
insert into t1 values (1000, 10), (3, 8), (200, 6), (2303, 2), (12345, 4), (1, 0);
select a+0, b+0 from t1;
alter table t1 engine=heap;
select a+0, b+0 from t1;
alter table t1 add key(a, b);
select a+0, b+0 from t1;
alter table t1 engine=myisam;
select a+0, b+0 from t1;
create table t2 engine=heap select * from t1;
select a+0, b+0 from t2;
drop table t1;
create table t1 select * from t2;
select a+0, b+0 from t1;
drop table t1, t2;
create table t1 (a int, b time, c tinyint, d bool, e char(10), f bit(1),
  g bit(1) NOT NULL default 1, h char(1) default 'a');
insert into t1 set a=1;
select hex(g), h from t1;
drop table t1;
create table t1 (a int, b time, c tinyint, d bool, e char(10), f bit(1),
  g bit(1) NOT NULL default 1);
insert into t1 set a=1;
select hex(g) from t1;
drop table t1;
create table t1 (a int, b time, c tinyint, d bool, e char(10), f bit(1),
  h char(1) default 'a') engine=myisam;
insert into t1 set a=1;
select h from t1;
drop table t1;
create table t1 (a bit(8)) engine=heap;
insert ignore into t1 values ('1111100000');
select a+0 from t1;
drop table t1;
create table t1 (a bit(7));
insert into t1 values (120), (0), (111);
select a+0 from t1 union select a+0 from t1;
select a+0 from t1 union select NULL;
select NULL union select a+0 from t1;
create table t2 select a from t1 union select a from t1;
select a+0 from t2;
drop table t1, t2;
create table t1 (id1 int(11), b1 bit(1));
create table t2 (id2 int(11), b2 bit(1));
insert into t1 values (1, 1), (2, 0), (3, 1);
insert into t2 values (2, 1), (3, 0), (4, 0);
create algorithm=undefined view v1 as
  select b1+0, b2+0 from t1, t2 where id1 = id2 and b1 = 0
  union
  select b1+0, b2+0 from t1, t2 where id1 = id2 and b2 = 1;
select * from v1;
drop table t1, t2;
drop view v1;
create table t1(a bit(4));
insert into t1(a) values (1), (2), (5), (4), (3);
insert into t1 select * from t1;
select a+0 from t1;
drop table t1;
create table t1 (a1 int(11), b1 bit(2));
create table t2 (a2 int(11), b2 bit(2));
insert into t1 values (1, 1), (2, 0), (3, 1), (4, 2);
insert into t2 values (2, 1), (3, 0), (4, 1), (5, 2);
select a1, a2, b1+0, b2+0 from t1 join t2 on a1 = a2;
select a1, a2, b1+0, b2+0 from t1 join t2 on a1 = a2 order by a1;
select a1, a2, b1+0, b2+0 from t1 join t2 on b1 = b2;
select sum(a1), b1+0, b2+0 from t1 join t2 on b1 = b2 group by b1 order by 1;
select 1 from t1 join t2 on b1 = b2 group by b1 order by 1;
select b1+0,sum(b1), sum(b2) from t1 join t2 on b1 = b2 group by b1 order by 1;
drop table t1, t2;
create table t1 (a bit(7));
insert into t1 values (0x60);
select * from t1;
drop table t1;
create table bug15583(b BIT(8), n INT);
insert into bug15583 values(128, 128);
insert into bug15583 values(null, null);
insert into bug15583 values(0, 0);
insert into bug15583 values(255, 255);
select hex(b), bin(b), oct(b), hex(n), bin(n), oct(n) from bug15583;
select hex(b)=hex(n) as should_be_onetrue, bin(b)=bin(n) as should_be_onetrue, oct(b)=oct(n) as should_be_onetrue from bug15583;
select hex(b + 0), bin(b + 0), oct(b + 0), hex(n), bin(n), oct(n) from bug15583;
select conv(b, 10, 2), conv(b + 0, 10, 2) from bug15583;
drop table bug15583;
create table t1(a bit(1), b smallint unsigned);
insert ignore into t1 (b, a) values ('2', '1');
select hex(a), b from t1;
drop table t1;
create table t1(bit_field bit(8), int_field int, key a(bit_field));
insert into t1 values (49,2);
drop table t1;
CREATE TABLE t1 (b BIT(2), a VARCHAR(5));
INSERT INTO t1 (b, a) VALUES (1, "x"), (3, "zz"), (0, "y"), (3, "z");
SELECT b+0, COUNT(DISTINCT a) FROM t1 GROUP BY b;
DROP TABLE t1;
CREATE TABLE t1 (a CHAR(5), b BIT(2));
INSERT INTO t1 (b, a) VALUES (1, "x"), (3, "zz"), (0, "y"), (3, "z");
SELECT b+0, COUNT(DISTINCT a) FROM t1 GROUP BY b;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b BIT(2));
INSERT INTO t1 (b, a) VALUES (1, 1), (3, 2), (0, 3), (3, 4);
SELECT b+0, COUNT(DISTINCT a) FROM t1 GROUP BY b;
DROP TABLE t1;
CREATE TABLE t1 (b BIT);
INSERT INTO t1 (b) VALUES (1), (0);
SELECT DISTINCT b FROM t1;
SELECT b FROM t1 GROUP BY b;
DROP TABLE t1;
CREATE TABLE t1 (a int, b bit(2));
INSERT INTO t1 VALUES (3, 2), (2, 3), (2, 0), (3, 2), (3, 1);
SELECT COUNT(DISTINCT b) FROM t1 GROUP BY a;
DROP TABLE t1;
create table t2 (a int, b bit(2), c char(10));
INSERT INTO t2 VALUES (3, 2, 'two'), (2, 3, 'three'), (2, 0, 'zero'),
                      (3, 2, 'two'), (3, 1, 'one');
SELECT COUNT(DISTINCT b,c) FROM t2 GROUP BY a;
DROP TABLE t2;
CREATE TABLE t1(a BIT(13), KEY(a));
INSERT IGNORE INTO t1(a) VALUES (65535),(65525),(65535),(65535),(65535),
                                (65535),(65535),(65535),(65535),(65535),
                                (65535),(65525),(65535),(65535),(65535),
                                (65535),(65535),(65535),(65535),(65535);
SELECT 1 FROM t1 GROUP BY a;
DROP TABLE t1;
CREATE TABLE t1 (b BIT NOT NULL, i2 INTEGER NOT NULL, s VARCHAR(255) NOT NULL);
INSERT INTO t1 VALUES(0x01,100,''), (0x00,300,''), (0x01,200,''), (0x00,100,'');
SELECT HEX(b), i2 FROM t1 WHERE (i2>=100 AND i2<201) AND b=TRUE;
CREATE TABLE t2 (b1 BIT NOT NULL, b2 BIT NOT NULL, i2 INTEGER NOT NULL,
                 s VARCHAR(255) NOT NULL);
INSERT INTO t2 VALUES (0x01,0x00,100,''), (0x00,0x01,300,''),
                      (0x01,0x00,200,''), (0x00,0x01,100,'');
SELECT HEX(b1), i2 FROM t2 WHERE (i2>=100 AND i2<201) AND b1=TRUE;
SELECT HEX(b2), i2 FROM t2 WHERE (i2>=100 AND i2<201) AND b2=FALSE;
SELECT HEX(b1), HEX(b2), i2 FROM t2
       WHERE (i2>=100 AND i2<201) AND b1=TRUE AND b2=FALSE;
DROP TABLE t1, t2;
CREATE TABLE IF NOT EXISTS t1 (
f1 bit(2) NOT NULL default b'10',
f2 bit(14) NOT NULL default b'11110000111100'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
INSERT INTO t1 (f1) VALUES (DEFAULT);
INSERT INTO t1 VALUES (b'', b'');
SELECT HEX(f1), HEX(f2) FROM t1;
DROP TABLE t1;
create table t1bit7 (a1 bit(7) not null) engine=MyISAM;
create table t2bit7 (b1 bit(7)) engine=MyISAM;
insert into t1bit7 values (b'1100000');
insert into t1bit7 values (b'1100001');
insert into t1bit7 values (b'1100010');
insert into t2bit7 values (b'1100001');
insert into t2bit7 values (b'1100010');
insert into t2bit7 values (b'1100110');
select bin(a1) from t1bit7, t2bit7 where t1bit7.a1=t2bit7.b1;
drop table t1bit7, t2bit7;
create table t1bit7 (a1 bit(15) not null) engine=MyISAM;
create table t2bit7 (b1 bit(15)) engine=MyISAM;
insert into t1bit7 values (b'110000011111111');
insert into t1bit7 values (b'110000111111111');
insert into t1bit7 values (b'110001011111111');
insert into t2bit7 values (b'110000111111111');
insert into t2bit7 values (b'110001011111111');
insert into t2bit7 values (b'110011011111111');
select bin(a1) from t1bit7, t2bit7 where t1bit7.a1=t2bit7.b1;
drop table t1bit7, t2bit7;
CREATE TABLE t1 (a BIT(7), b BIT(9), KEY(a, b));
INSERT INTO t1 VALUES(0, 0), (5, 3), (5, 6), (6, 4), (7, 0);
DROP TABLE t1;
create table t1(a bit(7));
insert into t1 values(0x40);
alter table t1 modify column a bit(8);
select hex(a) from t1;
insert into t1 values(0x80);
select hex(a) from t1;
create index a on t1(a);
insert into t1 values(0x81);
select hex(a) from t1;
drop table t1;
CREATE TABLE t1(a INT, b BIT(7) NOT NULL);
INSERT INTO t1 VALUES (NULL, 0),(NULL, 0);
SELECT SUM(a) FROM t1 GROUP BY b, a;
DROP TABLE t1;
CREATE TABLE t1(a INT, b BIT(7) NOT NULL, c BIT(8) NOT NULL);
INSERT INTO t1 VALUES (NULL, 0, 0),(NULL, 0, 0);
SELECT SUM(a) FROM t1 GROUP BY c, b, a;
DROP TABLE t1;
CREATE TABLE IF NOT EXISTS t1 (
f1 bit(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
INSERT INTO t1 VALUES (b'');
SELECT bin(f1) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a POINT) ENGINE=InnoDB;
INSERT INTO t1 VALUES();
CREATE TEMPORARY TABLE t2(a BIT(60)) ENGINE=InnoDB SELECT a FROM t1
GROUP BY a HAVING a IS NULL ORDER BY a DESC;
DROP TEMPORARY TABLE t2;
DROP TABLE t1;
select bin(0b11111111), oct(0b11111111), hex(0b11111111),
       bin(0xFF), oct(0xFF), hex(0xFF);