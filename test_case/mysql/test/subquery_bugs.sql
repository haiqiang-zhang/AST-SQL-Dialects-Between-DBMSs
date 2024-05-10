CREATE TABLE t1 (
  pk int NOT NULL,
  col_int_key int DEFAULT NULL,
  col_int int DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
);
INSERT INTO t1 VALUES (10,7,5,'l'), (12,7,4,'o');
CREATE TABLE t2 (
  col_date_key date DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_time time DEFAULT NULL,
  pk int NOT NULL,
  col_date date DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_int int DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_date_key (col_date_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key),
  KEY col_time_key (col_time_key)
);
INSERT INTO t2(col_int_key,col_varchar_key,col_varchar,pk,col_int)  VALUES
 (8,'a','w',1,5),
 (9,'y','f',7,0),
 (9,'z','i',11,9),
 (9,'r','s',12,3),
 (7,'n','i',13,6),
 (9,'j','v',17,9),
 (240,'u','k',20,6);
CREATE TABLE t3 (
  col_int int DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  pk int NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
);
INSERT INTO t3 VALUES (8,4,1);
SELECT table2.col_int_key AS field1
FROM (SELECT sq1_t1.*
      FROM t1 AS sq1_t1 RIGHT OUTER JOIN t2 AS sq1_t2
           ON sq1_t2.col_varchar_key = sq1_t1.col_varchar
     ) AS table1
     LEFT JOIN t1 AS table2
       RIGHT JOIN t2 AS table3
       ON table3.pk = table2.col_int_key
     ON table3.col_int_key = table2.col_int
WHERE table3.col_int_key >= ALL
   (SELECT sq2_t1.col_int AS sq2_field1
    FROM t2 AS sq2_t1 STRAIGHT_JOIN t3 AS sq2_t2
         ON sq2_t2.col_int = sq2_t1.pk AND
            sq2_t1.col_varchar IN
       (SELECT sq21_t1.col_varchar AS sq21_field1
        FROM t2 AS sq21_t1 STRAIGHT_JOIN t1 AS sq21_t2
             ON sq21_t2.col_int_key = sq21_t1.pk
        WHERE sq21_t1.pk = 7
       )
    WHERE sq2_t2.col_int_key >= table2.col_int AND
          sq2_t1.col_int_key <= table2.col_int_key
   );
