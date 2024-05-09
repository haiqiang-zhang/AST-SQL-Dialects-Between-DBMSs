CREATE TABLE ten (a INTEGER);
INSERT INTO ten VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE hundred (a INTEGER);
INSERT INTO hundred
SELECT a1.a + 10 * a2.a FROM ten a1, ten a2;
CREATE TABLE thousand (a INTEGER);
INSERT INTO thousand
SELECT a1.a + 10 * a2.a + 100 * a3.a FROM ten a1, ten a2, ten a3;
CREATE TABLE t1 (
  pk INTEGER NOT NULL,
  i1 INTEGER NOT NULL,
  c1 VARCHAR(10) NOT NULL,
  PRIMARY KEY (pk)
) charset latin1;
INSERT INTO t1
  SELECT a, 1, 'MySQL' FROM thousand;
CREATE TABLE t2 (
  pk INTEGER NOT NULL,
  c1 VARCHAR(10) NOT NULL,
  c2 varchar(10) NOT NULL,
  PRIMARY KEY (pk)
) charset latin1;
INSERT INTO t2
  SELECT a, 'MySQL', 'MySQL' FROM ten;
CREATE TABLE t3 (
  pk INTEGER NOT NULL,
  c1 VARCHAR(10) NOT NULL,
  PRIMARY KEY (pk)
) charset latin1;
INSERT INTO t3
  SELECT a, 'MySQL' FROM hundred;
CREATE TABLE t4 (
  pk int(11) NOT NULL,
  c1_key varchar(10) CHARACTER SET utf8mb3 NOT NULL,
  c2 varchar(10) NOT NULL,
  c3 varchar(10) NOT NULL,
  PRIMARY KEY (pk),
  KEY k1 (c1_key)
) charset latin1;
CREATE TABLE t5 (
  pk INTEGER NOT NULL,
  c1 VARCHAR(10) NOT NULL,
  PRIMARY KEY (pk)
) charset latin1;
INSERT INTO t5
  SELECT a, 'MySQL' FROM ten;
DROP TABLE ten, hundred, thousand;
DROP TABLE t1, t2, t3, t4, t5;
