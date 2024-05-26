CREATE TABLE t1(a, b, c, d);
INSERT INTO t1 VALUES(1, 2, 3, 4);
INSERT INTO t1 VALUES(5, 6, 7, 8);
INSERT INTO t1 VALUES(9, 10, 11, 12);
SELECT sum(b) OVER () FROM t1;
SELECT a, 4 + sum(b) OVER () FROM t1;
SELECT a + 4 + sum(b) OVER () FROM t1;
SELECT sum(b) FILTER (WHERE a>0) OVER (PARTITION BY d ORDER BY c) FROM t1;
CREATE TABLE t2(a, b, c);
INSERT INTO t2 VALUES(0, 0, 0);
INSERT INTO t2 VALUES(1, 1, 1);
INSERT INTO t2 VALUES(2, 0, 2);
INSERT INTO t2 VALUES(3, 1, 0);
INSERT INTO t2 VALUES(4, 0, 1);
INSERT INTO t2 VALUES(5, 1, 2);
INSERT INTO t2 VALUES(6, 0, 0);
SELECT a, 
    sum(a) OVER (ORDER BY a), 
    avg(a) OVER (ORDER BY a) 
  FROM t2 ORDER BY a;
SELECT a, 
    count() OVER (ORDER BY a DESC),
    string_agg(a, '.') OVER (ORDER BY a DESC) 
  FROM t2 ORDER BY a DESC;
SELECT a, 
    count(*) OVER (ORDER BY a DESC),
    group_concat(a, '.') OVER (ORDER BY a DESC) 
  FROM t2 ORDER BY a DESC;
CREATE TABLE t4(a, b);
SELECT ntile(1) OVER (ORDER BY a) FROM t4;
CREATE TABLE t3(a, b, c);
WITH s(i) AS ( VALUES(1) UNION ALL SELECT i+1 FROM s WHERE i<6 )
  INSERT INTO t3 SELECT i, i, i FROM s;
CREATE VIEW v1 AS SELECT
    sum(b) OVER (ORDER BY c),
    min(b) OVER (ORDER BY c),
    max(b) OVER (ORDER BY c)
  FROM t3;
CREATE VIEW v2 AS SELECT
    sum(b) OVER win,
    min(b) OVER win,
    max(b) OVER win
  FROM t3
  WINDOW win AS (ORDER BY c);
SELECT * FROM v1;
SELECT * FROM v2;
SELECT * FROM v1;
SELECT * FROM v2;
INSERT INTO t4 VALUES(1, 'g');
INSERT INTO t4 VALUES(2, 'i');
INSERT INTO t4 VALUES(3, 'l');
INSERT INTO t4 VALUES(4, 'g');
INSERT INTO t4 VALUES(5, 'a');
CREATE TABLE t5(x, y, m);
INSERT INTO t4 VALUES(6, 'm');
SELECT * FROM t5 ORDER BY 1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a,b,c,d);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2(x,y);
CREATE TABLE sales(emp TEXT PRIMARY KEY, region, total);
INSERT INTO sales VALUES
      ('Alice',     'North', 34),
      ('Frank',     'South', 22),
      ('Charles',   'North', 45),
      ('Darrell',   'South', 8),
      ('Grant',     'South', 23),
      ('Brad' ,     'North', 22),
      ('Elizabeth', 'South', 99),
      ('Horace',    'East',   1);
SELECT emp, region, total FROM (
    SELECT 
      emp, region, total,
      row_number() OVER (PARTITION BY region ORDER BY total DESC) AS rank
    FROM sales
  ) WHERE rank<=2 ORDER BY region, total DESC;
SELECT emp, region, (
    SELECT sum(total) OVER (
      ORDER BY total RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) || outer.emp FROM sales
  ) FROM sales AS outer;
SELECT emp, region, (
    SELECT sum(total) FILTER (WHERE sales.emp!=outer.emp) OVER (
      ORDER BY total RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) FROM sales
  ) FROM sales AS outer;
CREATE TABLE t6(a, b, c);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(id INT, b VARCHAR, c VARCHAR);
INSERT INTO t1 VALUES(1, 'A', 'one');
INSERT INTO t1 VALUES(2, 'B', 'two');
INSERT INTO t1 VALUES(3, 'C', 'three');
INSERT INTO t1 VALUES(4, 'D', 'one');
INSERT INTO t1 VALUES(5, 'E', 'two');
SELECT id, b, lead(c,1) OVER(ORDER BY c) AS x 
    FROM t1 WHERE id>1
   ORDER BY b LIMIT 1;
INSERT INTO t1 VALUES(6, 'F', 'three');
INSERT INTO t1 VALUES(7, 'G', 'one');
SELECT id, b, lead(c,1) OVER(ORDER BY c) AS x
    FROM t1 WHERE id>1
   ORDER BY b LIMIT 2;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a int, b int);