DROP TABLE t1, t2, t3;
CREATE TABLE t1(k VARCHAR(10) PRIMARY KEY);
CREATE TABLE t2(k VARCHAR(10) PRIMARY KEY);
SELECT (SELECT 'X' FROM t2
        WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX'
FROM t1
WHERE k ='X';
SELECT (SELECT 'X' FROM t2
        WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX'
FROM t1
WHERE k ='X';
SELECT (SELECT 'X' FROM t2
        WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX'
FROM t1
WHERE k ='X';
SELECT (SELECT 'X' FROM t2
        WHERE t2.k = CONCAT(t1.k, 'X')) = 'XXX'
FROM t1
WHERE k ='X';
DROP TABLE t1,t2;
CREATE TABLE a(d INT,e BIGINT, KEY(e));
INSERT a VALUES (0,0);
CREATE TABLE b(f TIME);
INSERT b VALUES (null),(null),(null);
CREATE TABLE c(g DATETIME(6) NOT NULL);
INSERT c(g) VALUES (now()+interval 1 day);
INSERT c(g) VALUES (now()-interval 1 day);
DROP TABLES a, b, c;
CREATE TABLE p (Id INT,PRIMARY KEY (Id));
INSERT INTO p VALUES (1);
CREATE TABLE s (Id INT, u INT, UNIQUE KEY o(Id, u) );
INSERT INTO s VALUES (1, NULL),(1, NULL);
CREATE TABLE s1 (Id INT, u INT, UNIQUE KEY o(Id, u) );
INSERT INTO s1 VALUES (1, 2),(1, 3);
CREATE TABLE s2 (Id INT, u INT, KEY o(Id, u) );
INSERT INTO s2 VALUES (1, NULL),(1, NULL);
CREATE TABLE s3 (Id INT NOT NULL, u INT NOT NULL, UNIQUE KEY o(Id, u));
INSERT INTO s3 VALUES (1, 2),(1, 3);
DROP TABLE p, s, s1, s2, s3;
CREATE TABLE t1 (f1 varchar(1) DEFAULT NULL);
INSERT INTO t1 VALUES ('5');
CREATE TABLE t2 (f1 varchar(1) DEFAULT NULL);
INSERT INTO t2 VALUES ('Y');
PREPARE prep_stmt FROM "SELECT t2.f1 FROM (t2 LEFT JOIN t1
 ON (1 = ANY (SELECT f1 FROM t1 WHERE 1 IS NULL)))";
DROP TABLE t1,t2;
CREATE TABLE t1 (f1 varchar(1) DEFAULT NULL);
INSERT INTO t1 VALUES ('Z');
CREATE TABLE t2 (f1 varchar(1) DEFAULT NULL);
INSERT INTO t2 VALUES ('Z');
PREPARE prep_stmt FROM "
SELECT t2.f1 FROM t2 LEFT OUTER JOIN
(SELECT  * FROM t2 WHERE ('y',1)
 IN (SELECT alias1.f1 , 0 FROM t1 AS alias1 LEFT JOIN t2 ON 0)) AS alias ON 0";
PREPARE prep_stmt FROM "
SELECT t2.f1 FROM (t2 LEFT OUTER JOIN (SELECT  * FROM t2 WHERE ('y',1)
 IN (SELECT alias1.f1 , 0 FROM
     (t1 INNER JOIN  (t1 AS alias1 LEFT JOIN t2 ON 0) ON 0))) AS alias ON 0)";
DROP TABLE t1,t2;
CREATE TABLE t1 (cv VARCHAR(1) DEFAULT NULL);
INSERT INTO t1 VALUES ('h'), ('Q'), ('I'), ('q'), ('W');
SELECT cv
FROM t1
WHERE EXISTS (SELECT alias1.cv AS field1
              FROM t1 AS alias1 RIGHT JOIN t1 AS alias2
                   ON alias1.cv = alias2.cv
             );
DROP TABLE t1;
CREATE TABLE t1 (col_varchar_key varchar(1) DEFAULT NULL);
SELECT *
FROM t1
WHERE col_varchar_key IN
       (SELECT col_varchar_key
        FROM t1
        WHERE col_varchar_key =
              (SELECT col_varchar_key
               FROM t1
               WHERE col_varchar_key > @var1
              )
       );
DROP TABLE t1;
CREATE TABLE t1 (
  pk integer NOT NULL PRIMARY KEY,
  f1 varchar(1),
  KEY k1 (f1)
);
CREATE TABLE t2 ( pk integer NOT NULL PRIMARY KEY );
CREATE VIEW v2 AS select * FROM t2;
INSERT INTO t1 VALUES (1, 'G');
INSERT INTO t1 VALUES (2, 'j');
INSERT INTO t1 VALUES (3, 'K');
INSERT INTO t1 VALUES (4, 'v');
INSERT INTO t1 VALUES (5, 'E');
DROP TABLE t1, t2;
DROP VIEW v2;
CREATE TABLE t1 (
  f1 varchar(1),
  KEY k1 (f1)
);
INSERT INTO t1 VALUES ('6'),('6');
DROP TABLE t1;
CREATE TABLE t1 (
  pk integer PRIMARY KEY,
  f1 integer,
  f2 varchar(1)
);
INSERT INTO t1 VALUES (1,100,'x'),(2,200,'y');
CREATE TABLE t2 (
  f2 varchar(1)
);
DROP TABLE t1, t2;
CREATE TABLE t1 (f1 varchar(1));
INSERT INTO t1 VALUES ('5');
CREATE TABLE t2 (f1 varchar(1));
INSERT INTO t2 VALUES ('Y');
PREPARE prep_stmt FROM "SELECT t2.f1 FROM (t2 LEFT JOIN t1
 ON 1 IN (SELECT f1 FROM t1 WHERE FALSE))";
DROP TABLE t1,t2;
CREATE TABLE t1 (
 pk INTEGER,
 col_int_key INTEGER,
 col_datetime_gckey DATETIME,
 col_time_gckey TIME,
 col_varchar_key VARCHAR(15)
);
CREATE TABLE t2 (
 pk INTEGER,
 col_int_key INTEGER,
 col_varchar_key VARCHAR(15)
);
SELECT alias1.col_time_gckey AS field1,
       alias1.col_datetime_gckey AS field2
FROM t1 AS alias1,
     (SELECT DISTINCT sq1_alias2.*
      FROM t1 AS sq1_alias1, t1 AS sq1_alias2
     ) AS alias2,
     (SELECT sq2_alias1.*
      FROM t1 AS sq2_alias1 RIGHT OUTER JOIN
             t1 AS sq2_alias2 INNER JOIN t2 AS sq2_alias3
             ON sq2_alias3.col_int_key = sq2_alias2.col_int_key
           ON sq2_alias3.col_varchar_key = sq2_alias2.col_varchar_key
     ) AS alias3
WHERE alias2.col_int_key = SOME
       (WITH qn AS
        (SELECT sq3_alias1.pk AS sq3_field1
         FROM t1 AS sq3_alias1
         WHERE sq3_alias1.col_int_key = alias3.pk
        )
        SELECT /*+ MERGE(qn) */ * FROM qn
       );
DROP TABLE t1, t2;
CREATE TABLE t1 (
  pk INTEGER
);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (
  pk INTEGER PRIMARY KEY
);
INSERT INTO t2 VALUES(1);
CREATE TABLE t3 (
  col_int_key INTEGER,
  pk INTEGER
);
INSERT INTO t3 VALUES (31,4),(2,5),(17,3),(5,2),(17,1);
CREATE TABLE t4 (
  col_int_key INTEGER,
  col_int_unique INTEGER,
  UNIQUE KEY ix2 (col_int_key,col_int_unique)
);
INSERT INTO t4 VALUES (6,2),(34,3);
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 ( pk integer, f1 varchar(1) );
INSERT INTO t1 VALUES (1,'D'), (20,'G');
SELECT d0.f1, d0.pk, t1.pk, t1.f1 FROM ( SELECT DISTINCT * FROM t1 ) AS d0 LEFT JOIN t1 ON d0.pk IN ( SELECT 1 FROM t1 ) ORDER BY d0.f1;
DROP TABLE t1;
CREATE TABLE t1(a TINYBLOB);
INSERT INTO t1 VALUES('aaa'),('bbb'),(''),('ccc');
DROP TABLE t1;
CREATE TABLE t1(a DATETIME(2));
INSERT INTO t1 VALUES(NOW(2)),(NOW(2));
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(2),(3);
DROP TABLE t1;
CREATE TABLE t1 (vc varchar(1) NOT NULL);
CREATE VIEW v1 AS SELECT * FROM t1 WHERE 5 IN (SELECT 1) IS UNKNOWN;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 (
  field1 integer
);
INSERT INTO t1 VALUES (13);
CREATE TABLE t2 (
  field2 integer
);
INSERT INTO t2 VALUES (18);
CREATE TABLE t3 (
  field3 integer
);
INSERT INTO t3 VALUES (1);
UPDATE t3 SET field3 = 9 WHERE field3 IN (
  SELECT 1
  FROM ( SELECT * FROM t2 ) AS alias1
  WHERE EXISTS ( SELECT * FROM t1 WHERE field1 <> alias1.field2 )
);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  f1 integer NOT NULL PRIMARY KEY,
  f2 varchar(1),
  KEY f2_idx (f2)
);
INSERT INTO t1 VALUES (20,'2');
DROP TABLE t1;
CREATE TABLE t1 (
  pk int NOT NULL,
  col_int int,
  col_time_key time,
  col_varchar_key varchar(1),
  PRIMARY KEY (pk),
  KEY idx_CC_col_time_key (col_time_key),
  KEY idx_CC_col_varchar_key (col_varchar_key)
);
INSERT INTO t1 VALUES
 (1,1244696008,'15:54:41','u'),
 (2,893471119,'16:03:34','e'),
 (3,462275345,'06:57:11','g'),
 (4,2067212400,'06:56:19','E'),
 (5,-270339471,'03:38:07','d'),
 (6,-734590502,'03:18:29','Q'),
 (7,-1230000720,'15:56:21','C'),
 (8,-1086526061,'19:08:49','B'),
 (9,-1620913518,'22:44:04','3'),
 (10,1210237478,'11:18:51','i'),
 (11,-886894023,'20:28:00','A'),
 (12,-1490912666,'17:51:14','H'),
 (13,149282252,'16:51:14','Z'),
 (14,1451237940,'09:13:29','L'),
 (15,1933327447,'11:14:05','2'),
 (16,-693463421,'05:29:04','V'),
 (17,333204980,'16:24:13','O'),
 (18,279626907,'09:45:54','t'),
 (19,-1372487638,'17:45:04','a'),
 (20,-150563684,'15:32:40','D');
