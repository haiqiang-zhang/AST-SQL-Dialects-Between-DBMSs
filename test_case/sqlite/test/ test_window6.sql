SELECT group_concat(x, '.') OVER (ORDER BY y) FROM t1;
SELECT sum(x) OVER w FROM t1 WINDOW w AS (ORDER BY y);
SELECT sum(alias.x) OVER w FROM t1 alias WINDOW w AS (ORDER BY y);
SELECT sum(x) alias FROM t1;
CREATE TABLE over(x, y integer);
INSERT INTO over VALUES(1, 'a');
INSERT INTO over VALUES(2, 'b');
INSERT INTO over VALUES(3, 'c');
INSERT INTO over VALUES(4, 'd');
INSERT INTO over VALUES(5, 'e');
SELECT group_concat(x, '.') OVER (ORDER BY y) FROM over;
SELECT sum(x) OVER w FROM over WINDOW w AS (ORDER BY y);
SELECT sum(alias.x) OVER w FROM over alias WINDOW w AS (ORDER BY y);
SELECT sum(x) alias FROM over;
INSERT INTO t1 VALUES(1, 'a');
INSERT INTO t1 VALUES(2, 'b');
INSERT INTO t1 VALUES(3, 'c');
INSERT INTO t1 VALUES(4, 'd');
INSERT INTO t1 VALUES(5, 'e');
INSERT INTO t1 VALUES(1, 'a');
INSERT INTO t1 VALUES(2, 'b');
INSERT INTO t1 VALUES(3, 'c');
INSERT INTO t1 VALUES(4, 'd');
INSERT INTO t1 VALUES(5, 'e');
INSERT INTO over VALUES(1, 'a');
INSERT INTO over VALUES(2, 'b');
INSERT INTO over VALUES(3, 'c');
INSERT INTO over VALUES(4, 'd');
INSERT INTO over VALUES(5, 'e');
INSERT INTO t1 VALUES(1, 'a');
INSERT INTO t1 VALUES(2, 'b');
INSERT INTO t1 VALUES(3, 'c');
INSERT INTO t1 VALUES(4, 'd');
INSERT INTO t1 VALUES(5, 'e');
CREATE TABLE x1(x);
INSERT INTO x1 VALUES('bob'), ('alice'), ('cate');
CREATE TABLE t4(x, y);
SELECT * FROM t4 window, t4;
CREATE TABLE window(x, window);
INSERT INTO over VALUES(1, 2), (3, 4), (5, 6);
INSERT INTO window VALUES(1, 2), (3, 4), (5, 6);
SELECT sum(x) over FROM over;
SELECT sum(x) over over FROM over WINDOW over AS ();
SELECT sum(window) OVER window window FROM window window window window AS (ORDER BY window);
SELECT count(*) OVER win FROM over
  WINDOW win AS (ORDER BY x ROWS BETWEEN +2 FOLLOWING AND +3 FOLLOWING);
SELECT LIKE('!', '', '!') x WHERE x;
SELECT LIKE("!","","!")""WHeRE"";
CREATE INDEX i1 ON t1(x COLLATE nocase);
SELECT count(*) FROM t1 WHERE x LIKE '!' ESCAPE '!';
CREATE TABLE IF NOT EXISTS "sample" (
      "id" INTEGER NOT NULL PRIMARY KEY, 
      "counter" INTEGER NOT NULL, 
      "value" REAL NOT NULL
  );
INSERT INTO "sample" (counter, value) 
  VALUES (1, 10.), (1, 20.), (2, 1.), (2, 3.), (3, 100.);
SELECT "counter", "value", RANK() OVER w AS "rank" 
  FROM "sample"
  WINDOW w AS (PARTITION BY "counter" ORDER BY "value" DESC) 
  ORDER BY "counter", RANK() OVER w;
SELECT "counter", "value", SUM("value") OVER 
  (ORDER BY "id" ROWS 2 PRECEDING) 
    FROM "sample" 
  ORDER BY "id";
SELECT SUM("value") OVER 
  (ORDER BY "id" ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
    FROM "sample" 
  ORDER BY "id";
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<5)
  SELECT x, group_concat(x) OVER (ORDER BY x ROWS 2 PRECEDING)
  FROM c;
WITH t1(a,b) AS (VALUES(1,2))
  SELECT count() FILTER (where b<>5) OVER w1
    FROM t1
    WINDOW w1 AS (ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
WITH t1(a,b) AS ( VALUES(1, 2), (2, 3), (3, 4) )
    SELECT nth_value(b, 1) OVER (ORDER BY a) FROM t1;
WITH t1(a,b) AS ( VALUES(1, 2), (2, 3), (3, 4) )
    SELECT nth_value(b, 2) OVER (ORDER BY a) FROM t1;
WITH t1(a,b) AS ( VALUES(1, 2), (2, 3), (3, 4) )
    SELECT nth_value(b, '2') OVER (ORDER BY a) FROM t1;
WITH t1(a,b) AS ( VALUES(1, 2), (2, 3), (3, 4) )
    SELECT nth_value(b, 2.0) OVER (ORDER BY a) FROM t1;
WITH t1(a,b) AS ( VALUES(1, 2), (2, 3), (3, 4) )
    SELECT nth_value(b, '2.0') OVER (ORDER BY a) FROM t1;
WITH t1(a,b) AS ( VALUES(1, 2), (2, 3), (3, 4) )
    SELECT nth_value(b, 10000000) OVER (ORDER BY a) FROM t1;
CREATE TABLE t3(x INT, y VARCHAR);
INSERT INTO t3(x,y) VALUES(10,'ten'),('15','fifteen'),(30,'thirty');
SELECT y, group_concat(y, '.') OVER win FROM t3
  WINDOW win AS (
    ORDER BY y RANGE BETWEEN UNBOUNDED PRECEDING AND 10 PRECEDING
  );
