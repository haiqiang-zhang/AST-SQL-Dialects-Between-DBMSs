CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT, b INT AUTO_INCREMENT PRIMARY KEY);
INSERT INTO t1 VALUES (1);
SELECT * FROM t2 ORDER BY b;
DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT, b INT AUTO_INCREMENT PRIMARY KEY);
INSERT INTO t1 VALUES (1);
SELECT * FROM t2 ORDER BY b;
DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT, b INT AUTO_INCREMENT PRIMARY KEY);
INSERT INTO t1 VALUES (1);
SELECT * FROM t2 ORDER BY b;
UPDATE t1 SET a = 5;
SELECT * FROM t2 ORDER BY b;
DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT trigger_name, created, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT * FROM INFORMATION_SCHEMA.TRIGGERS
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT trigger_name, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
SELECT trigger_name, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT trigger_name, created, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT * FROM INFORMATION_SCHEMA.TRIGGERS
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT, b INT AUTO_INCREMENT PRIMARY KEY);
SELECT trigger_name, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
INSERT INTO t1 VALUES (1);
SELECT * FROM t2 ORDER BY b;
DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT, b INT AUTO_INCREMENT PRIMARY KEY);
SELECT trigger_name, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
INSERT INTO t1 VALUES (1);
SELECT * FROM t2 ORDER BY b;
DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TABLE t2 (a INT, b INT AUTO_INCREMENT PRIMARY KEY);
SELECT trigger_name, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
INSERT INTO t1 VALUES (1);
SELECT * FROM t2 ORDER BY b;
DROP TABLE t2;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT trigger_name, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT trigger_name, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT trigger_name, action_order FROM information_schema.triggers WHERE trigger_schema='test';
SELECT trigger_name, action_order FROM information_schema.triggers
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
SELECT * FROM INFORMATION_SCHEMA.TRIGGERS
  WHERE trigger_schema='test'
  ORDER BY trigger_name, action_order;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