SELECT table2.col_time_key AS field1
FROM t1 AS table1 LEFT JOIN t1 AS table2
     ON table1.col_varchar_key = table2.col_varchar_key
WHERE 1 IN (SELECT 1 FROM t1 AS subq
            WHERE subq.pk <= (SELECT DISTINCT MIN(subq.col_int)
                              FROM t1 as alias1
                             )
           );
DROP TABLE t1;
CREATE TABLE t1 (
pk int NOT NULL,
col_int int DEFAULT NULL
);
CREATE TABLE t2 (
pk int NOT NULL,
col_int int DEFAULT NULL
);
INSERT INTO t2 VALUES (1, 2);
PREPARE st FROM
"DELETE outr1.*
 FROM t1 AS outr1 RIGHT OUTER JOIN t2 AS outr2
      ON outr1.col_int = outr2.col_int
 WHERE (0, 3) NOT IN (SELECT innr1.pk AS x, innr1.col_int AS y
                      FROM t2 AS innr1
                      WHERE outr1.col_int = 25)";
DEALLOCATE PREPARE st;
DROP TABLE t1, t2;
CREATE TABLE t1 (
  f1 INTEGER
);
INSERT INTO t1 VALUES (1), (2), (3);
CREATE TABLE t2 (
  f2 VARCHAR(10)
);
CREATE TABLE t3 (
  f3 INTEGER UNIQUE NOT NULL
);
CREATE TABLE t4 (
  f4 INTEGER
);
INSERT INTO t4 VALUES (13), (14), (NULL);
SELECT * FROM t1
  WHERE NOT EXISTS (
     SELECT *
     FROM t4 LEFT JOIN t3 ON t4.f4 = t3.f3
     WHERE 'abc' IN (
        SELECT t2.f2 FROM t2 WHERE t3.f3 = 1 HAVING t2.f2 = 'xyz'
     )
   );