INSERT INTO t1 VALUES(1,11);
INSERT INTO t1 VALUES(2,12);
SELECT a, rank() OVER(ORDER BY b) FROM t1;
SELECT * FROM(
    SELECT * FROM (SELECT 1 AS c) WHERE c IN (
        SELECT (row_number() OVER()) FROM (VALUES (0))
    )
  );
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(x);
INSERT INTO t1 VALUES('a'), ('b'), ('c');
CREATE TABLE t2(a, b);
INSERT INTO t2 VALUES('X', 1), ('X', 2), ('Y', 2), ('Y', 3);
SELECT x, (
    SELECT sum(b)
      OVER (PARTITION BY a ROWS BETWEEN UNBOUNDED PRECEDING
                                    AND UNBOUNDED FOLLOWING)
    FROM t2 WHERE b<x
  ) FROM t1;
SELECT(
    WITH c AS(
      VALUES(1)
    ) SELECT '' FROM c,c
  ) x WHERE x+x;
CREATE TABLE t7(a,b);
INSERT INTO t7(rowid, a, b) VALUES
      (1, 1, 3),
      (2, 10, 4),
      (3, 100, 2);
CREATE TABLE t8(a);
INSERT INTO t8 VALUES(1), (2), (3);
SELECT 10+sum(a) OVER (ORDER BY a) 
  FROM t8 
  ORDER BY 10+sum(a) OVER (ORDER BY a) DESC;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INTEGER PRIMARY KEY, b TEXT, c TEXT, d INTEGER);
INSERT INTO t1 VALUES(1, 'odd',  'one',   1);
INSERT INTO t1 VALUES(2, 'even', 'two',   2);
INSERT INTO t1 VALUES(3, 'odd',  'three', 3);
INSERT INTO t1 VALUES(4, 'even', 'four',  4);
INSERT INTO t1 VALUES(5, 'odd',  'five',  5);
INSERT INTO t1 VALUES(6, 'even', 'six',   6);
SELECT string_agg(c, '.') OVER (PARTITION BY b ORDER BY c)
  FROM t1;
SELECT group_concat(c, '.') OVER (win1 ORDER BY c)
  FROM t1
  WINDOW win1 AS (PARTITION BY b);
CREATE TABLE keyword_tab(
    current, exclude, filter, following, groups, no, others, over,
    partition, preceding, range, ties, unbounded, window
  );
SELECT
    current, exclude, filter, following, groups, no, others, over,
    partition, preceding, range, ties, unbounded, window
  FROM keyword_tab;
WITH a(x, y) AS ( VALUES(1, 2) )
    SELECT sum(x) OVER (
      ORDER BY y RANGE BETWEEN 4.5 PRECEDING AND UNBOUNDED FOLLOWING
    ) FROM a;
SELECT lead(44) OVER ();
SELECT ( SELECT row_number() OVER () FROM ( SELECT c FROM t1 ) ) FROM t2;
DELETE FROM t1;
DELETE FROM t2;
INSERT INTO t1 VALUES (3, 'C', 'cc', 1.0);
INSERT INTO t1 VALUES (13,'M', 'cc', NULL);
INSERT INTO t2 VALUES('A', NULL);
INSERT INTO t2 VALUES('B', NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INTEGER PRIMARY KEY, b CHAR(1), c CHAR(2), d ANY);
INSERT INTO t1 VALUES
    (10,'J', 'cc', NULL),
    (11,'K', 'cc', 'xyz'),
    (13,'M', 'cc', NULL);
SELECT a, b, c, quote(d), group_concat(b,'') OVER w1, '|' FROM t1
    WINDOW w1 AS
    (ORDER BY d DESC RANGE BETWEEN 7.0 PRECEDING AND 2.5 PRECEDING)
    ORDER BY c, d, a;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INTEGER PRIMARY KEY, b CHAR(1), c CHAR(2), d ANY);
INSERT INTO t1 VALUES
    (1, 'A', 'aa', 2.5),
    (2, 'B', 'bb', 3.75),
    (3, 'C', 'cc', 1.0),
    (4, 'D', 'cc', 8.25),
    (5, 'E', 'bb', 6.5),
    (6, 'F', 'aa', 6.5),
    (7, 'G', 'aa', 6.0),
    (8, 'H', 'bb', 9.0),
    (9, 'I', 'aa', 3.75),
    (10,'J', 'cc', NULL),
    (11,'K', 'cc', 'xyz'),
    (12,'L', 'cc', 'xyZ'),
    (13,'M', 'cc', NULL);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a, b, c);
