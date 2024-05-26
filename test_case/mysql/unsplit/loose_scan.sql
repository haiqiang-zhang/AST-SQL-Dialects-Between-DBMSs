CREATE TABLE t1 (
  c1 CHAR(1) NOT NULL,
  i1 INTEGER NOT NULL,
  i2 INTEGER NOT NULL,
  PRIMARY KEY (c1,i1),
  UNIQUE KEY k1 (c1,i2)
) ENGINE=InnoDB, CHARSET utf8mb4;
INSERT INTO t1 VALUES ('A',0,999),('A',6,993),('A',12,987),
   ('A',18,981),('A',24,975),('A',30,969),('A',36,963),('A',42,957),
   ('A',48,951),('A',54,945),('A',60,939),('A',66,933),('A',72,927),
   ('A',78,921),('A',84,915),('A',90,909),('A',96,903),('A',102,897),
   ('A',108,891),('A',114,885),('A',120,879),('A',126,873),('A',132,867),
   ('A',138,861),('A',144,855),('A',150,849),('A',156,843),('A',162,837),
   ('A',168,831),('A',174,825),('A',180,819),('A',186,813),('A',192,807),
   ('A',198,801),('A',204,795),('B',210,789),('B',216,783),('B',222,777),
   ('B',228,771),('B',234,765),('B',240,759),('B',246,753),('B',252,747),
   ('B',258,741),('B',264,735),('B',270,729),('B',276,723),('B',282,717),
   ('B',288,711),('B',294,705),('B',300,699),('B',306,693),('B',312,687),
   ('B',318,681),('B',324,675),('B',330,669),('B',336,663),('B',342,657),
   ('B',348,651),('B',354,645),('B',360,639),('B',366,633),('B',372,627),
   ('B',378,621),('C',384,615),('C',390,609),('C',396,603),('C',402,597),
   ('C',408,591),('C',414,585),('C',420,579),('C',426,573),('C',432,567),
   ('C',438,561),('C',444,555),('C',450,549),('C',456,543),('C',462,537),
   ('C',468,531),('C',474,525),('C',480,519),('C',486,513),('C',492,507),
   ('C',498,501),('C',504,495),('C',510,489),('C',516,483),('C',522,477),
   ('C',528,471),('C',534,465),('C',540,459),('C',546,453),('C',552,447),
   ('C',558,441),('C',564,435),('C',570,429),('C',576,423),('C',582,417),
   ('C',588,411),('C',594,405);
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