DROP TABLE t1, t2, t3, t4;
CREATE TABLE table_city (id int NOT NULL PRIMARY KEY);
CREATE TABLE table_user (id int NOT NULL PRIMARY KEY);
CREATE TABLE table_city_user (city int NOT NULL, user int NOT NULL, KEY city (city));
INSERT INTO table_city (id) VALUES (1),(2),(3),(4),(5),(6);
INSERT INTO table_user (id) VALUES (1),(2),(3),(4),(5),(6),(7),(8);
INSERT INTO table_city_user (city, user) VALUES
  (1,1),(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(2,1),(2,2),(2,3),(2,4),
  (2,5),(3,2),(3,5),(4,5),(4,2),(4,3),(4,8),(4,1);
SELECT id, (
    SELECT GROUP_CONCAT(id) FROM (
      SELECT table_user.id FROM table_user WHERE id IN (
        SELECT user FROM table_city_user WHERE table_city_user.city = table_city.id
      )
      GROUP BY table_user.id
    ) AS d
  ) AS users FROM table_city;
DROP TABLE table_city, table_user, table_city_user;
CREATE TABLE b (c INTEGER, KEY idx_b (c));
CREATE TABLE c (c INTEGER, KEY idx_c (c));
CREATE TABLE d (c INTEGER, KEY idx_d (c));
INSERT INTO b VALUES (1), (2);
INSERT INTO c VALUES (1), (2);
INSERT INTO d VALUES (1), (2);
SELECT /*+ JOIN_ORDER(b, c_inner, c_inner_inner, d, c) */ d.c
FROM d JOIN c
WHERE d.c IN (
  SELECT
    b.c
  FROM
    b LEFT JOIN c AS c_inner ON c_inner.c = b.c
  WHERE
    EXISTS ( SELECT c FROM c AS c_inner_inner )
) ORDER BY d.c;
DROP TABLE b, c, d;
CREATE TABLE t1(pk INT PRIMARY KEY, col_int_nokey INT);
INSERT INTO t1 VALUES(26, 12);
SELECT /*+ JOIN_ORDER(t3,t1) */ *
  FROM
  t1 WHERE 3 IN (SELECT t3.col_int_nokey FROM t1 AS t3);
SELECT /*+ JOIN_ORDER(t1,t3,t2) */ *
  FROM
  t1 LEFT JOIN t1 AS t2
  ON 3 IN (SELECT t3.col_int_nokey FROM t1 AS t3)
  WHERE t1.pk=26;
DROP TABLE t1;
CREATE TABLE t1(f1 varchar(1));
SELECT 1 FROM t1 AS table2 LEFT JOIN (SELECT 'c') AS table3(f1)
  ON table3.f1 = table2.f1 WHERE table2.f1
    IN (SELECT 1 FROM (SELECT 1314830897) AS t1(pk)
          WHERE t1.pk <= ANY(SELECT 5)) AND FALSE;
DROP TABLE t1;
CREATE VIEW v1 AS
SELECT 1
FROM (SELECT 1) AS table1(pk) JOIN
     (SELECT 1) AS table2
     ON table1.pk = (SELECT 1)
WHERE table1.pk IN ((SELECT 1), 2);
SELECT * FROM v1;
DROP VIEW v1;
CREATE TABLE t(a INT);
INSERT INTO t VALUES (1),(2),(3);
SELECT * FROM
t AS upper JOIN LATERAL
(SELECT DISTINCT ROW_NUMBER() OVER () AS rn FROM t
 WHERE (t.a > upper.a)) der;
DROP TABLE t;
CREATE TABLE t1 (a INTEGER, b INTEGER);
CREATE TABLE t2 (a INTEGER);
INSERT INTO t1 VALUES(1,10),(2,10),(3,30);
INSERT INTO t2 VALUES(2),(3),(2),(4);
SELECT * FROM t1 WHERE (t1.a,t1.b) IN (SELECT t2.a,10 FROM t2);
SELECT * FROM t1 WHERE t1.a IN (SELECT t2.a FROM t2 WHERE 10=t1.b);
SELECT * FROM t1 WHERE EXISTS (SELECT * FROM t2 WHERE 10=t1.b AND t1.a=t2.a);
DROP TABLE t1,t2;
CREATE TABLE t1 (
  col_int INTEGER,
  pk INTEGER
);
INSERT INTO t1 VALUES (6,24),(7,0),(8,2),(0,15);
CREATE TABLE t2 (
  pk INTEGER,
  UNIQUE ( pk )
);
INSERT INTO t2 VALUES (6),(27),(41);
CREATE TABLE t3 (
  pk INTEGER
);
INSERT INTO t3 VALUES (4),(40),(46);
CREATE TABLE t4 (
  col_int INTEGER
);
SELECT * FROM
    t1
      JOIN t2 ON t1.pk = t2.pk
      JOIN t3 ON t2.pk = t3.pk
  WHERE (t1.col_int + t2.pk) IN ( SELECT col_int FROM t4 );
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (
  col1 CHAR(16),
  UNIQUE KEY col1_idx (col1)
);
CREATE TABLE t2 (
  col1 INTEGER,
  col2 INTEGER,
  UNIQUE KEY ix1 (col1)
);
CREATE TABLE t3 (
  col1 INTEGER,
  col2 INTEGER NOT NULL,
  UNIQUE KEY ix1 (col1)
);
SELECT /*+ JOIN_ORDER(t3,t2,t1) */ * FROM t1
  WHERE t1.col1 = ANY (
    SELECT t1.col1 + t2.col2
    FROM t2 JOIN t3 ON t2.col2 = t3.col2 AND t2.col1 =  t3.col1
    WHERE t2.col2 BETWEEN 2 AND 9
  );
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (col_int_key INT);
INSERT INTO t1 VALUES (NULL);
CREATE TABLE t2 (
  col_int_key INT, col_int_unique INT,
  UNIQUE KEY (col_int_unique), KEY (col_int_key)
);
INSERT INTO t2 VALUES (26,14),(3,46),(45,2),(18,30),(11,22),(19,8),(41,3),(1,5),
(1,9),(38,4),(13,38),(32,12),(11,7),(2,26),(5,10),(16,45);
CREATE TABLE t3 (pk INT NOT NULL PRIMARY KEY);
SELECT *
FROM t1
  LEFT JOIN t2 ON t1.col_int_key = t2.col_int_key
  JOIN t3 ON t1.col_int_key =  t3.pk
WHERE t3.pk+6 NOT IN (
  SELECT /*+ subquery(materialization) */
    table1s.col_int_unique AS field4 FROM t2 AS table1s);
DROP TABLE t1,t2,t3;
CREATE TABLE t1 (
  col_datetime datetime DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_char char(1) DEFAULT NULL,
  col_char_key char(1) DEFAULT NULL,
  col_tinyint tinyint DEFAULT NULL,
  col_tinyint_key tinyint DEFAULT NULL
);
CREATE TABLE t2 (
  col_real_key double DEFAULT NULL,
  col_mediumint mediumint DEFAULT NULL
);
CREATE TABLE t3 (
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL
);
SELECT COUNT(table1.col_datetime) AS field1
FROM t1 AS table1 RIGHT JOIN t1 AS table2
     ON table1.col_varchar_key = table2.col_char
WHERE table1.col_char_key IN
       (SELECT sq2_t1.col_real_key
        FROM t2 AS sq2_t1 JOIN
               t3 AS sq2_t2 JOIN t1 AS sq2_t3
               ON INSTR(sq2_t3.col_tinyint, 'K') = sq2_t2.col_varchar
             ON sq2_t3.col_varchar_key = sq2_t2.col_varchar_key
        WHERE sq2_t1.col_mediumint IN
               (SELECT sq1_t1.col_varchar_key
                FROM t1 AS sq1_t1 JOIN t1 AS sq1_t2
                     ON sq1_t2.col_tinyint_key = table1.col_tinyint_key
               )
       ) OR
      RTRIM(table1.col_tinyint_key) IS NOT NULL;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  col_int_key bigint DEFAULT NULL,
  KEY(col_int_key)
) PARTITION BY KEY(col_int_key) PARTITIONS 10;
INSERT INTO t1 VALUES
(NULL);
SELECT 42
WHERE 11 NOT IN
(SELECT col_int_key FROM t1);
DROP TABLE t1;
CREATE TABLE t(a INT);
SELECT 1=
(
  SELECT 1 FROM
  (
    SELECT 1 FROM t
    LEFT JOIN
    (
      SELECT 1 FROM t
      WHERE NOT EXISTS
            (
              SELECT 1 FROM t WINDOW w1 AS (PARTITION BY a)
            )
    ) AS x
    ON 1 > 2
  ) AS z
);
DROP TABLE t;
CREATE TABLE t1 (
 col_varchar varchar(1),
 col_varchar_key varchar (1),
 key (col_varchar_key)
);
CREATE TABLE t2 (
 col_varchar varchar(1),
 col_int_key int,
 key (col_int_key)
);
INSERT INTO t2 VALUES ('t', 2);
CREATE TABLE t3 (
 pk integer auto_increment,
 col_int int,
 col_varchar_key varchar(1),
 primary key (pk),
 key (col_varchar_key)
);
INSERT INTO t3 (col_int, col_varchar_key) VALUES
 (2, 'e'), (NULL, 'n'), (2, NULL), (0, 'a'), (NULL, 'd'), (1, 's'),
 (NULL, 'v'), (7, 'l'), (118, NULL), (NULL, 'l'), (8, 'c'), (4, 'a'),
 (8, 'r'), (1, 'q'), (3, 'o'), (NULL, 'q'), (2, 'j'), (6, 'f'),
 (5, 'e'), (7, 'p');
