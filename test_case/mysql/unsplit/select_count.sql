CREATE TABLE t_innodb(c1 INT NOT NULL PRIMARY KEY,
                      c2 INT NOT NULL,
                      c3 char(20),
                      KEY c3_idx(c3))ENGINE=INNODB;
INSERT INTO t_innodb VALUES (1, 1, 'a'), (2,2,'a'), (3,3,'a');
CREATE TABLE t_myisam(c1 INT NOT NULL PRIMARY KEY,
                      c2 INT NOT NULL DEFAULT 1,
                      c3 char(20),
                      KEY c3_idx(c3)) ENGINE=MYISAM;
INSERT INTO t_myisam(c1) VALUES (1), (2);
CREATE TABLE t_nopk(c1 INT NOT NULL , c2 INT NOT NULL)ENGINE=INNODB;
INSERT INTO t_nopk SELECT c1, c2 FROM t_innodb;
CREATE INDEX c2_idx on t_nopk(c2);
DROP TABLE t_nopk;
CREATE TABLE t_innodb_nopk_sk(c1 INT NOT NULL,
                              c2 INT NOT NULL, KEY c2_idx(c2))ENGINE=INNODB;
CREATE TABLE t_innodb_pk_nosk(c1 INT NOT NULL PRIMARY KEY,
                              c2 INT NOT NULL)ENGINE=INNODB;
CREATE TABLE t_innodb_nopk_nosk(c1 INT NOT NULL,
                                c2 INT NOT NULL)ENGINE=INNODB;
INSERT INTO t_innodb_nopk_sk(c1,c2) VALUES (1, 1), (2,2), (3,3);
INSERT INTO t_innodb_pk_nosk(c1,c2) SELECT * FROM t_innodb_nopk_sk;
INSERT INTO t_innodb_nopk_nosk(c1,c2) SELECT * FROM t_innodb_nopk_sk;
DROP TABLE t_innodb_pk_nosk, t_innodb_nopk_sk, t_innodb_nopk_nosk;
CREATE TABLE t_heap(c1 INT NOT NULL PRIMARY KEY,
                      c2 INT NOT NULL,
                      c3 char(20)) ENGINE=HEAP;
CREATE TABLE t_archive(c1 INT NOT NULL, c2 char(20)) ENGINE=ARCHIVE;
INSERT INTO t_heap SELECT * FROM t_innodb WHERE c1 > 1;
INSERT INTO t_archive SELECT c1, c3 FROM t_innodb WHERE c1 > 1;
DROP TABLE t_archive, t_heap;
SELECT COUNT(*) FROM (SELECT DISTINCT c1 FROM t_myisam) dt, t_myisam;
SELECT 1 AS c1, (SELECT COUNT(*) FROM t_innodb HAVING c1 > 0) FROM DUAL;
SELECT 1 FROM t_innodb HAVING COUNT(*) > 1;
SELECT COUNT(*) c FROM t_innodb HAVING c > 1;
SELECT COUNT(*) c FROM t_innodb HAVING c > 7;
SELECT COUNT(*) c FROM t_innodb LIMIT 10 OFFSET 5;
DROP TABLE t_innodb, t_myisam;
