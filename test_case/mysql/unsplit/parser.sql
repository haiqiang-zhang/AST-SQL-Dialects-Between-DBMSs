create table ADDDATE(a int);
drop table ADDDATE;
create table ADDDATE (a int);
drop table ADDDATE;
create table BIT_AND (a int);
drop table BIT_AND;
create table BIT_OR (a int);
drop table BIT_OR;
create table BIT_XOR (a int);
drop table BIT_XOR;
create table CAST (a int);
drop table CAST;
create table COUNT (a int);
drop table COUNT;
create table CURDATE (a int);
drop table CURDATE;
create table CURTIME (a int);
drop table CURTIME;
create table DATE_ADD (a int);
drop table DATE_ADD;
create table DATE_SUB (a int);
drop table DATE_SUB;
create table EXTRACT (a int);
drop table EXTRACT;
create table GROUP_CONCAT (a int);
drop table GROUP_CONCAT;
create table GROUP_UNIQUE_USERS(a int);
drop table GROUP_UNIQUE_USERS;
create table GROUP_UNIQUE_USERS (a int);
drop table GROUP_UNIQUE_USERS;
create table MAX (a int);
drop table MAX;
create table MID (a int);
drop table MID;
create table MIN (a int);
drop table MIN;
create table NOW (a int);
drop table NOW;
create table POSITION (a int);
drop table POSITION;
create table SESSION_USER(a int);
drop table SESSION_USER;
create table SESSION_USER (a int);
drop table SESSION_USER;
create table STD (a int);
drop table STD;
create table STDDEV (a int);
drop table STDDEV;
create table STDDEV_POP (a int);
drop table STDDEV_POP;
create table STDDEV_SAMP (a int);
drop table STDDEV_SAMP;
create table SUBDATE(a int);
drop table SUBDATE;
create table SUBDATE (a int);
drop table SUBDATE;
create table SUBSTR (a int);
drop table SUBSTR;
create table SUBSTRING (a int);
drop table SUBSTRING;
create table SUM (a int);
drop table SUM;
create table SYSDATE (a int);
drop table SYSDATE;
create table SYSTEM_USER(a int);
drop table SYSTEM_USER;
create table SYSTEM_USER (a int);
drop table SYSTEM_USER;
create table TRIM (a int);
drop table TRIM;
create table UNIQUE_USERS(a int);
drop table UNIQUE_USERS;
create table UNIQUE_USERS (a int);
drop table UNIQUE_USERS;
create table VARIANCE (a int);
drop table VARIANCE;
create table VAR_POP (a int);
drop table VAR_POP;
create table VAR_SAMP (a int);
drop table VAR_SAMP;
create table ADDDATE(a int);
drop table ADDDATE;
create table ADDDATE (a int);
drop table ADDDATE;
create table BIT_AND (a int);
create table BIT_OR (a int);
create table BIT_XOR (a int);
create table CAST (a int);
create table COUNT (a int);
create table CURDATE (a int);
create table CURTIME (a int);
create table DATE_ADD (a int);
create table DATE_SUB (a int);
create table EXTRACT (a int);
create table GROUP_CONCAT (a int);
create table GROUP_UNIQUE_USERS(a int);
drop table GROUP_UNIQUE_USERS;
create table GROUP_UNIQUE_USERS (a int);
drop table GROUP_UNIQUE_USERS;
create table MAX (a int);
create table MID (a int);
create table MIN (a int);
create table NOW (a int);
create table POSITION (a int);
create table SESSION_USER(a int);
drop table SESSION_USER;
create table SESSION_USER (a int);
drop table SESSION_USER;
create table STD (a int);
create table STDDEV (a int);
create table STDDEV_POP (a int);
create table STDDEV_SAMP (a int);
create table SUBDATE(a int);
drop table SUBDATE;
create table SUBDATE (a int);
drop table SUBDATE;
create table SUBSTR (a int);
create table SUBSTRING (a int);
create table SUM (a int);
create table SYSDATE (a int);
create table SYSTEM_USER(a int);
drop table SYSTEM_USER;
create table SYSTEM_USER (a int);
drop table SYSTEM_USER;
create table TRIM (a int);
create table UNIQUE_USERS(a int);
drop table UNIQUE_USERS;
create table UNIQUE_USERS (a int);
drop table UNIQUE_USERS;
create table VARIANCE (a int);
create table VAR_POP (a int);
create table VAR_SAMP (a int);
CREATE TABLE t1 (i INT KEY);
CREATE TABLE t2 (i INT UNIQUE);
CREATE TABLE t3 (i INT UNIQUE KEY);
DROP TABLE t1, t2, t3;
DROP TABLE IF EXISTS table_25930_a;
DROP TABLE IF EXISTS table_25930_b;
DROP PROCEDURE IF EXISTS p26030;
select "stmt 1";
select "stmt 1";
select "stmt 1";
select "stmt 1";
select "stmt 1";
select "stmt 1";
select "stmt 1";
select "stmt 1";
DROP PROCEDURE IF EXISTS p26030;
DROP PROCEDURE IF EXISTS p26030;
select concat("foo");
select abs(3);
select instr("foobar", "bar");
select instr("foobar" "p1", "bar");
select instr("foobar", "bar" "p2");
select conv(255, 10, 16);
select atan(10);
select atan(10, 20);
DROP TABLE IF EXISTS t1;
SELECT STR_TO_DATE('10:00 PM', '%h:%i %p') + INTERVAL 10 MINUTE;
SELECT STR_TO_DATE('10:00 PM', '%h:%i %p') + INTERVAL (INTERVAL(1,2,3) + 1) MINUTE;
SELECT "1997-12-31 23:59:59" + INTERVAL 1 SECOND;
SELECT 1 + INTERVAL(1,0,1,2) + 1;
SELECT INTERVAL(1^1,0,1,2) + 1;
SELECT INTERVAL(1,0+1,2,3) * 5.5;
SELECT INTERVAL(3,3,1+3,4+4) / 0.5;
SELECT (INTERVAL(1,0,1,2) + 5) * 7 + INTERVAL(1,0,1,2) / 2;
SELECT INTERVAL(1,0,1,2) + 1, 5 * INTERVAL(1,0,1,2);
SELECT INTERVAL(0,(1*5)/2) + INTERVAL(5,4,3);
SELECT 1^1 + INTERVAL 1+1 SECOND & 1 + INTERVAL 1+1 SECOND;
SELECT 1%2 - INTERVAL 1^1 SECOND | 1%2 - INTERVAL 1^1 SECOND;
CREATE TABLE t1 (a INT, b DATETIME);
INSERT INTO t1 VALUES (INTERVAL(3,2,1) + 1, "1997-12-31 23:59:59" + INTERVAL 1 SECOND);
SELECT * FROM t1 WHERE a = INTERVAL(3,2,1) + 1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1,t2,t3;
CREATE TABLE t1 (a1 INT, a2 INT, a3 INT, a4 DATETIME);
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;
SELECT t1.* FROM t1 AS t0, { OJ t2 INNER JOIN t1 ON (t1.a1=t2.a1) } WHERE t0.a3=2;
SELECT t1.*,t2.* FROM { OJ ((t1 INNER JOIN t2 ON (t1.a1=t2.a2)) LEFT OUTER JOIN t3 ON t3.a3=t2.a1)};
SELECT t1.*,t2.* FROM { OJ ((t1 LEFT OUTER JOIN t2 ON t1.a3=t2.a2) INNER JOIN t3 ON (t3.a1=t2.a2))};
SELECT t1.*,t2.* FROM { OJ (t1 LEFT OUTER JOIN t2 ON t1.a1=t2.a2) CROSS JOIN t3 ON (t3.a2=t2.a3)};
SELECT * FROM {oj t1 LEFT OUTER JOIN t2 ON t1.a1=t2.a3} WHERE t1.a2 > 10;
SELECT {fn CONCAT(a1,a2)} FROM t1;
UPDATE t3 SET a4={d '1789-07-14'} WHERE a1=0;
SELECT a1, a4 FROM t2 WHERE a4 LIKE {fn UCASE('1789-07-14')};
DROP TABLE t1, t2, t3;
CREATE TABLE t (id INT PRIMARY KEY);
DROP TABLE t;
CREATE TABLE t1 (i INT);
CREATE TABLE a(a int);
CREATE TABLE b(a int);
DROP TABLE a, b;
SELECT 1 FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1
  FOR UPDATE;