INSERT INTO t1 VALUES('BB','aa',399);
SELECT
    count () OVER win1 NOT BETWEEN 'a' AND 'mmm',
    count () OVER win3
  FROM t1
  WINDOW win1 AS (ORDER BY a GROUPS BETWEEN 4 PRECEDING AND 1 FOLLOWING
                  EXCLUDE CURRENT ROW),
         win2 AS (PARTITION BY b ORDER BY a),
         win3 AS (win2 RANGE BETWEEN 5.2 PRECEDING AND true PRECEDING );
INSERT INTO t2 VALUES(1, 1);
CREATE VIEW a AS SELECT NULL INTERSECT SELECT NULL ORDER BY s() OVER R;
CREATE TABLE a0 AS SELECT 0;
SELECT avg(a) OVER (
      ORDER BY (SELECT sum(b) OVER ()
        FROM t1 ORDER BY (
          SELECT total(d) OVER (ORDER BY c)
          FROM (SELECT 1 AS d) ORDER BY 1
          )
        )
      )
  FROM t1;
VALUES(count(*)OVER());
VALUES(count(*)OVER()),(2);
VALUES(2),(count(*)OVER());
VALUES(2),(3),(count(*)OVER()),(4),(5);
CREATE TABLE t0(a UNIQUE, b PRIMARY KEY);
CREATE VIEW v0(c) AS SELECT max((SELECT count(a)OVER(ORDER BY 1))) FROM t0;
SELECT c FROM v0 WHERE c BETWEEN 10 AND 20;
DROP VIEW v0;
CREATE VIEW v0(c) AS SELECT max((SELECT count(a)OVER(ORDER BY 1234))) FROM t0;
SELECT c FROM v0 WHERE c BETWEEN -10 AND 20;
SELECT FIRST_VALUE(0) OVER();
INSERT INTO t1 VALUES(NULL,'bb',355);
INSERT INTO t1 VALUES('CC','aa',158);
INSERT INTO t1 VALUES('GG','bb',929);
INSERT INTO t1 VALUES('FF','Rb',574);
SELECT min(c) OVER (
    ORDER BY a RANGE BETWEEN 5.2 PRECEDING AND 0.1 PRECEDING
  ) FROM t1;
SELECT min(c) OVER (
    ORDER BY a RANGE BETWEEN 5.2 PRECEDING AND 0.1 PRECEDING
  ) << 100 FROM t1;
SELECT
    min(c) OVER win3 << first_value(c) OVER win3,
    min(c) OVER win3 << first_value(c) OVER win3
  FROM t1
  WINDOW win3 AS (
    PARTITION BY 6 ORDER BY a RANGE BETWEEN 5.2 PRECEDING AND 0.1 PRECEDING
  );
INSERT INTO t1 VALUES(1, 1, 1);
INSERT INTO t1 VALUES(2, 2, 2);
SELECT * FROM t1 WHERE (0, 0) IN ( SELECT count(*), 0 FROM t1 );
SELECT * FROM t1 WHERE (2, 0) IN ( SELECT count(*), 0 FROM t1 );
SELECT count(*), max(a) OVER () FROM t1 GROUP BY c;
SELECT sum(a), max(b) OVER () FROM t1;
INSERT INTO t2 VALUES('a', 1);
INSERT INTO t2 VALUES('a', 2);
INSERT INTO t2 VALUES('a', 3);
INSERT INTO t2 VALUES('b', 4);
INSERT INTO t2 VALUES('b', 5);
INSERT INTO t2 VALUES('b', 6);
INSERT INTO t1(a, b) VALUES(1,  10);
INSERT INTO t1(a, b) VALUES(2,  15);
INSERT INTO t1(a, b) VALUES(3,  -5);
INSERT INTO t1(a, b) VALUES(4,  -5);
INSERT INTO t1(a, b) VALUES(5,  20);
INSERT INTO t1(a, b) VALUES(6, -11);
SELECT a, sum(b) OVER (ORDER BY a) AS abc FROM t1 ORDER BY 2;
SELECT a, sum(b) OVER (ORDER BY a) AS abc FROM t1 ORDER BY abc;
SELECT a, sum(b) OVER (ORDER BY a) AS abc FROM t1 ORDER BY abc+5;
CREATE INDEX i1 ON t1(a);
SELECT (SELECT sum(a) OVER(ORDER BY a)) FROM t1;
SELECT * FROM t1 WHERE (SELECT sum(a) OVER(ORDER BY a));
SELECT * FROM t1 NATURAL JOIN t1
    WHERE a=1
    OR ((SELECT sum(a)OVER(ORDER BY a)) AND a<=10);
SELECT (SELECT max(x)OVER(ORDER BY x) + min(x)OVER(ORDER BY x))
    FROM (SELECT (SELECT sum(a) FROM t1) AS x FROM t1);
