CREATE INDEX i1 ON t1(a);
SELECT * FROM t1 WHERE a IN ('aaa', 'bbb', 'ccc');
INSERT INTO t1 VALUES('aaa', 1);
INSERT INTO t1 VALUES('ddd', 2);
INSERT INTO t1 VALUES('ccc', 3);
INSERT INTO t1 VALUES('eee', 4);
SELECT b FROM t1 WHERE a IN ('aaa', 'bbb', 'ccc');
SELECT a FROM t1 WHERE rowid IN (1, 3);
SELECT a FROM t1 WHERE rowid IN ();
SELECT a FROM t1 WHERE a IN ('ddd');
CREATE TABLE t2(a INTEGER PRIMARY KEY, b TEXT);
INSERT INTO t2 VALUES(-1, '-one');
INSERT INTO t2 VALUES(0, 'zero');
INSERT INTO t2 VALUES(1, 'one');
INSERT INTO t2 VALUES(2, 'two');
INSERT INTO t2 VALUES(3, 'three');
SELECT b FROM t2 WHERE a IN (0, 2);
SELECT b FROM t2 WHERE a IN (2, 0);
SELECT b FROM t2 WHERE a IN (2, -1);
SELECT b FROM t2 WHERE a IN (NULL, 3);
SELECT b FROM t2 WHERE a IN (1.0, 2.1);
SELECT b FROM t2 WHERE a IN ('1', '2');
SELECT b FROM t2 WHERE a IN ('', '0.0.0', '2');
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(x, id);
CREATE TABLE t2(x, id);
INSERT INTO t1 VALUES(NULL, NULL);
INSERT INTO t1 VALUES(0, NULL);
INSERT INTO t1 VALUES(1, 3);
INSERT INTO t1 VALUES(2, 4);
INSERT INTO t1 VALUES(3, 5);
INSERT INTO t1 VALUES(4, 6);
INSERT INTO t2 VALUES(0, NULL);
INSERT INTO t2 VALUES(4, 1);
INSERT INTO t2 VALUES(NULL, 1);
INSERT INTO t2 VALUES(NULL, NULL);
SELECT x FROM t1 WHERE id IN () AND x IN (SELECT x FROM t2 WHERE id=1);
CREATE TABLE t3(x, y, z);
CREATE INDEX t3i1 ON t3(x, y);
INSERT INTO t3 VALUES(1, 1, 1);
INSERT INTO t3 VALUES(10, 10, 10);
SELECT * FROM t3 WHERE x IN ();
SELECT * FROM t3 WHERE x = 10 AND y IN ();
SELECT * FROM t3 WHERE x IN () AND y = 10;
SELECT * FROM t3 WHERE x IN () OR x = 10;
SELECT * FROM t3 WHERE y IN ();
SELECT x IN() AS a FROM t3 WHERE a;
SELECT x IN() AS a FROM t3 WHERE NOT a;
SELECT * FROM t3 WHERE oid IN ();
SELECT * FROM t3 WHERE x IN (1, 2) OR y IN ();
SELECT * FROM t3 WHERE x IN (1, 2) AND y IN ();
SELECT * FROM t3 WHERE x=10 AND y IN (10);
SELECT * FROM t3 WHERE x IN (10) AND y=10;
SELECT * FROM t3 WHERE x IN (10) AND y IN (10);
SELECT * FROM t3 WHERE x=1 AND y NOT IN (10);
SELECT * FROM t3 WHERE x  NOT IN (10) AND y=1;
SELECT * FROM t3 WHERE x NOT IN (10) AND y NOT IN (10);
DROP INDEX t3i1;
CREATE UNIQUE INDEX t3xy ON t3(x,y);
SELECT *, '|' FROM t3 A, t3 B
   WHERE A.x=10 AND A.y IN (10)
     AND B.x=1 AND B.y IN (1);
EXPLAIN QUERY PLAN
  SELECT *, '|' FROM t3 A, t3 B
   WHERE A.x=10 AND A.y IN (10)
     AND B.x=1 AND B.y IN (1);
SELECT *, '|' FROM t3 A, t3 B
   WHERE A.x IN (10) AND A.y=10
     AND B.x IN (1) AND B.y=1;
EXPLAIN QUERY PLAN
  SELECT *, '|' FROM t3 A, t3 B
   WHERE A.x IN (10) AND A.y=10
     AND B.x IN (1) AND B.y=1;
SELECT * FROM t3 WHERE x IN (10,11);
EXPLAIN
  SELECT * FROM t3 WHERE x IN (10,11);