CREATE TABLE t4 (
 col_int_key int,
 col_varchar varchar(1),
 key (col_int_key)
);
INSERT INTO t4 VALUES
 (5, 'k'), (5, 'g'), (5, 'k'), (1, 'e'), (9, 'b'), (NULL, 'b'),
 (141, 'w'), (0, 'i'), (240, 'x'), (1, 'h'), (NULL, 'p'), (201, 'v'),
 (5, 'e'), (NULL, 'e'), (2, 'a'), (3, 'r'), (NULL, 'f'), (8, 's'),
 (7, 'k'), (6, 'k');
CREATE TABLE t5 (
 col_int int,
 col_varchar_key varchar(1),
 pk integer auto_increment,
 primary key(pk)
);
INSERT INTO t5 (col_int, col_varchar_key) VALUES
 (9, 'g'), (8, 'c'), (2, 'k'), (3, 'g'), (NULL, 'm'), (2, 'c'),
 (1, 'o'), (NULL, 'r'), (0, 'u'), (7, 'z'), (4, 'd'), (1, 'q'),
 (3, 't'), (NULL, 'x'), (1, 'g'), (8, 'e'), (2, 'f'), (9, NULL),
 (229, 't'), (2, 'i'), (127, 'x'), (75, 'u'), (4, 'r'), (4, 'y'),
 (NULL, 'y'), (7, 'n'), (8, 'h'), (0, 'e'), (9, 'h'), (4, 'v'),
 (4, 'o'), (0, 'w'), (9, NULL), (7, NULL), (7, 'd'), (74, 's'),
 (1, 'j'), (9, 'k'), (5, 'g'), (3, 'o'), (5, 'b'), (1, 'l'),
 (3, 'u'), (0, 'v'), (7, 'y'), (9, 'g'), (6, 'i'), (9, 'f'),
 (3, 'u'), (4, 'q'), (NULL, NULL), (0, 'k'), (NULL, 'l'), (2, 'q'),
 (7, 'r'), (5, 't'), (2, 'h'), (2, NULL), (NULL, 'z'), (7, 'c'),
 (NULL, 'd'), (242, 'h'), (7, 'e'), (5, 'e'), (7, 's'), (9, 'u'),
 (250, 'z'), (9, 'n'), (7, 'j'), (3, 's'), (8, 'e'), (6, NULL),
 (NULL, 'i'),  (1, 'n'), (3, 'k'), (7, 'n'), (1, 'w'), (8, 'x'),
 (1, 'b'), (9, NULL), (4, 'o'), (3, 'i'), (9, 'n'), (91, 'c'),
 (5, 'j'), (8, 'g'), (7, 'c'), (9, NULL), (8, 'd'), (NULL, 'h'),
 (4, 'k'), (1, 'r'), (33, 'k'), (8, 'n'), (4, 'h'), (2, 'q'),
 (9, 'p'), (1, NULL), (8, 'n'), (0, 'j');
