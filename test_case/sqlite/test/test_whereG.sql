EXPLAIN QUERY PLAN 
  SELECT DISTINCT aname
    FROM album, composer, track
   WHERE unlikely(cname LIKE '%bach%')
     AND composer.cid=track.cid
     AND album.aid=track.aid;
SELECT DISTINCT aname
    FROM album, composer, track
   WHERE unlikely(cname LIKE '%bach%')
     AND composer.cid=track.cid
     AND album.aid=track.aid;
EXPLAIN QUERY PLAN 
  SELECT DISTINCT aname
    FROM album, composer, track
   WHERE likelihood(cname LIKE '%bach%', 0.5)
     AND composer.cid=track.cid
     AND album.aid=track.aid;
SELECT DISTINCT aname
    FROM album, composer, track
   WHERE likelihood(cname LIKE '%bach%', 0.5)
     AND composer.cid=track.cid
     AND album.aid=track.aid;
EXPLAIN QUERY PLAN 
  SELECT DISTINCT aname
    FROM album, composer, track
   WHERE cname LIKE '%bach%'
     AND composer.cid=track.cid
     AND album.aid=track.aid;
SELECT DISTINCT aname
    FROM album, composer, track
   WHERE cname LIKE '%bach%'
     AND composer.cid=track.cid
     AND album.aid=track.aid;
EXPLAIN QUERY PLAN 
  SELECT DISTINCT aname
    FROM album, composer, track
   WHERE cname LIKE '%bach%'
     AND unlikely(composer.cid=track.cid)
     AND unlikely(album.aid=track.aid);
SELECT DISTINCT aname
    FROM album, composer, track
   WHERE cname LIKE '%bach%'
     AND unlikely(composer.cid=track.cid)
     AND unlikely(album.aid=track.aid);
CREATE TABLE a(a1 PRIMARY KEY, a2);
CREATE TABLE b(b1 PRIMARY KEY, b2);
EXPLAIN QUERY PLAN 
  SELECT * FROM a, b WHERE b1=a1 AND a2=5;
EXPLAIN QUERY PLAN 
  SELECT * FROM a, b WHERE a1=b1 AND a2=5;
EXPLAIN QUERY PLAN 
  SELECT * FROM a, b WHERE a2=5 AND b1=a1;
EXPLAIN QUERY PLAN 
  SELECT * FROM a, b WHERE a2=5 AND a1=b1;
CREATE TABLE t4(x);
INSERT INTO t4 VALUES('right'),('wrong');
SELECT DISTINCT x
   FROM (SELECT x FROM t4 GROUP BY x)
   WHERE x='right'
   ORDER BY x;
CREATE TABLE t1(a, b, c);
CREATE INDEX i1 ON t1(a, b);
INSERT INTO t1 SELECT 'def', b, c FROM t1;
ANALYZE;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(i int, x, y, z);
INSERT INTO t1 VALUES (1,1,1,1), (2,2,2,2), (3,3,3,3), (4,4,4,4);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2(i int, bool char);
INSERT INTO t2 VALUES(1,'T'), (2,'F');
SELECT count(*) FROM t1 LEFT JOIN t2 ON t1.i=t2.i AND bool='T';
SELECT count(*) FROM t1 LEFT JOIN t2 ON likely(t1.i=t2.i) AND bool='T';
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a, b, PRIMARY KEY(a,b));
INSERT INTO t1 VALUES(9,1),(1,2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2(x, y, PRIMARY KEY(x,y));
INSERT INTO t2 VALUES(3,3),(4,4);
SELECT likely(a), x FROM t1, t2 ORDER BY 1, 2;
SELECT unlikely(a), x FROM t1, t2 ORDER BY 1, 2;
SELECT likelihood(a,0.5), x FROM t1, t2 ORDER BY 1, 2;
SELECT coalesce(a,a), x FROM t1, t2 ORDER BY 1, 2;
DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (c0);
INSERT INTO t0(c0) VALUES ('a');
SELECT LIKELY(t0.rowid) <= '0' FROM t0;
SELECT * FROM t0 WHERE LIKELY(t0.rowid) <= '0';
SELECT (t0.rowid) <= '0' FROM t0;
SELECT * FROM t0 WHERE (t0.rowid) <= '0';
SELECT unlikely(t0.rowid) <= '0', likelihood(t0.rowid,0.5) <= '0' FROM t0;
SELECT * FROM t0 WHERE unlikely(t0.rowid) <= '0';
SELECT * FROM t0 WHERE likelihood(t0.rowid, 0.5) <= '0';
SELECT unlikely(t0.rowid <= '0'),
         likely(t0.rowid <= '0'),
         likelihood(t0.rowid <= '0',0.5)
    FROM t0;
SELECT * FROM t0 WHERE unlikely(t0.rowid <= '0');
SELECT * FROM t0 WHERE likelihood(t0.rowid <= '0', 0.5);
CREATE VIEW v0(c2) AS SELECT CAST( (c0 IS TRUE) AS TEXT ) FROM t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a, b FLOAT);
INSERT INTO t1(a) VALUES(''),(NULL),('X'),(NULL);
CREATE TABLE c(d NUM);
CREATE VIEW f(g, h) AS SELECT b, 0 FROM a UNION SELECT d, d FROM c;
INSERT INTO t1 VALUES('AAA', 'BBB');
CREATE TABLE t3(x PRIMARY KEY, y);
INSERT INTO t3 VALUES('AAA', 'AAA');
SELECT * FROM t1 JOIN t2 ON x=y AND y='AAA';
INSERT INTO t1(a) VALUES(123);
CREATE INDEX t1x1 ON t1(likely(a));
SELECT typeof(likely(a)) FROM t1 NOT INDEXED;
CREATE INDEX t1x2 ON t1(abs(a));
