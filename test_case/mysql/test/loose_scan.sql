SELECT COUNT(DISTINCT c1) FROM t1;
DROP TABLE t1;
CREATE TABLE t0 (
  i1 INTEGER NOT NULL
);
INSERT INTO t0 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
                      (11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
                      (21),(22),(23),(24),(25),(26),(27),(28),(29),(30);
CREATE TABLE t1 (
  c1 CHAR(1) NOT NULL,
  i1 INTEGER NOT NULL,
  i2 INTEGER NOT NULL,
  PRIMARY KEY (c1,i1),
  UNIQUE KEY k1 (c1,i2)
) ENGINE=InnoDB, CHARSET utf8mb4;
INSERT INTO t1 SELECT 'A',i1,i1 FROM t0;
INSERT INTO t1 SELECT 'B',i1,i1 FROM t0;
INSERT INTO t1 SELECT 'C',i1,i1 FROM t0;
INSERT INTO t1 SELECT 'D',i1,i1 FROM t0;
INSERT INTO t1 SELECT 'E',i1,i1 FROM t0;
INSERT INTO t1 SELECT 'F',i1,i1 FROM t0;
select c1,count(distinct i2) from t1 group by c1;
DROP TABLE t0, t1;
CREATE TABLE t (a INT, b INT,KEY k(a,b));
INSERT INTO t VALUES (1,2),
       (NULL,3),(3,3),(1,NULL),
       (NULL,2), (NULL,NULL);
SELECT COUNT(DISTINCT a,b) FROM t;
SELECT COUNT(DISTINCT a,b) FROM t IGNORE INDEX (k);
DROP TABLE t;
CREATE TABLE t1 (
  pk INTEGER,
  col_int INTEGER,
  PRIMARY KEY (pk)
);
CREATE TABLE t2 (
  pk INTEGER,
  col_varchar_key VARCHAR(1),
  PRIMARY KEY (pk),
  KEY (col_varchar_key)
) CHARSET utf8mb4;
INSERT INTO t2 VALUES (1, 'g');
CREATE TABLE t3 (
  pk INTEGER,
  col_varchar_key VARCHAR(1),
  PRIMARY KEY (pk),
  KEY (col_varchar_key)
) CHARSET utf8mb4;
INSERT INTO t3 VALUES (1, 'v'),(2, NULL);
SELECT  t1.col_int
  FROM t1, t3
  WHERE  t3.col_varchar_key IN (
     SELECT t2.col_varchar_key FROM t2 WHERE t2.pk > t1.col_int
  );
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  a INTEGER NOT NULL
);
INSERT INTO t1 VALUES (2),(2);
CREATE TABLE t2 (
  b INTEGER
);
INSERT INTO t2 VALUES (2),(11),(11);
CREATE TABLE t3 (
  b INTEGER,
  pk INTEGER,
  KEY b_key (b)
);
INSERT INTO t3 VALUES (2,5);
CREATE TABLE t4 (
  pk INTEGER NOT NULL
);
INSERT INTO t4 VALUES (5),(7);
SELECT *
FROM t1
  JOIN t2 ON t1.a = t2.b
WHERE t2.b IN (
  SELECT t3.b
  FROM t3 JOIN t4 ON t3.pk = t4.pk
);
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (
  col_int INTEGER,
  col_varchar_key VARCHAR(1)
);
CREATE TABLE t2 (
  pk INTEGER,
  j JSON
);
INSERT INTO t2 VALUES (1,'true'),(2,'true'),(3,'true'),(4,'true'),(5,'true');
SELECT SUM(t1.col_int)
  FROM t1, t2
WHERE t2.j IN (
  SELECT t3.j FROM t2 JOIN t2 AS t3 ON t2.pk <> t3.pk
) AND t1.col_varchar_key='';
DROP TABLE t1, t2;