PREPARE ps FROM '
SELECT (SELECT SUM(sq1_t1.col_int) AS sq1_field1
        FROM t3 AS sq1_t1 INNER JOIN t1 AS sq1_t2
             ON sq1_t2.col_varchar_key = sq1_t1.col_varchar_key
        WHERE sq1_t2.col_varchar < sq1_t2.col_varchar OR
              sq1_t2.col_varchar <>  ?
       ) AS field1
FROM t5 AS table1 LEFT OUTER JOIN t4 AS table2
     ON table2.col_int_key = table1.col_int
WHERE table1.pk > ANY
       (SELECT sq2_t1.pk AS sq2_field1
        FROM t3 AS sq2_t1 STRAIGHT_JOIN t2 AS sq2_t2
             ON sq2_t2.col_int_key = sq2_t1.pk
        WHERE sq2_t2.col_varchar >= table2.col_varchar AND
              sq2_t2.col_varchar <= table1.col_varchar_key
       ) AND
      table1.pk = ?';
DROP TABLE t1, t2, t3, t4, t5;
CREATE TABLE t1(
  pk INTEGER,
  col_int INTEGER,
  col_varchar VARCHAR(1),
  col_int_key INTEGER,
  col_datetime_key DATETIME,
  col_varchar_key VARCHAR(1)
) DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
CREATE PROCEDURE p1() LANGUAGE SQL
  SELECT DISTINCT MIN(outr.col_varchar) AS x
  FROM t1 AS outr2 LEFT JOIN t1 AS outr
       ON outr2.col_int_key <> outr.pk
  WHERE outr.col_int IN
     (SELECT innr.col_int_key AS y
      FROM t1 AS innr
      WHERE outr.col_varchar_key = 'z') AND
        outr.col_datetime_key = '2003-12-04'
ORDER BY outr.pk, outr.pk;
DROP PROCEDURE p1;
DROP TABLE t1;
CREATE TABLE t (a DECIMAL(61,14),KEY(a));
INSERT INTO t VALUES(0),(-1);
SELECT
(
  SELECT 1 FROM
  (
    SELECT a FROM (SELECT 1) u
  ) z
)
FROM t GROUP BY 1;
DROP TABLE t;
CREATE TABLE t1 (
  pk INTEGER NOT NULL,
  a VARCHAR(1),
  PRIMARY KEY (pk)
);
INSERT INTO t1 VALUES (3,'N');
INSERT INTO t1 VALUES (4,'e');
INSERT INTO t1 VALUES (5,'7');
INSERT INTO t1 VALUES (6,'7');
SELECT * FROM t1 AS table1, t1 AS table2
  WHERE table1.pk = 6
  HAVING table1.a IN (SELECT a FROM t1);
DROP TABLE t1;
CREATE TABLE t1(a INTEGER, b INTEGER);
CREATE TABLE t2(c INTEGER);
SELECT b FROM t1 HAVING 1 IN
  (SELECT b FROM t2 WHERE c = 1);
