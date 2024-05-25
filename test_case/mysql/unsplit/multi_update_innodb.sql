CREATE TABLE t1(
  pk INT,
  a INT,
  b INT,
  PRIMARY KEY (pk)
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (0,0,0);
SELECT * FROM t1;
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT * FROM t1;
UPDATE t1 AS A, t1 AS B SET A.a = 1, B.b = 2;
SELECT * FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 ( 
  col_int_key int, 
  pk int, 
  col_int int, 
  key(col_int_key), 
  primary key (pk)
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1,2,3);
CREATE TABLE t2 ( 
  col_int_key int, 
  pk_1 int, 
  pk_2 int, 
  col_int int, 
  key(col_int_key), 
  primary key (pk_1,pk_2)
) ENGINE=InnoDB;
INSERT INTO t2 VALUES (1,2,3,4);
SELECT * FROM t1;
SELECT * FROM t2;
DROP TABLE t1,t2;
CREATE TABLE table_11757486 (field1 tinyint) ENGINE=INNODB;
INSERT INTO table_11757486 VALUES (0),(0);
UPDATE IGNORE (SELECT 128 as col1) x, table_11757486 SET field1=x.col1;
UPDATE IGNORE (SELECT 128 as col1) x, table_11757486 SET field1=x.col1;
DROP TABLE table_11757486;
CREATE TABLE t1(c1 INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (0),(0),(1);
CREATE TABLE t2(b INT) ENGINE=INNODB;
INSERT INTO t2 VALUES(0),(0);
DROP TABLE t1,t2;
CREATE TABLE t1 (c1 CHAR(255) NOT NULL);
CREATE TABLE t2 (c1 CHAR(255) NOT NULL, c2 CHAR(255) NOT NULL,
                 c3 CHAR(255) NOT NULL,  PRIMARY KEY (c1, c2, c3));
INSERT INTO t1 VALUES ('x'), ('x');
INSERT INTO t2 VALUES ('x', '', '');
UPDATE t1, t2 SET t2.c2 = 'y', t2.c3 = 'y' WHERE t2.c1 = t1.c1;
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1(c1 VARCHAR(350), c2 VARCHAR(350),
                c3 INT, PRIMARY KEY(c1,c2)) charset=utf8mb4;
INSERT INTO t1 VALUES ('a','a',1);
INSERT INTO t1 VALUES ('a','b',2);
INSERT INTO t1 VALUES ('a','c',3);
INSERT INTO t1 VALUES ('a','d',4);
INSERT INTO t1 VALUES ('a','e',5);
INSERT INTO t1 VALUES ('a','f',6);
INSERT INTO t1 VALUES ('a','g',7);
INSERT INTO t1 VALUES ('a','h',8);
INSERT INTO t1 VALUES ('a','i',9);
INSERT INTO t1 VALUES ('a','j',10);
INSERT INTO t1 VALUES ('a','k',11);
UPDATE t1 a, t1 b SET a.c3=22 WHERE a.c1 = b.c1;
SELECT COUNT(*) FROM t1 WHERE c3=22;
DROP TABLE t1;