SELECT 1 FROM
  (SELECT 1 FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1
   FOR UPDATE) a;
SELECT 1 FROM t1
  WHERE EXISTS(SELECT 1 FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1
               FOR UPDATE);
SELECT 1 FROM t1
UNION
SELECT 1 FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1
  FOR UPDATE;
SELECT 1 FROM t1 UNION SELECT 1 FROM t1 ORDER BY 1 LIMIT 1;
SELECT 1 FROM t1 UNION SELECT 1 FROM t1 ORDER BY 1 LIMIT 1 FOR UPDATE;
SELECT 1 FROM t1 INTO @var17727401;
SELECT 1 FROM DUAL INTO @var17727401;
SELECT 1 INTO @var17727401;
SELECT 1 INTO @var17727401 FROM t1;
SELECT 1 INTO @var17727401 FROM DUAL;
SELECT 1 INTO @var17727401 FROM t1 WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1 LIMIT 1;
SELECT 1 FROM t1 WHERE 1 GROUP BY 1 HAVING 1 ORDER BY 1 LIMIT 1 INTO @var17727401;
SELECT 1 FROM t1 UNION SELECT 1 FROM t1 INTO @var17727401;
DROP TABLE t1;
SELECT COUNT(1) FROM DUAL GROUP BY '1' ORDER BY 1;
SELECT COUNT(1)           GROUP BY '1' ORDER BY 1;
SELECT (SELECT 1 c                   GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is not expected';
SELECT (SELECT 1 c FROM DUAL         GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is not expected';
SELECT (SELECT 1 c                   GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c FROM DUAL         GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c           WHERE 1 GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is not expected';
SELECT (SELECT 1 c FROM DUAL WHERE 1 GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is not expected';
SELECT (SELECT 1 c           WHERE 1 GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c FROM DUAL WHERE 1 GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c           WHERE 0 GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c FROM DUAL WHERE 0 GROUP BY 1 HAVING 1 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c           WHERE 0 GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT (SELECT 1 c FROM DUAL WHERE 0 GROUP BY 1 HAVING 0 ORDER BY COUNT(1)) AS
  'null is expected';
SELECT 1 c FROM DUAL GROUP BY 1 HAVING 1 ORDER BY COUNT(1);
SELECT 1 c FROM DUAL GROUP BY 1 HAVING 0 ORDER BY COUNT(1);
SELECT 1 c           GROUP BY 1 HAVING 1 ORDER BY COUNT(1);
CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);
SELECT ((SELECT 1 AS f           HAVING EXISTS(SELECT 1 FROM t1) IS TRUE
  ORDER BY f));
SELECT ((SELECT 1 AS f FROM DUAL HAVING EXISTS(SELECT 1 FROM t1) IS TRUE
  ORDER BY f));
SELECT 1 AS f          FROM DUAL HAVING EXISTS(SELECT 1 FROM t1) IS TRUE
  ORDER BY f;
SELECT 1 AS f                   HAVING EXISTS(SELECT 1 FROM t1) IS TRUE
  ORDER BY f;
DROP TABLE t1;
CREATE TABLE t1 (s VARCHAR(100));
DROP TABLE t1;
CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2 (i INT);
INSERT INTO t2 VALUES (10), (20);
SELECT i FROM t1 WHERE i = 1
UNION
SELECT i FROM t2 WHERE i = 10
ORDER BY i;
SELECT i FROM t1 WHERE i = 1
UNION
SELECT i FROM t2 WHERE i = 10
LIMIT 100;
SELECT i FROM t1 WHERE i = 1
UNION
SELECT i FROM t2 GROUP BY i HAVING i = 10
ORDER BY i;
SELECT i FROM t1 WHERE i = 1
UNION
SELECT i FROM t2 GROUP BY i HAVING i = 10
LIMIT 100;
DROP TABLE t1, t2;
CREATE TABLE t1(b INT);
CREATE TABLE t2(a INT, b INT, c INT, d INT);
DROP TABLE t1, t2;
CREATE TABLE t1 (
  a INT
);
INSERT INTO t1 VALUES ( 2 );
SELECT *
FROM ( SELECT a FROM t1 UNION SELECT 1 ORDER BY a ) AS a1
WHERE a1.a = 1 OR a1.a = 2;
DROP TABLE t1;
CREATE DATABASE mysqltest1 CHARACTER SET LATIN2;
CREATE TABLE t1 (a VARCHAR(255) CHARACTER SET LATIN2);
SELECT HEX(a) FROM t1;
DROP DATABASE mysqltest1;
INSERT INTO t1 () SELECT * FROM t1;
INSERT INTO t1 SELECT HIGH_PRIORITY * FROM t1;
DROP TABLE t1;
SELECT 1 AS parse_gcol_expr;
CREATE TABLE parse_gcol_expr (i INT);
DROP TABLE parse_gcol_expr;
CREATE TABLE t1 (x INT PRIMARY KEY);
ALTER TABLE t1;
ALTER TABLE t1 ALGORITHM=DEFAULT;
ALTER TABLE t1 ALGORITHM=COPY;
ALTER TABLE t1 ALGORITHM=INPLACE;
ALTER TABLE t1 LOCK=DEFAULT;
ALTER TABLE t1 LOCK=EXCLUSIVE;
ALTER TABLE t1 LOCK=SHARED, ALGORITHM=COPY,
               LOCK=NONE, ALGORITHM=DEFAULT,
               LOCK=EXCLUSIVE, ALGORITHM=INPLACE;
DROP TABLE t1;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES ( 1 );
CREATE TABLE t2 ( a INT );
INSERT INTO t2 VALUES ( 2 ), ( 2 );
CREATE TABLE t3 ( a INT );
INSERT INTO t3 VALUES ( 3 ), ( 3 ), ( 3 );
SELECT 1 UNION SELECT 2;
SELECT 1 UNION (SELECT 2);
SELECT 2 FROM t1 UNION ((SELECT 3 FROM t1));
SELECT 1 UNION (SELECT 2 FROM t1 ORDER BY a LIMIT 1);
SELECT 1 UNION ( SELECT 1 UNION SELECT 1 );
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES ( 1 );
CREATE TABLE t2 ( a INT );
INSERT INTO t2 VALUES ( 2 ), ( 2 );
CREATE TABLE t3 ( a INT );
INSERT INTO t3 VALUES ( 3 ), ( 3 ), ( 3 );
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( a INT );
INSERT INTO t1 VALUES ( 1 );
CREATE TABLE t2 ( a INT );
INSERT INTO t2 VALUES ( 2 );
CREATE TABLE t3 ( a INT );
INSERT INTO t3 VALUES ( 3 );
CREATE TABLE t4 ( a INT );
INSERT INTO t4 VALUES ( 3 );
SELECT * FROM    (SELECT 1 FROM t1   UNION   SELECT 2 FROM t1) dt;
SELECT * FROM   ((SELECT 1 FROM t1   UNION   SELECT 2 FROM t1)) dt;
SELECT * FROM    (SELECT 1 FROM t1   UNION  (SELECT 2 FROM t1)) dt;
SELECT * FROM   ((SELECT 1 FROM t1   UNION  (SELECT 2 FROM t1))) dt;
SELECT * FROM   ((SELECT 1 FROM t1   UNION ((SELECT 2 FROM t1)))) dt;
SELECT * FROM   ((SELECT 1 FROM t1)  UNION   SELECT 2 FROM t1) dt;
SELECT * FROM  (((SELECT 1 FROM t1)) UNION   SELECT 2 FROM t1) dt;
SELECT * FROM ((((SELECT 1 FROM t1)) UNION   SELECT 2 FROM t1)) dt;
SELECT * FROM   ((SELECT 1 FROM t1)  UNION  (SELECT 2 FROM t1)) dt;
SELECT * FROM  (((SELECT 1 FROM t1)  UNION  (SELECT 2 FROM t1))) dt;
SELECT * FROM ((((SELECT 1 FROM t1)) UNION  (SELECT 2 FROM t1))) dt;
SELECT * FROM  (((SELECT 1 FROM t1)  UNION ((SELECT 2 FROM t1)))) dt;
SELECT * FROM ((((SELECT 1 FROM t1)) UNION ((SELECT 2 FROM t1)))) dt;
SELECT * FROM  ( t1 JOIN t2 ON TRUE );
SELECT * FROM (( t1 JOIN t2 ON TRUE ));
SELECT * FROM ( t1 JOIN t2 ON TRUE  JOIN t3 ON TRUE );
SELECT * FROM ((t1 JOIN t2 ON TRUE) JOIN t3 ON TRUE );
SELECT * FROM (t1 INNER JOIN t2 ON (t1.a = t2.a));
SELECT 1 FROM (t1);
SELECT 1 FROM ((t1));
SELECT 1 UNION SELECT 2 FROM (t2);
SELECT 1 FROM  (SELECT 2  ORDER BY 1) AS res;
SELECT 1 FROM ((SELECT 2) ORDER BY 1) AS res;
SELECT 1 FROM ((SELECT 2) LIMIT 1) AS res;
SELECT * FROM ( t1 AS alias1 );
SELECT * FROM   t1 AS alias1, t2 AS alias2;
SELECT * FROM ( t1 AS alias1, t2 AS alias2 );
SELECT * FROM ( t1 JOIN t2 ON TRUE, (SELECT 1 FROM DUAL) t1a );
SELECT * FROM t1 JOIN t2 ON TRUE, (SELECT 1 FROM DUAL) t1a;
SELECT * FROM ( SELECT 1 FROM DUAL ) t1a;
SELECT * FROM  ( t1, t2 );
SELECT * FROM (( t1, t2 ));
SELECT * FROM  ( (t1),   t2  );
SELECT * FROM  (((t1)),  t2  );
SELECT * FROM  ( (t1),  (t2) );
SELECT * FROM  (  t1,   (t2) );
SELECT * FROM ((SELECT 1 UNION SELECT 1) UNION SELECT 1) a;
SELECT * FROM (t1, t2) JOIN (t3, t4) ON TRUE;
SELECT * FROM ((t1, t2) JOIN t3 ON TRUE);
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( b INT );
CREATE TABLE t3 ( c INT );
CREATE TABLE t4 ( d INT );
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
INSERT INTO t3 VALUES (2);
INSERT INTO t4 VALUES (2);
SELECT * FROM t1 LEFT JOIN ( t2, t3, t4 ) ON a = c;
DROP TABLE t1, t2, t3, t4;
CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( b INT );
CREATE TABLE t3 ( c INT );
CREATE TABLE t4 ( d INT );
CREATE TABLE t5 ( d INT );
SELECT * FROM t5 NATURAL JOIN ((t1 NATURAL JOIN t2), (t3 NATURAL JOIN t4));
SELECT * FROM ((t1 NATURAL JOIN t2), (t3 NATURAL JOIN t4)) NATURAL JOIN t5;
SELECT * FROM t1 JOIN ( t2, t3 ) ON TRUE;
SELECT * FROM ( t1, t2 , t3 );
SELECT * FROM ( ( t1, t2 ), t3 );
SELECT * FROM ( ((t1, t2)), t3 );
SELECT * FROM ( t1, ( t2, t3 ) );
SELECT * FROM ( t1, ((t2, t3)) );
SELECT * FROM ((( t1, t2 ), t3));
SELECT * FROM ((((t1, t2)), t3));
SELECT * FROM ((t1, ( t2, t3 )));
SELECT * FROM ((t1, ((t2, t3))));
CREATE VIEW v1 AS SELECT 1 FROM ( SELECT 1 FROM t1 ) my_table;
DROP TABLE t1, t2, t3, t4, t5;
DROP VIEW v1;
CREATE TABLE t1( a INT );
INSERT INTO t1 VALUES (1);
SELECT 1 INTO @v;
SELECT 1 FROM t1 INTO @v;
SELECT 1 UNION SELECT 1 INTO @v FROM t1;
DROP TABLE t1;
CREATE TABLE t1( a INT );
CREATE TABLE t2( b INT );
CREATE TABLE t3( c INT );
CREATE TABLE t4( d INT );
CREATE TABLE t5( e INT );
SELECT * FROM t1 JOIN t2;
SELECT * FROM t1 JOIN t2 ON a = b;
SELECT * FROM t1 t11 JOIN t1 t12 USING ( a );
SELECT * FROM t1 INNER JOIN t2;
SELECT * FROM t1 INNER JOIN t2 ON a = b;
SELECT * FROM t1 t11 INNER JOIN t1 t12 USING ( a );
SELECT * FROM t1 CROSS JOIN t2;
SELECT * FROM t1 CROSS JOIN t2 ON a = b;
SELECT * FROM t1 t11 CROSS JOIN t1 t12 USING ( a );
SELECT * FROM t1 STRAIGHT_JOIN t2;
SELECT * FROM t1 STRAIGHT_JOIN t2 ON a = b;
SELECT * FROM t1 t11 STRAIGHT_JOIN t1 t12 USING ( a );
SELECT * FROM t1 t11 NATURAL JOIN t1 t12;
SELECT * FROM t1 t11 NATURAL INNER JOIN t1 t12;
SELECT * FROM t1 LEFT JOIN t2 ON a = b;
SELECT * FROM t1 t11 LEFT JOIN t1 t12 USING ( a );
SELECT * FROM t1 NATURAL LEFT JOIN t2;
SELECT * FROM t1 LEFT OUTER JOIN t2 ON a = b;
SELECT * FROM t1 t11 LEFT OUTER JOIN t1 t12 USING ( a );
SELECT * FROM t1 NATURAL LEFT OUTER JOIN t2;
SELECT * FROM t1 RIGHT JOIN t2 ON a = b;
SELECT * FROM t1 t11 RIGHT JOIN t1 t12 USING ( a );
SELECT * FROM t1 NATURAL RIGHT JOIN t2;
SELECT * FROM t1 RIGHT OUTER JOIN t2 ON a = b;
SELECT * FROM t1 t11 RIGHT OUTER JOIN t1 t12 USING ( a );
SELECT * FROM t1 NATURAL RIGHT OUTER JOIN t2;
DROP TABLE t1, t2, t3, t4, t5;
CREATE TABLE t1( a INT, b int );
CREATE TABLE t2( a INT, c int );
CREATE TABLE t3( a INT, d int );
INSERT INTO t1 VALUES (1, 1), (2, 2), (3, 3);
INSERT INTO t2 VALUES         (2, 2), (3, 3), (4, 4);
INSERT INTO t3 VALUES                 (3, 3), (4, 4), (5, 5);
SELECT * FROM t1 NATURAL LEFT JOIN t2 NATURAL RIGHT JOIN t3;
SELECT * FROM (t1 NATURAL LEFT JOIN t2) NATURAL RIGHT JOIN t3;
SELECT * FROM t1 NATURAL LEFT JOIN (t2 NATURAL RIGHT JOIN t3);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  a INT,
  b INT,
  c INT,
  d INT,
  e INT,
  f INT,
  g INT,
  h INT,
  i INT,
  j INT,
  k INT,
  l INT,
  m INT,
  n INT,
  o INT
 );
CREATE        INDEX a_index             ON t1( a );
CREATE UNIQUE INDEX b_index             ON t1( b );
CREATE        INDEX c_index USING btree ON t1( c );
CREATE        INDEX e_index TYPE  btree ON t1( e );
CREATE        INDEX type TYPE  btree ON t1( f );
CREATE        INDEX i_index             ON t1( i ) KEY_BLOCK_SIZE = 1;
CREATE        INDEX j_index             ON t1( j ) KEY_BLOCK_SIZE = 1 KEY_BLOCK_SIZE = 1;
CREATE        INDEX k_index             ON t1( k ) COMMENT 'A comment';
CREATE        INDEX k_index2            ON t1( k ) COMMENT 'A comment' COMMENT 'Another comment';
CREATE        INDEX l_index             ON t1( l ) USING btree;
CREATE        INDEX m_index             ON t1( m ) TYPE btree;
CREATE        INDEX n_index USING btree ON t1( n ) USING btree;
CREATE        INDEX o_index USING rtree ON t1( o ) USING btree;
DROP TABLE t1;
CREATE VIEW v1 AS SELECT /*+ QB_NAME(a) */ 1;
ALTER VIEW v1 AS SELECT /*+ QB_NAME(a) */ 1;
SELECT * FROM v1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT /*+ BAD_HINT */ 1;
ALTER VIEW v1 AS SELECT /*+ BAD_HINT */ 1;
SELECT * FROM v1;
DROP VIEW v1;
CREATE TABLE t1( a INT );
CREATE TABLE t2( a INT );
CREATE TABLE t3( a INT );
CREATE TABLE t4( a INT );
DROP TABLE t1, t2, t3, t4;
select 2 as expected, /*!01000/**/*/ 2 as result;
select 1 as expected, /*!99998/**/*/ 1 as result;
select 3 as expected, /*!01000 1 + */ 2 as result;
select 2 as expected, /*!99990 1 + */ 2 as result;
select 7 as expected, /*!01000 1 + /* 8 + */ 2 + */ 4 as result;
select 8 as expected, /*!99998 1 + /* 2 + */ 4 + */ 8 as result;
select 7 as expected, /*!01000 1 + /*!99998 8 + */ 2 + */ 4 as result;
select 4 as expected, /*!99998 1 + /*!99998 8 + */ 2 + */ 4 as result;
select 4 as expected, /*!99998 1 + /*!01000 8 + */ 2 + */ 4 as result;
CREATE TABLE t1 (a INT PRIMARY KEY) PARTITION BY HASH (a) PARTITIONS 1;
DROP TABLE t1;
CREATE TEMPORARY TABLE t1(a INT);
DROP TABLE t1;
CREATE TEMPORARY TABLE admin (admin INT);
DROP TABLE admin;
SELECT @@default_collation_for_utf8mb4;
CREATE DATABASE db1 CHARSET cp1251 COLLATE cp1251_general_ci;
CREATE TABLE t1 (i INT) CHARSET utf8mb4;
ALTER TABLE t1 CONVERT TO CHARACTER SET DEFAULT;
DROP DATABASE db1;
CREATE DATABASE db2 COLLATE utf8mb4_0900_ai_ci;
CREATE TABLE t2 (i INT) CHARSET latin1;
ALTER TABLE t2 CONVERT TO CHARACTER SET DEFAULT;
ALTER TABLE t2 CONVERT TO CHARACTER SET latin1;
ALTER TABLE t2 CONVERT TO CHARACTER SET DEFAULT COLLATE utf8mb4_bin;
DROP DATABASE db2;
SELECT @@default_collation_for_utf8mb4;
CREATE DATABASE db3 COLLATE utf8mb4_general_ci;
CREATE TABLE t3 (i INT) CHARSET latin1;
ALTER TABLE t3 CONVERT TO CHARACTER SET DEFAULT;
ALTER TABLE t3 CONVERT TO CHARACTER SET DEFAULT COLLATE utf8mb4_bin;
DROP DATABASE db3;
SELECT 1 AS PERSIST, 2 AS PERSIST_ONLY;
DROP TABLE t1;
CREATE TEMPORARY TABLE t1 (i INT);
CREATE TEMPORARY TABLE t2 (i INT);
SELECT * FROM { OJ t1 LEFT JOIN t2 ON TRUE };
DROP TABLE t1, t2;
CREATE VIEW v1 AS (SELECT 1 ORDER BY 1) UNION (SELECT 3 ORDER BY 1) ORDER BY 1;
DROP VIEW v1;
CREATE TABLE t1(a INTEGER);
DROP TABLE t1, t2, t3;
SELECT 'ab' LIKE 'a%', 'ab' LIKE 'a' || '%';
SELECT 'ab' NOT LIKE 'a%', 'ab' NOT LIKE 'a' || '%';
SELECT 'ab' LIKE 'ac', 'ab' LIKE 'a' || 'c';
SELECT 'ab' NOT LIKE 'ac', 'ab' NOT LIKE 'a' || 'c';
SELECT 'a%' LIKE 'a!%' ESCAPE '!', 'a%' LIKE 'a!%' ESCAPE '' || '!';
SELECT 'a%' NOT LIKE 'a!%' ESCAPE '!', 'a%' NOT LIKE 'a!%' ESCAPE '' || '!';
SELECT 'a%' LIKE 'a!%' ESCAPE '' || '$', 'a%' LIKE 'a!%' ESCAPE '' || '$';
SELECT 'a%' NOT LIKE 'a!%' ESCAPE '' || '$', 'a%' NOT LIKE 'a!%' ESCAPE '' || '$';
SELECT 1 ^ 100, 1 ^ '10' || '0';
SELECT -1 || '0';
SELECT 1 UNION SELECT 1 INTO @var;
SELECT 1 UNION SELECT 1 FROM DUAL INTO @var;
SELECT 1 UNION SELECT 1 FROM DUAL FOR UPDATE INTO @var;
SELECT 1 UNION SELECT 1 INTO @var FROM DUAL;
SELECT 1 UNION (SELECT 1 INTO @var FROM DUAL);
SELECT 1 UNION SELECT 1 FROM DUAL INTO @var FOR UPDATE;
SELECT 1 UNION SELECT 1 INTO @var FOR UPDATE;
CREATE TABLE t1 (c1 INT, `*` INT, c3 INT);
INSERT INTO t1 VALUES (1, 2, 3);
SELECT `*` FROM t1;
SELECT t1.`*`, t1.* FROM t1;
DROP TABLE t1;
SELECT @var;
SELECT @var;
SELECT @var;
SELECT @var;
CREATE TABLE full(i INT);
DROP TABLE full;
CREATE TABLE `full`(i INT);
SELECT * from `full`;
SELECT * from `full` AS full;
SELECT * from `full` AS `full`;
SELECT * from full;
SELECT * from full as full;
SELECT * from `full` full;
SELECT * from `full`;
SELECT * from full;
DROP TABLE `full`;