SELECT (SELECT max(x)OVER(ORDER BY x) + min(x)OVER(ORDER BY x))
    FROM (SELECT (SELECT sum(a) FROM t1 GROUP BY a) AS x FROM t1);
SELECT b AS c FROM (
    SELECT a AS b FROM (
      SELECT a FROM t1 WHERE a=1 OR (SELECT sum(a) OVER ())
    ) 
    WHERE b=1 OR b<10
  ) 
  WHERE c=1 OR c>=10;
SELECT * FROM t1 WHERE a%1 OR (SELECT sum(a) OVER (ORDER BY a%2));
SELECT * FROM (
    SELECT * FROM t1 WHERE a%1 OR (SELECT sum(a) OVER (ORDER BY a%2))
  ) 
  WHERE a=1 OR ( (SELECT sum(a) OVER (ORDER BY a%4)) AND a<=10 );
SELECT a FROM (
    SELECT * FROM (
      SELECT * FROM t1 WHERE a%1 OR (SELECT sum(a) OVER (ORDER BY a%2))
    ) 
    WHERE a=1 OR ( (SELECT sum(a) OVER (ORDER BY a%4)) AND a<=10 )
  ) 
  WHERE a=1 OR a=10.0;
SELECT a FROM (
    SELECT * FROM (
      SELECT * FROM t1 WHERE a%1 OR (SELECT sum(a) OVER (ORDER BY a%2))
    ) 
    WHERE a=1 OR ( (SELECT sum(a) OVER (ORDER BY a%4)) AND a<=10 )
  ) 
  WHERE a=1 OR ((SELECT sum(a) OVER(ORDER BY a%8)) AND 10<=a);
INSERT INTO t1 VALUES('AA','bb',356);
INSERT INTO t1 VALUES('CC','aa',158);
INSERT INTO t1 VALUES('BB','aa',399);
INSERT INTO t1 VALUES('FF','bb',938);
SELECT
    count() OVER win1,
    sum(c) OVER win2, 
    first_value(c) OVER win2,
    count(a) OVER (ORDER BY b)
      FROM t1
      WINDOW
      win1 AS (ORDER BY a),
    win2 AS (PARTITION BY 6 ORDER BY a
        RANGE BETWEEN 5 PRECEDING AND 0 PRECEDING );
SELECT * FROM ( 
    SELECT sum(b) OVER() AS c FROM t1 
      UNION
    SELECT b AS c FROM t1
  ) WHERE c>10;
SELECT * FROM ( 
    SELECT sum(b) OVER() AS c FROM t1 
      UNION
    SELECT b AS c FROM t1
  ) WHERE c>10;
INSERT INTO t1 VALUES(NULL,NULL,NULL);
SELECT 
    sum(a),
    min(b) OVER (),
    count(c) OVER (ORDER BY b)
  FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a);
INSERT INTO t1(a) VALUES(22);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(x INTEGER PRIMARY KEY);
INSERT INTO t1 VALUES (123);
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (x INTEGER PRIMARY KEY);
INSERT INTO t1 VALUES (99);
SELECT EXISTS(SELECT count(*) OVER() FROM t1 ORDER BY sum(x) OVER());
SELECT COUNT() OVER () LIKE lead(102030) OVER(
      ORDER BY sum('abcdef' COLLATE nocase) IN (SELECT 54321) 
  )
  FROM t1;
INSERT INTO t1 VALUES(3578824042033200656);
INSERT INTO t1 VALUES(3029012920382354029);
SELECT total(a) OVER ( ORDER BY a RANGE BETWEEN 0.3 PRECEDING AND 10 FOLLOWING ) FROM t2 ORDER BY a;
CREATE TABLE dual(dummy);
INSERT INTO dual VALUES('X');
SELECT * FROM v1 WHERE true;
SELECT * FROM t2;
SELECT *, nth_value(15,2) OVER() FROM t2, t1 WHERE b=4;
INSERT INTO t2 VALUES(5,6),(7,8);
SELECT (
    SELECT count( a ) FROM t2 LIMIT 1
  )
  FROM t1;
/* Original test case reported in https://sqlite.org/forum/forumpost/bad532820c
  CREATE TABLE v0 (c1);
DROP TABLE t1;
CREATE TABLE t1(a INT, b INT);
CREATE INDEX t1x ON t1(a+b);
INSERT INTO t1(a,b) VALUES (111,222),(111,223),(118,229);
CREATE INDEX t1a ON t1(a);
SELECT c, (SELECT c + sum(1) OVER ()) AS "res"
    FROM t2 LEFT JOIN (SELECT +a AS c FROM t1) AS v1 ON true
   GROUP BY c
   ORDER by c;
