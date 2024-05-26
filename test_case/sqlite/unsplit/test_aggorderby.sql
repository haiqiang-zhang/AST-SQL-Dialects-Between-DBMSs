CREATE TABLE t1(a TEXT,b INT,c INT,d INT);
WITH RECURSIVE c(x) AS (VALUES(0) UNION ALL SELECT x+1 FROM c WHERE x<9)
  INSERT INTO t1(a,b,c,d) SELECT printf('%d',(x*7)%10),1,x,10-x FROM c;
INSERT INTO t1(a,b,c,d) SELECT a, 2, c, 10-d FROM t1;
CREATE INDEX t1b ON t1(b);
SELECT group_concat(a ORDER BY a) FROM t1 WHERE b=1;
SELECT string_agg(a, ',' ORDER BY b DESC, d) FROM t1;
SELECT count(ORDER BY a) FROM t1;
SELECT c, max(a ORDER BY a) FROM t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t3;
CREATE TABLE t1(a TEXT);
INSERT INTO t1 VALUES('aaa'),('bbb');
CREATE TABLE t3(d TEXT);
INSERT INTO t3 VALUES('/'),('-');
SELECT (SELECT string_agg(a,d) FROM t3) FROM t1;
SELECT (SELECT group_concat(a,d ORDER BY d) FROM t3) FROM t1;
SELECT (SELECT string_agg(a,d ORDER BY d DESC) FROM t3) FROM t1;
SELECT (SELECT string_agg(a,'#' ORDER BY d) FROM t3) FROM t1;
WITH c(x) AS (VALUES('abc'),('DEF'),('xyz'),('ABC'),('XYZ'))
  SELECT string_agg(x,',' ORDER BY x COLLATE nocase),
         string_agg(x,',' ORDER BY x) FROM c;
WITH c(x,y) AS (VALUES(1,'a'),(2,'B'),(3,'c'),(4,'D'))
  SELECT group_concat(x ORDER BY y COLLATE nocase),
         group_concat(x ORDER BY y COLLATE binary) FROM c;
WITH c(x) AS (VALUES(1),(NULL),(2.5),(NULL),('three'))
  SELECT json_group_array(x ORDER BY x NULLS FIRST),
         json_group_array(x ORDER BY x NULLS LAST) FROM c;
WITH c(x,y) AS (VALUES(1,1),(2,2),(3,3),(3,4),(3,5),(3,6))
  SELECT sum(DISTINCT x ORDER BY y) FROM c;
