CREATE TABLE abc(a, b, c);
SELECT sql FROM sqlite_master;
ALTER TABLE abc ADD d INTEGER;
SELECT sql FROM sqlite_master;
ALTER TABLE abc ADD e;
SELECT sql FROM sqlite_master;
CREATE TABLE main.t1(a, b);
ALTER TABLE t1 ADD c;
SELECT sql FROM sqlite_master WHERE tbl_name = 't1';
ALTER TABLE t1 ADD d CHECK (a>d);
SELECT sql FROM sqlite_master WHERE tbl_name = 't1';
CREATE TABLE t2(a, b, UNIQUE(a, b));
ALTER TABLE t2 ADD c REFERENCES t1(c);
SELECT sql FROM sqlite_master WHERE tbl_name = 't2' AND type = 'table';
CREATE TABLE t3(a, b, UNIQUE(a, b));
ALTER TABLE t3 ADD COLUMN c VARCHAR(10, 20);
SELECT sql FROM sqlite_master WHERE tbl_name = 't3' AND type = 'table';
DROP TABLE abc;
DROP TABLE t1;
DROP TABLE t3;
CREATE TABLE t1(a, b);
INSERT INTO t1 VALUES(1,2);
ALTER TABLE t1 ADD c NOT NULL DEFAULT 10;
CREATE VIEW v1 AS SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a, b);
INSERT INTO t1 VALUES(1, 100);
INSERT INTO t1 VALUES(2, 300);
SELECT * FROM t1;
PRAGMA schema_version = 10;
ALTER TABLE t1 ADD c;
SELECT * FROM t1;
PRAGMA schema_version;
SELECT * FROM t1;
PRAGMA schema_version = 20;
SELECT * FROM t1;
PRAGMA schema_version;
DROP TABLE t1;
CREATE TABLE t1(a, b);
INSERT INTO t1 VALUES(1, 'one');
INSERT INTO t1 VALUES(2, 'two');
ATTACH 'test2.db' AS aux;
PRAGMA aux.schema_version = 30;
SELECT sql FROM aux.sqlite_master;
SELECT sql FROM aux.sqlite_master;
SELECT * FROM aux.t1;
PRAGMA aux.schema_version;
ALTER TABLE aux.t1 ADD COLUMN d DEFAULT 1000;
SELECT sql FROM aux.sqlite_master;
SELECT * FROM aux.t1;
PRAGMA aux.schema_version;
SELECT * FROM t1;
DROP TABLE aux.t1;
DROP TABLE t1;
CREATE TABLE t1(a, b);
CREATE TABLE log(trig, a, b);
INSERT INTO t1 VALUES(1, 2);
SELECT * FROM log;
ALTER TABLE t1 ADD COLUMN c DEFAULT 'c';
INSERT INTO t1(a, b) VALUES(3, 4);
SELECT * FROM log;
VACUUM;
CREATE TABLE abc(a, b, c);
ALTER TABLE abc ADD d DEFAULT NULL;
ALTER TABLE abc ADD e DEFAULT 10;
ALTER TABLE abc ADD f DEFAULT NULL;
VACUUM;
CREATE TABLE t4(c1);
ALTER TABLE t4 ADD c2;
ALTER TABLE t4 ADD c3;
ALTER TABLE t4 ADD c4;
ALTER TABLE t4 ADD c5;
ALTER TABLE t4 ADD c6;
ALTER TABLE t4 ADD c7;
ALTER TABLE t4 ADD c8;
ALTER TABLE t4 ADD c9;
ALTER TABLE t4 ADD c10;
ALTER TABLE t4 ADD c11;
ALTER TABLE t4 ADD c12;
ALTER TABLE t4 ADD c13;
ALTER TABLE t4 ADD c14;
ALTER TABLE t4 ADD c15;
ALTER TABLE t4 ADD c16;
ALTER TABLE t4 ADD c17;
ALTER TABLE t4 ADD c18;
ALTER TABLE t4 ADD c19;
ALTER TABLE t4 ADD c20;
ALTER TABLE t4 ADD c21;
ALTER TABLE t4 ADD c22;
ALTER TABLE t4 ADD c23;
ALTER TABLE t4 ADD c24;
ALTER TABLE t4 ADD c25;
ALTER TABLE t4 ADD c26;
ALTER TABLE t4 ADD c27;
ALTER TABLE t4 ADD c28;
ALTER TABLE t4 ADD c29;
ALTER TABLE t4 ADD c30;
ALTER TABLE t4 ADD c31;
ALTER TABLE t4 ADD c32;
ALTER TABLE t4 ADD c33;
ALTER TABLE t4 ADD c34;
ALTER TABLE t4 ADD c35;
ALTER TABLE t4 ADD c36;
ALTER TABLE t4 ADD c37;
ALTER TABLE t4 ADD c38;
ALTER TABLE t4 ADD c39;
ALTER TABLE t4 ADD c40;
ALTER TABLE t4 ADD c41;
ALTER TABLE t4 ADD c42;
ALTER TABLE t4 ADD c43;
ALTER TABLE t4 ADD c44;
ALTER TABLE t4 ADD c45;
ALTER TABLE t4 ADD c46;
ALTER TABLE t4 ADD c47;
ALTER TABLE t4 ADD c48;
ALTER TABLE t4 ADD c49;
ALTER TABLE t4 ADD c50;
ALTER TABLE t4 ADD c51;
ALTER TABLE t4 ADD c52;
ALTER TABLE t4 ADD c53;
ALTER TABLE t4 ADD c54;
ALTER TABLE t4 ADD c55;
ALTER TABLE t4 ADD c56;
ALTER TABLE t4 ADD c57;
ALTER TABLE t4 ADD c58;
ALTER TABLE t4 ADD c59;
ALTER TABLE t4 ADD c60;
ALTER TABLE t4 ADD c61;
ALTER TABLE t4 ADD c62;
ALTER TABLE t4 ADD c63;
ALTER TABLE t4 ADD c64;
ALTER TABLE t4 ADD c65;
ALTER TABLE t4 ADD c66;
ALTER TABLE t4 ADD c67;
ALTER TABLE t4 ADD c68;
ALTER TABLE t4 ADD c69;
ALTER TABLE t4 ADD c70;
ALTER TABLE t4 ADD c71;
ALTER TABLE t4 ADD c72;
ALTER TABLE t4 ADD c73;
ALTER TABLE t4 ADD c74;
ALTER TABLE t4 ADD c75;
ALTER TABLE t4 ADD c76;
ALTER TABLE t4 ADD c77;
ALTER TABLE t4 ADD c78;
ALTER TABLE t4 ADD c79;
ALTER TABLE t4 ADD c80;
ALTER TABLE t4 ADD c81;
ALTER TABLE t4 ADD c82;
ALTER TABLE t4 ADD c83;
ALTER TABLE t4 ADD c84;
ALTER TABLE t4 ADD c85;
ALTER TABLE t4 ADD c86;
ALTER TABLE t4 ADD c87;
ALTER TABLE t4 ADD c88;
ALTER TABLE t4 ADD c89;
ALTER TABLE t4 ADD c90;
ALTER TABLE t4 ADD c91;
ALTER TABLE t4 ADD c92;
ALTER TABLE t4 ADD c93;
ALTER TABLE t4 ADD c94;
ALTER TABLE t4 ADD c95;
ALTER TABLE t4 ADD c96;
ALTER TABLE t4 ADD c97;
ALTER TABLE t4 ADD c98;
ALTER TABLE t4 ADD c99;
SELECT sql FROM sqlite_master WHERE name = 't4';
ALTER TABLE t1 ADD COLUMN d AS (b+1) NOT NULL;
CREATE TEMP TABLE t0(m,n);
INSERT INTO t0 VALUES(1, 2), ('null!',NULL), (3,4);
ATTACH ':memory:' AS aux1;
CREATE TABLE aux1.t2(x,y);