DROP TABLE t1, t2;
CREATE TABLE t(a INTEGER);
INSERT INTO t VALUES(1),(2),(3);
DROP TABLE t;
CREATE TABLE t1 (
  a INTEGER,
  d VARCHAR(255) NOT NULL,
  PRIMARY KEY (d)
);
INSERT INTO t1 VALUES (1,'1'), (2,'2');
SELECT 1 FROM t1 WHERE d IN (SELECT a FROM t1);
DROP TABLE t1;
CREATE TABLE t1 (c1 int, c2 char(10));
INSERT INTO t1 VALUES (1, 'name1');
INSERT INTO t1 VALUES (2, 'name2');
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER);
CREATE TABLE t2 (b INTEGER);
SELECT ( SELECT b FROM t2 ORDER BY a, MIN(a) LIMIT 1 ) FROM t1 GROUP BY a;
DROP TABLE t1, t2;
CREATE TABLE t1 (a VARCHAR(1));
INSERT INTO t1 VALUES (NULL), ('r');
SELECT * FROM t1 WHERE a <= ALL (
  SELECT 'a' FROM t1 AS t2
  WHERE t2.a < t1.a AND t2.a NOT IN (SELECT a FROM t1)
);
DROP TABLE t1;
CREATE TABLE t1 (
  a INTEGER,
  PRIMARY KEY (a)
) PARTITION BY LINEAR KEY () PARTITIONS 4;
SELECT 1 FROM t1 WHERE
  ( SELECT a FROM ( SELECT 1 ) AS q )
   IN ( SELECT a FROM t1 WHERE a > 0 GROUP BY a );
DROP TABLE t1;
CREATE TABLE t1 (a DATETIME);
INSERT INTO t1 VALUES ('2000-01-01 00:00:00');
INSERT INTO t1 VALUES ('2000-01-01 00:00:00');
SELECT 1 FROM t1 WHERE (@b IN ( SELECT a FROM t1 )) = a;
DROP TABLE t1;
CREATE TABLE t(pk INT PRIMARY KEY);
SELECT 1 FROM t
WHERE CAST(pk AS UNSIGNED INTEGER) = 1
      AND pk = (SELECT 1 FROM t);
DROP TABLE t;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1 ( c INTEGER, KEY (c) );
CREATE TABLE t2 ( pk INTEGER );
INSERT INTO t2 VALUES (7);
CREATE TABLE t3 (
  a INTEGER,
  b INTEGER,
  c INTEGER,
  KEY (a)
);
INSERT INTO t3 VALUES (3,4,NULL);
UPDATE t1, t2
  SET t1.c = 0
  WHERE t1.c <> (
    SELECT
      t3.c
    FROM
      t3
      JOIN t3 AS t3_b ON t3_b.a > t3.a
    WHERE t3.b <= t3.b XOR t2.pk = 3
  );
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( a BLOB );
SELECT t1.a
FROM
  t1,
  LATERAL ( SELECT t1.a FROM t1 AS inner_t1 LIMIT 1 ) AS d1
WHERE 1 IN ( SELECT a FROM t1 )
ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1 ( a VARCHAR(1) );
INSERT INTO t1 VALUES ('0');
SELECT 1
FROM t1
WHERE a NOT IN (
  SELECT 1
  FROM
    t1 AS t2
    LEFT JOIN t1 AS t3 ON (t2.a = t3.a OR 0 IN ( SELECT REGEXP_LIKE(a, '') FROM t1 ))
);
DROP TABLE t1;
CREATE TABLE t1(c0 int);
INSERT INTO t1 VALUES(NULL), (1), (NULL), (2), (NULL), (3);
SELECT t1.c0 AS ref0
FROM t1
WHERE t1.c0 IN (SELECT t2.c0 AS ref1
                FROM t1 as t2
                WHERE t2.c0 NOT IN (SELECT t3.c0 AS ref2
                                    FROM t1 as t3
                                    WHERE t3.c0
                                   )
                      = t2.c0
               );
DROP TABLE t1;
CREATE TABLE t0 (
  c0 INTEGER
);
INSERT INTO t0 VALUES
 (321108437), (-64596961), (329053785), (1983), (NULL), (NULL),
 (1936), (-543970881), (NULL), (NULL), (-1945919442), (NULL), (1230052719);
SELECT t0.c0
FROM t0
WHERE t0.c0 NOT IN (SELECT t0.c0 AS ref1
                    FROM t0
                    WHERE t0.c0 IN (SELECT t0.c0
                                    FROM t0
                                    WHERE t0.c0 NOT IN (SELECT t0.c0 AS ref3
                                                        FROM t0
                                                       )
                                          = t0.c0
                                   )
                   );