SELECT * FROM t3 WHERE x IN (10);
SELECT * FROM t3 WHERE x NOT IN (10,11,99999);
EXPLAIN
  SELECT * FROM t3 WHERE x NOT IN (10,11,99999);
SELECT * FROM t3 WHERE x NOT IN (10);
EXPLAIN
  SELECT * FROM t3 WHERE x NOT IN (10);
CREATE TABLE t4a(a TEXT, b TEXT COLLATE nocase, c);
INSERT INTO t4a VALUES('ABC','abc',1);
INSERT INTO t4a VALUES('def','xyz',2);
INSERT INTO t4a VALUES('ghi','ghi',3);
SELECT c FROM t4a WHERE a=b ORDER BY c;
SELECT c FROM t4a WHERE b=a ORDER BY c;
SELECT c FROM t4a WHERE (a||'')=b ORDER BY c;
SELECT c FROM t4a WHERE (a||'')=(b||'') ORDER BY c;
SELECT c FROM t4a WHERE a IN (b) ORDER BY c;
SELECT c FROM t4a WHERE (a||'') IN (b) ORDER BY c;
CREATE TABLE t4b(a TEXT, b NUMERIC, c);
INSERT INTO t4b VALUES('1.0',1,4);
SELECT c FROM t4b WHERE a=b;
SELECT c FROM t4b WHERE b=a;
SELECT c FROM t4b WHERE +a=b;
SELECT c FROM t4b WHERE a=+b;
SELECT c FROM t4b WHERE +b=a;
SELECT c FROM t4b WHERE b=+a;
SELECT c FROM t4b WHERE a IN (b);
SELECT c FROM t4b WHERE b IN (a);
SELECT c FROM t4b WHERE +b IN (a);
CREATE TABLE t5(c INTEGER PRIMARY KEY, d TEXT COLLATE nocase);
INSERT INTO t5 VALUES(17, 'fuzz');
SELECT 1 FROM t5 WHERE 'fuzz' IN (d);
-- match
  SELECT 2 FROM t5 WHERE 'FUZZ' IN (d);
-- no match
  SELECT 3 FROM t5 WHERE d IN ('fuzz');
-- match
  SELECT 4 FROM t5 WHERE d IN ('FUZZ');
-- match;
CREATE TABLE t6a(a INTEGER PRIMARY KEY, b);
INSERT INTO t6a VALUES(1,2),(3,4),(5,6);
CREATE TABLE t6b(c INTEGER PRIMARY KEY, d);
INSERT INTO t6b VALUES(4,44),(5,55),(6,66);
SELECT * FROM t6a, t6b WHERE a=3 AND b IN (c);
EXPLAIN QUERY PLAN
  SELECT * FROM t6a, t6b WHERE a=3 AND b IN (c);
SELECT * FROM t6a, t6b WHERE a=3 AND c IN (b);
EXPLAIN QUERY PLAN
  SELECT * FROM t6a, t6b WHERE a=3 AND c IN (b);
INSERT INTO t1 VALUES(111, 'AAA'),(222, 'BBB'),(333, 'CCC');
ANALYZE sqlite_schema;
INSERT INTO sqlite_stat1 VALUES('t1', 't1y','100 1');
CREATE TABLE node(node_id INTEGER PRIMARY KEY);
CREATE TABLE edge(node_from INT, node_to INT);
CREATE TABLE sub_nodes(node_id INTEGER PRIMARY KEY);
CREATE INDEX edge_from_to ON edge(node_from,node_to);
CREATE INDEX edge_to_from ON edge(node_to,node_from);
ANALYZE;
DELETE FROM sqlite_stat1;
INSERT INTO sqlite_stat1 VALUES
    ('sub_nodes',NULL,'1000000'),
    ('edge','edge_to_from','20000000 2 2'),
    ('edge','edge_from_to','20000000 2 2'),
    ('node',NULL,'10000000');
ANALYZE sqlite_schema;
ANALYZE sqlite_schema;
INSERT INTO sqlite_stat1 VALUES('t1','t1','10 3 2 1');
ANALYZE sqlite_schema;
PRAGMA reverse_unordered_selects(1);
ANALYZE sqlite_schema;
INSERT INTO sqlite_stat1 VALUES('t1','t1abc','10000 5 00 2003ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ 10');
ANALYZE sqlite_schema;
ANALYZE sqlite_schema;
INSERT INTO sqlite_stat1 VALUES('t1','t1abc','358677 2 2 1');
INSERT INTO sqlite_stat1 VALUES('t1','t1bca','358677 4 2 1');
ANALYZE sqlite_schema;
ANALYZE sqlite_master;
INSERT INTO sqlite_stat1 VALUES('t1','t1x','84000 3 2 1');
PRAGMA writable_schema=RESET;