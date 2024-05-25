PREPARE stmt FROM 'SELECT * FROM t1';
CREATE PROCEDURE proc6369()
  SELECT * FROM t1;
DROP PROCEDURE proc6369;
CREATE TABLE t2 (f2 int);
CREATE VIEW v1 AS SELECT t1.f1 FROM t1 JOIN t1 tt on t1.f1=tt.f1;
CREATE TABLE t3 (pk INT PRIMARY KEY);
INSERT INTO t3 SELECT DISTINCT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
SELECT f2 FROM v2;
UPDATE v2 SET f2=1;
INSERT INTO v2 VALUES(1);
INSERT INTO v2 SELECT 3 FROM t2;
SELECT f2 FROM v2;
DROP VIEW v1, v2;
DROP TABLE t1, t2, t3;
CREATE TABLE h2 (
pk int(11) NOT NULL AUTO_INCREMENT,
PRIMARY KEY (pk)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
insert into h2 values (1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE aa3 (
  col_int_key int(11) DEFAULT NULL,
  KEY col_int_key (col_int_key)
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
DROP TABLE h2, aa3;
CREATE TABLE t1 (
  pk int(11),
  col_int_key int(11) DEFAULT NULL,
  KEY col_int_key (col_int_key)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1 VALUES (NULL,NULL);
INSERT INTO t1 VALUES (6,NULL);
INSERT INTO t1 VALUES (8,-1131610112);
INSERT INTO t1 VALUES (2,-1009057792);
INSERT INTO t1 VALUES (-1220345856,1);
INSERT INTO t1 VALUES (NULL,-185204736);
DROP TABLE t1;
CREATE TABLE tbl1 (
  login int(11) NOT NULL,
  numb decimal(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (login),
  KEY numb (numb)
);
CREATE TABLE tbl2 (
  login int(11) NOT NULL,
  cmd tinyint(4) NOT NULL,
  nump decimal(15,2) NOT NULL DEFAULT '0.00',
  KEY cmd (cmd),
  KEY login (login)
);
insert into tbl1 (login) values(1),(2);
insert ignore into tbl2 (login) values(1),(2);
SELECT 
  t1.login AS tlogin, 
  numb - 
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) -
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) as sp
FROM tbl1 t1, tbl2 t2 
WHERE t1.login=t2.login 
GROUP BY t1.login 
ORDER BY numb - IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0)
              - IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0);
DROP TABLE tbl1, tbl2;
create table t1(a char(10) charset latin1, key(a)) engine=innodb;
create table t2(a binary(10), key(a)) engine=innodb;
insert into t1 values('1'),('2'),('3'),('4');
insert into t2 values('1'),('2'),('s');
DROP TABLE t1, t2;
create table t1(a int);
insert into t1 values(1),(2);
DROP TABLE t1;
DROP DATABASE mysqltest1;
