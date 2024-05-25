drop table if exists t1;
CREATE TABLE t1 (id CHAR(12) not null, PRIMARY KEY (id));
insert into t1 values ('000000000001'),('000000000002');
select * from t1 where id=000000000001;
delete from t1 where id=000000000002;
select * from t1;
drop table t1;
SELECT 'a' = 'a ';
SELECT 'a\0' < 'a';
SELECT 'a\0' < 'a ';
SELECT 'a\t' < 'a';
SELECT 'a\t' < 'a ';
CREATE TABLE t1 (a char(10) not null) charset latin1;
INSERT INTO t1 VALUES ('a'),('a\0'),('a\t'),('a ');
SELECT hex(a),STRCMP(a,'a'), STRCMP(a,'a ') FROM t1;
DROP TABLE t1;
SELECT CHAR(31) = '', '' = CHAR(31);
SELECT CHAR(30) = '', '' = CHAR(30);
create table t1 (a tinyint(1),b binary(1));
insert into t1 values (0x01,0x01);
select * from t1 where a=b;
select * from t1 where a=b and b=0x01;
drop table if exists t1;
CREATE TABLE  t1 (b int(2) zerofill, c int(2) zerofill);
INSERT INTO t1 (b,c) VALUES (1,2), (1,1), (2,2);
SELECT CONCAT(b,c), CONCAT(b,c) = '0101' FROM t1;
SELECT b,c FROM t1 WHERE b = 1 AND CONCAT(b,c) = '0101';
CREATE TABLE t2 (a int);
INSERT INTO t2 VALUES (1),(2);
SELECT a, 
  (SELECT COUNT(*) FROM t1 
   WHERE b = t2.a AND CONCAT(b,c) = CONCAT('0',t2.a,'01')) x 
FROM t2 ORDER BY a;
SELECT a, 
  (SELECT COUNT(*) FROM t1 
   WHERE b = t2.a AND CONCAT(b,c) = CONCAT('0',t2.a,'01')) x 
FROM t2 ORDER BY a;
DROP TABLE t1,t2;
CREATE TABLE t1 (a TIMESTAMP);
INSERT INTO t1 VALUES (NOW()),(NOW()),(NOW());
DROP TABLE t1;
CREATE TABLE t1(a INT ZEROFILL);
SELECT 1 FROM t1 WHERE t1.a IN (1, t1.a) AND t1.a=2;
DROP TABLE t1;
CREATE TABLE t1(a CHAR(10) CHARACTER SET utf32 COLLATE utf32_bin);
INSERT INTO t1 VALUES('a'),('b'),('c');
SELECT ROW('1', '1') > ROW(a, '1') FROM t1;
SELECT ROW(a, '1') > ROW('1', '1') FROM t1;
DROP TABLE t1;
CREATE TABLE t1(
  firstname CHAR(20),
  lastname CHAR(20)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
INSERT INTO t1 VALUES("john","doe"), ("John","Doe");
SELECT * FROM t1 WHERE firstname = 'john';
SELECT * FROM t1 WHERE firstname = 'john' COLLATE utf8mb4_0900_ai_ci;
SELECT * FROM t1 WHERE firstname = 'john' COLLATE utf8mb4_0900_as_cs;
SELECT * FROM t1
WHERE firstname = 'john' COLLATE utf8mb4_0900_ai_ci AND
      firstname = 'john' COLLATE utf8mb4_0900_as_cs;
SELECT * FROM t1
WHERE firstname = 'john' COLLATE utf8mb4_0900_as_cs AND
      firstname = 'john' COLLATE utf8mb4_0900_ai_ci;
DROP TABLE t1;
CREATE TABLE t(a DECIMAL(30,0));
INSERT INTO t VALUES(0);
SELECT * FROM t;
SELECT @maxint;
SELECT * FROM t WHERE a < @maxint;
SELECT * FROM t WHERE a < 18446744073709551615;
SELECT * FROM t WHERE 0 < 18446744073709551615;
SELECT * FROM t WHERE 0 < @maxint;
DROP TABLE t;