DROP TABLE t0;
CREATE TABLE t1(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(1, NULL);
CREATE TABLE t2(c INTEGER, d INTEGER);
INSERT INTO t2 VALUES(2, 2);
SELECT a FROM t1 WHERE b =ALL (SELECT d FROM t2 WHERE c = 1);
SELECT a FROM t1 WHERE b =ALL (SELECT d FROM t2 WHERE c = 2);
prepare ps FROM "
SELECT a FROM t1 WHERE b =ALL (SELECT d FROM t2 WHERE c = ?)";
deallocate prepare ps;
DROP TABLE t1, t2;
CREATE TABLE vt1 (c1 INT);
CREATE TABLE vt2 (c1 INT);
CREATE TABLE vt3 (c1 INT NOT NULL AUTO_INCREMENT, c2 INT,
                  c3 INT, c4 INT, c5 INT, PRIMARY KEY (c1));
INSERT INTO vt3 (c2,c3) VALUES (1,1);
CREATE TABLE vt4 (c1 INT);
INSERT INTO vt4 (c1) VALUES (1);
CREATE VIEW v1 AS
SELECT vt3.c2 AS vc1, vt3.c3 AS vc2, vt4.c1 AS vc3
 FROM (((vt3 LEFT JOIN vt1 ON vt1.c1 = vt3.c5)
         LEFT JOIN vt2 ON vt3.c4= vt2.c1) JOIN vt4);
CREATE TABLE t1 (c1 INT, c2 CHAR(2));
INSERT INTO t1 VALUES (1, '01');
CREATE TABLE t2 (c2 INT, c3 INT);
INSERT INTO t2 VALUES (1, null);
SELECT *
FROM v1
WHERE (v1.vc3 IN (SELECT c1 FROM t1 WHERE c2='01'))
       AND (null IS null OR v1.vc1 IN (SELECT c2 FROM t2 WHERE c3=null))
       AND (null IS null OR v1.vc2 IN (null));
SELECT *
FROM v1
WHERE (vc3 IN (SELECT c1 FROM t1 WHERE c2='01'))
       AND (null IS null OR v1.vc1 IN (SELECT c2 FROM t2 WHERE c3=null));
DROP VIEW v1;
DROP TABLE vt1, vt2, vt3, vt4, t1, t2;
CREATE TABLE ot (c0 BIGINT NOT NULL, c1 VARCHAR(5));
INSERT INTO ot VALUES (1, 'A'), (2, 'B'), (3, 'C'), (4, 'C');
CREATE TABLE it1 (c0 INT NOT NULL, c1 BIGINT NOT NULL);
INSERT INTO it1 VALUES (1, 3), (2, 2);
CREATE TABLE it2 (c0 BIGINT NOT NULL, c1 VARCHAR(5));
INSERT INTO it2 VALUES (1, 'A'), (2, 'B'), (3, 'C'), (4, 'C');
DROP TABLE ot, it1, it2;
CREATE TABLE t (c INTEGER);
SELECT c
FROM t
WHERE ((SELECT c FROM t), 0) IN (SELECT 1, 2 UNION SELECT 3, 4) AND FALSE;
DROP TABLE t;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2 (a INT);
CREATE TABLE t3 (a INT, KEY (a));
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
SELECT *
FROM (SELECT (SELECT SUM(t1.f1) FROM t1) AS subq
      FROM t1 AS t2
      WHERE t2.f1 IN (SELECT 1 FROM t1)
      ORDER BY t2.f2, subq) AS dt;
DROP TABLE t1;
CREATE TABLE t (f integer);
CREATE VIEW v AS SELECT * FROM t;
SELECT 1
FROM t AS t1 JOIN
       (SELECT v.*
        FROM v
       ) AS t2
     ON t1.f = t2.f
WHERE FALSE AND (t2.f, t2.f) IN (SELECT 1, 2);
SELECT t2.f
FROM t AS t1 JOIN (SELECT *
                   FROM (SELECT (SELECT f = 1 AS f FROM t) AS f
                    FROM t
                   ) AS t2
             ) AS t2
     ON t1.f = t2.f
WHERE FALSE AND (t2.f,t2.f) IN (SELECT 4,3);
DROP VIEW v;
DROP TABLE t;
SELECT CAST(NULL < ANY (VALUES ROW(1), ROW(2)) AS SIGNED);
CREATE TABLE t (x INT);
SELECT 1 WHERE 7 IN
(SELECT COUNT(*) FROM t AS t1, t AS t2 WHERE t1.x = t2.x AND t1.x < t2.x);
DROP TABLE t;
CREATE TABLE t (a INT);
INSERT INTO t VALUES (1), (2), (3);
SELECT NULL IN (SELECT (a IN (SELECT a FROM t)) FROM t);
DROP TABLE t;
CREATE TABLE num (n INT);
INSERT INTO num VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1 (a INT, KEY(a), b INT, c INT);
INSERT INTO t1 SELECT k, k, k FROM (SELECT x1.n+x2.n*10 k FROM num x1, num x2) d1;
DROP TABLE num, t1;
CREATE TABLE t(id INT, id2 INT, PRIMARY KEY (id));
INSERT INTO t VALUES (1, 1), (2, 2), (3, 1), (4, 2);
SELECT * FROM t t1 WHERE EXISTS
  (SELECT t2.id FROM t t2 WHERE
    t1.id = (SELECT id2 FROM t t3 WHERE t2.id = t3.id));
DROP TABLE t;
CREATE TABLE t(i INT, KEY (i));
INSERT INTO t VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
SELECT 1 AS x FROM t
WHERE i IN (SELECT i FROM (TABLE t) AS dt WHERE i < 2) GROUP BY x WITH ROLLUP;
DROP TABLE t;
