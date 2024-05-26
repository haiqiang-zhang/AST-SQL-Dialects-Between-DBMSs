drop table if exists t1;
select 0x41,0x41+0,0x41 | 0x7fffffffffffffff | 0,0xffffffffffffffff | 0;
select 0x31+1,concat(0x31)+1,-0xf;
select x'31',X'ffff'+0;
create table t1 (ID int(8) unsigned zerofill not null auto_increment,UNIQ bigint(21) unsigned zerofill not null,primary key (ID),unique (UNIQ) );
insert into t1 set UNIQ=0x38afba1d73e6a18a;
insert into t1 set UNIQ=123;
drop table t1;
create table t1 select 1 as x, 2 as xx;
select x,xx from t1;
drop table t1;
drop table if exists table_28127_a;
drop table if exists table_28127_b;
create table table_28127_a(0b02 int);
create table table_28127_b(0b2 int);
drop table table_28127_a;
drop table table_28127_b;
select 0b01000001;
select 0x41;
select b'01000001';
select x'41', 0+x'41';
select N'abc', length(N'abc');
select b'', 0+b'';
select x'', 0+x'';
create TABLE t1(a INT, b VARBINARY(4), c VARBINARY(4));
INSERT INTO t1 VALUES
(1, 0x31393831, 0x31303037),
(2, 0x31393832, 0x31303038),
(3, 0x31393833, 0x31303039),
(3, 0x31393834, 0x31393831),
(4, 0x31393835, 0x31393832),
(5, 0x31393836, 0x31303038);
SELECT
hex(b & c), hex(b & 0x31393838), b & NULL, hex(b & 0b00000000000000000000000000001011),
hex(0x31393838 & b), NULL & b, hex(0b00000000000000000000000000001011 & b)
FROM t1;
SELECT BIT_COUNT(b), HEX(~b), HEX(b << 1), HEX(b >> 1) from t1;
SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
CREATE PROCEDURE test_bin_op()
SELECT
HEX(b & c), HEX(b & 0x31393838), b & NULL, HEX(b & 0b00000000000000000000000000001011),
HEX(0x31393838 & b), NULL & b, HEX(0b00000000000000000000000000001011 & b),
HEX(b | c), HEX(b | 0x31393838), b | NULL, HEX(b | 0b00000000000000000000000000001011),
HEX(0x31393838 | b), NULL | b, HEX(0b00000000000000000000000000001011 | b),
HEX(b ^ c), HEX(b ^ 0x31393838), b ^ NULL, HEX(b ^ 0b00000000000000000000000000001011),
HEX(0x31393838 ^ b), NULL ^ b, HEX(0b00000000000000000000000000001011 ^ b),
BIT_COUNT(b), HEX(~b), HEX(b << 1), HEX(b >> 1)
FROM t1;
DROP PROCEDURE test_bin_op;
CREATE PROCEDURE test_bin_op()
SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
DROP PROCEDURE test_bin_op;
CREATE PROCEDURE test_bin_op()
SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1;
DROP PROCEDURE test_bin_op;
PREPARE s2 from "SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a";
PREPARE s2 from "SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1";
CREATE VIEW v1 AS
SELECT
HEX(b & c), HEX(b & 0x31393838), b & NULL, HEX(b & 0b00000000000000000000000000001011),
HEX(0x31393838 & b), NULL & b, HEX(0b00000000000000000000000000001011 & b),
HEX(b | c), HEX(b | 0x31393838), b | NULL, HEX(b | 0b00000000000000000000000000001011),
HEX(0x31393838 | b), NULL | b, HEX(0b00000000000000000000000000001011 | b),
HEX(b ^ c), HEX(b ^ 0x31393838), b ^ NULL, HEX(b ^ 0b00000000000000000000000000001011),
HEX(0x31393838 ^ b), NULL ^ b, HEX(0b00000000000000000000000000001011 ^ b),
BIT_COUNT(b), HEX(~b), HEX(b << 1), HEX(b >> 1)
FROM t1;
SELECT * from v1;
SELECT * from v1;
CREATE VIEW v2 AS
SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
SELECT * from v2;
SELECT * from v2;
CREATE VIEW v3 AS
SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1;
SELECT * from v3;
SELECT * from v3;
DROP VIEW v1,v2,v3;
SELECT
a & 0x31393838, 0x31393838 & a, 0x31393838 & 0x31393838, 0x31393838 & NULL,
0x31393838 & 0b1011, NULL & 0x31393838, 0b1011 & 0x31393838, NULL & NULL,
NULL & 0b1011, 0b1011 & NULL, 0b1011 & 0b1011, BIT_COUNT(a)
FROM t1;
SELECT
a | 0x31393838, 0x31393838 | a, 0x31393838 | 0x31393838, 0x31393838 | NULL,
0x31393838 | 0b1011, NULL | 0x31393838, 0b1011 | 0x31393838, NULL | NULL,
NULL | 0b1011, 0b1011 | NULL, 0b1011 | 0b1011
FROM t1;
SELECT
a ^ 0x31393838, 0x31393838 ^ a, 0x31393838 ^ 0x31393838, 0x31393838 ^ NULL,
0x31393838 ^ 0b1011, NULL ^ 0x31393838, 0b1011 ^ 0x31393838, NULL ^ NULL,
NULL ^ 0b1011, 0b1011 ^ NULL, 0b1011 ^ 0b1011
FROM t1;
SELECT a, BIT_AND(a), BIT_OR(a), BIT_XOR(a),
~NULL, NULL << 1, NULL >> 1, 1 << NULL, 1 >> NULL,
~0x31393838, 0x31393838 << 1, 0x31393838 >> 1,
~0b1011, 0b1011 << 1, 0b1011 >> 1
FROM t1
GROUP BY a;
SELECT '12' | '12';
SELECT _binary '12' | '12';
SELECT _binary '12' | _binary '12';
SELECT _binary '12' | 0x0001;
SELECT _binary '12' | 1;
SELECT binary '12' | '12';
SELECT binary '12' | binary '12';
SELECT binary '12' | 0x0001;
SELECT binary '12' | 1;
SELECT '12' | 0x01;
SELECT '12' | 1;
SELECT CAST('12' AS binary) | 0x0001;
SELECT CAST('12' AS binary) | 1;
SELECT (b + 0) | 0x31393838 FROM t1 LIMIT 1;
SELECT 0x01 << 1;
SELECT _binary '12' << 1;
SELECT binary '12' << 1;
SELECT CAST('12' AS binary) << 1;
SELECT CAST(b AS char) << 1 FROM t1 LIMIT 1;
SELECT CAST(b AS unsigned) << 1 FROM t1 LIMIT 1;
SELECT (b + 0) << 1 FROM t1 LIMIT 1;
SELECT CAST(b AS unsigned) | CAST(c AS unsigned) FROM t1 LIMIT 1;
DROP TABLE t1;
PREPARE ps FROM 'SELECT (~?)';
SELECT (_binary x'31' | x'31');
SELECT _binary '1' + 0;
SELECT (_binary x'31' | x'31') + 0;
SELECT 1.0 * (_binary x'312E35' | x'312E35');
SELECT 1.0 * (x'312E35' | x'312E35');
SELECT (_binary x'31' | NULL) + 0;
SELECT CONCAT("", (0x39 | NULL));
SELECT ~(CONCAT ("", NULL));
SELECT DATEDIFF((_binary '2012-05-19 09:06:07' | _binary '2012-05-19 09:06:07'), '2012-05-21 09:06:07');
SELECT SUBTIME((_binary '2012-05-19 09:06:07' | _binary '2012-05-19 09:06:07'),'1 1:1:1.000002');
CREATE TABLE t1(gid INT, a VARBINARY(20), b BIGINT);
INSERT INTO t1 VALUES(1, _binary '2012-05-19 09:06:07', 20120519090607),
(1, _binary '2012-05-19 09:06:07', 20120519090607),
(2, _binary '12012-05-19 09:06:07', 120120519090607),
(2, _binary '12012-05-19 09:06:07', 120120519090607);
DROP TABLE t1;
CREATE TABLE t1(vb varbinary(10), i INT, d DECIMAL(5,2), f FLOAT(5,2), dd DOUBLE(5,2), gid INT);
INSERT INTO t1 VALUES (_binary "-98765.23", 98765, 0.0, 0.0, 0.0, 1);
INSERT INTO t1 VALUES (_binary "-98765.23", 98765, 1.0, 1.0, 1.0, 2);
SELECT
d * (vb | vb) , f * (vb | vb), dd * (vb | vb),
(vb | vb) / d , (vb | vb) / f, (vb | vb) / dd,
d * (i | i) , f * (i | i), dd * (i | i),
(i | i) / d , (i | i) / f, (i | i) / dd
FROM t1 WHERE gid = 2;
drop table t1;
